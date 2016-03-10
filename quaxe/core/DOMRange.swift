/**
 * Quaxe for Swift
 * 
 * Copyright 2016 Disruptive Innovations
 * 
 * Original author:
 *   Daniel Glazman <daniel.glazman@disruptive-innovations.com>
 *
 * Contributors:
 * 
 */

/**
 * https://dom.spec.whatwg.org/#interface-range
 * 
 * status: TODO 40%
 */
public class DOMRange: pDOMRange {

  internal var mStartContainer: pNode?
  internal var mStartOffset: ulong = 0
  internal var mEndContainer: pNode?
  internal var mEndOffset: ulong = 0

  /**
   * https://dom.spec.whatwg.org/#concept-range-select
   */
  internal func _selectNode(node: Node) throws -> Void {
    let parent = node.parentNode
    if parent == nil {
      throw Exception.InvalidNodeTypeError
    }

    let index = Trees.indexOf(node)
    mStartContainer = parent!
    mStartOffset = index
    mEndContainer = parent!
    mEndOffset = index + 1
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-startcontainer
   */
  public var startContainer: pNode { return mStartContainer! }

  /**
   * https://dom.spec.whatwg.org/#dom-range-startoffset
   */
  public var startOffset: ulong { return mStartOffset }

  /**
   * https://dom.spec.whatwg.org/#dom-range-endcontainer
   */
  public var endContainer: pNode { return mEndContainer! }

  /**
   * https://dom.spec.whatwg.org/#dom-range-endoffset
   */
  public var endOffset: ulong { return mEndOffset }

  /**
   * https://dom.spec.whatwg.org/#dom-range-collapsed
   */
  public var collapsed: Bool {
    return self.startContainer as! Node === self.endContainer as! Node &&
           self.startOffset == self.endOffset
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-commonancestorcontainer
   */
  public var commonAncestorContainer: pNode {
    var container: Node = self.startContainer as! Node
    while !Trees.isInclusiveAncestorOf(container, self.endContainer as! Node) {
      container = container.parentNode as! Node
    }
    return container
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-setstart
   */
  public func setStart(node: pNode, _ offset: ulong)  {
    self.mStartContainer = node
    self.mStartOffset = offset
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-setend
   */
  public func setEnd(node: pNode, _ offset: ulong)  {
    self.mEndContainer = node
    self.mEndOffset = offset
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-setstartbefore
   */
  public func setStartBefore(node: pNode) throws -> Void {
    if let parent = node.parentNode {
      self.setStart(parent, Trees.indexOf(node as! Node))
      return
    }

    throw Exception.InvalidNodeTypeError
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-setstartafter
   */
  public func setStartAfter(node: pNode) throws -> Void {
    if let parent = node.parentNode {
      self.setStart(parent, Trees.indexOf(node as! Node) + 1)
      return
    }

    throw Exception.InvalidNodeTypeError
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-setendbefore
   */
  public func setEndBefore(node: pNode) throws -> Void {
    if let parent = node.parentNode {
      self.setEnd(parent, Trees.indexOf(node as! Node))
      return
    }

    throw Exception.InvalidNodeTypeError
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-setendafter
   */
  public func setEndAfter(node: pNode) throws -> Void {
    if let parent = node.parentNode {
      self.setEnd(parent, Trees.indexOf(node as! Node) + 1)
      return
    }

    throw Exception.InvalidNodeTypeError
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-collapse
   */
  public func collapse(toStart: Bool = false) -> Void {
    if toStart {
      mEndContainer = mStartContainer
      mEndOffset = mStartOffset
    }
    else {
      mStartContainer = mEndContainer
      mStartOffset = mEndOffset
    }
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-selectnode
   */
  public func selectNode(node: pNode) throws -> Void {
    try self._selectNode(node as! Node)
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-selectnodecontents
   */
  public func selectNodeContents(node: pNode) throws -> Void {
    if node.nodeType == Node.DOCUMENT_TYPE_NODE {
      throw Exception.InvalidNodeTypeError
    }

    let length = Trees.length(node as! Node)
    mStartContainer = node
    mStartOffset = 0
    mEndContainer = node
    mEndOffset = length
  }

  static let START_TO_START: ushort = 0
  static let START_TO_END: ushort   = 1
  static let END_TO_END: ushort     = 2
  static let END_TO_START: ushort   = 3

  static let POSITION_EQUAL: short =   0
  static let POSITION_BEFORE: short = -1
  static let POSITION_AFTER: short =  +1

  /*
   * https://dom.spec.whatwg.org/#concept-range-bp-position
   */
  internal func _relativePosition(nodeA: Node, _ offsetA: ulong, _ nodeB: Node, _ offsetB: ulong) -> short {
    if nodeA === nodeB {
      if offsetA == offsetB {
        return 0
      }
      if offsetA < offsetB {
        return -1
      }
      return +1
    }

    if Trees.isFollowing(nodeA, nodeB) {
      let position = self._relativePosition(nodeB, offsetB, nodeA, offsetA)
      if position == DOMRange.POSITION_BEFORE {
        return DOMRange.POSITION_AFTER
      }
      if position == DOMRange.POSITION_AFTER {
        return DOMRange.POSITION_BEFORE
      }
    }

    if Trees.isAncestorOf(nodeA, nodeB) {
      var child: pNode = nodeB
      while child.parentNode as! Node !== nodeA {
        child = child.parentNode!
      }
      if Trees.indexOf(child as! Node) < offsetA {
        return DOMRange.POSITION_AFTER
      }
    }

    return DOMRange.POSITION_BEFORE
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-compareboundarypoints
   */
  public func compareBoundaryPoints(how: ushort, _ sourceRange: pDOMRange) throws -> short {
    if how != DOMRange.START_TO_START &&
       how != DOMRange.START_TO_END &&
       how != DOMRange.END_TO_END &&
       how != DOMRange.END_TO_START {
      throw Exception.NotSupportedError
    }

    if Trees.getRootOf(mStartContainer as! Node) !== Trees.getRootOf(sourceRange.startContainer as! Node) {
      throw Exception.WrongDocumentError
    }

    var thisPointNode: Node
    var thisPointOffset: ulong
    var otherPointNode: Node
    var otherPointOffset: ulong
    switch how {
      case DOMRange.START_TO_START:
        thisPointNode = mStartContainer as! Node
        thisPointOffset = mStartOffset
        otherPointNode = sourceRange.startContainer as! Node
        otherPointOffset = sourceRange.startOffset
      case DOMRange.START_TO_END:
        thisPointNode = mEndContainer as! Node
        thisPointOffset = mEndOffset
        otherPointNode = sourceRange.startContainer as! Node
        otherPointOffset = sourceRange.startOffset
      case DOMRange.END_TO_END:
        thisPointNode = mEndContainer as! Node
        thisPointOffset = mEndOffset
        otherPointNode = sourceRange.endContainer as! Node
        otherPointOffset = sourceRange.endOffset
      case DOMRange.END_TO_START:
        thisPointNode = mStartContainer as! Node
        thisPointOffset = mStartOffset
        otherPointNode = sourceRange.endContainer as! Node
        otherPointOffset = sourceRange.endOffset
      default: throw Exception.NotSupportedError
    }

    return self._relativePosition(thisPointNode, thisPointOffset,
                                  otherPointNode, otherPointOffset)
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-deletecontents
   */
  public func deleteContents() throws -> Void {
    // Step 1
    if self.collapsed {
      return
    }

    // Step 2
    let originalStartNode = self.startContainer
    let originalStartOffset = self.startOffset
    let originalEndNode = self.endContainer
    let originalEndOffset = self.endOffset

    // Step 3
    if originalStartNode as! Node === originalEndNode as! Node &&
       (originalStartNode.nodeType == Node.TEXT_NODE ||
        originalStartNode.nodeType == Node.COMMENT_NODE ||
        originalStartNode.nodeType == Node.PROCESSING_INSTRUCTION_NODE) {
      try CharacterData._replaceData(originalStartNode as! CharacterData, originalStartOffset, originalEndOffset - originalStartOffset, "")
      return
    }

    // Step 4
    var nodesToRemove: Array<pNode> = []
    var node = self.startContainer.nodeType == Node.TEXT_NODE
                 ? self.startContainer
                 : self.startContainer.childNodes.item(self.startOffset)
    let endNode = self.endContainer.nodeType == Node.TEXT_NODE
                 ? self.endContainer
                 : self.endContainer.childNodes.item(self.endOffset)
    while nil != node {
      if Trees.getRootOf(node as! Node) === Trees.getRootOf(self.startContainer as! Node) &&
         self._relativePosition(node as! Node, 0,
                                self.startContainer as! Node, self.startOffset) == DOMRange.POSITION_AFTER &&
         self._relativePosition(node as! Node, Trees.length(node as! Node),
                                self.endContainer as! Node, self.endOffset) == DOMRange.POSITION_BEFORE {
        nodesToRemove.append(node!)
        node = Trees.nextInTraverseOrder(node as! Node)
        if node as? Node === endNode as! Node {
          node = nil
        }
      }
    }

    // Step 5
    let newNode: pNode
    let newOffset: ulong
    if Trees.isInclusiveAncestorOf(originalStartNode as! Node, originalEndNode as! Node) {
      newNode = originalStartNode
      newOffset = originalStartOffset
    }
    else { // Step 6
      // Step 6.1
      var referenceNode: pNode? = originalStartNode
      // Step 6.2
      while referenceNode!.parentNode != nil &&
            !Trees.isInclusiveAncestorOf(referenceNode!.parentNode as! Node, originalEndNode as! Node) {
        referenceNode = referenceNode!.parentNode
      }
      // Step 6.3
      newNode = referenceNode!.parentNode!
      newOffset = Trees.indexOf(referenceNode as! Node)
    }

    // Step 7
    if originalStartNode.nodeType == Node.TEXT_NODE ||
       originalStartNode.nodeType == Node.COMMENT_NODE ||
       originalStartNode.nodeType == Node.PROCESSING_INSTRUCTION_NODE {
      try CharacterData._replaceData(originalStartNode as! CharacterData,
                                     originalStartOffset,
                                     Trees.length(originalStartNode as! Node) - originalStartOffset,
                                     "")
    }

    // Step 8
    for node in nodesToRemove {
      Trees.remove(node as! Node, (node as! Node).parentNode as! Node)
    }

    // Step 9
    if originalEndNode.nodeType == Node.TEXT_NODE ||
       originalEndNode.nodeType == Node.COMMENT_NODE ||
       originalEndNode.nodeType == Node.PROCESSING_INSTRUCTION_NODE {
      try CharacterData._replaceData(originalEndNode as! CharacterData,
                                     0,
                                     originalEndOffset,
                                     "")
    }

    // Step 10
    self.setStart(newNode, newOffset)
    self.setEnd(newNode, newOffset)
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-extractcontents
   */
  public func extractContents() -> pDocumentFragment { return DocumentFragment()}
  public func cloneContents() -> pDocumentFragment { return DocumentFragment()}
  public func insertNode(node: pNode) -> Void {}
  public func surroundContents(node: pNode) -> Void {}

  public func cloneRange() -> pDOMRange {return DOMRange()}
  public func detach() -> Void {}

  public func isPointInRange(node: pNode, offset: ulong) -> Bool {return false}
  public func comparePoint(node: pNode, offset: ulong) -> short {return 0}

  public func intersectsNode(node: pNode) -> Bool {return false}

  public func toString() -> DOMString {return ""}

  init() {}

  // we absolutely need the deiniter because the documents holds a collection
  // of existing ranges and we need to clean that up when the range is deleted
  deinit {}
}
