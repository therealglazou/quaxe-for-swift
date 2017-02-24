/**
 * Quaxe for Swift
 * 
 * Copyright 2016-2017 Disruptive Innovations
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
 * status: done
 */
public class DOMRange: pDOMRange {

  internal var mStartContainer: pNode?
  internal var mStartOffset: ulong = 0
  internal var mEndContainer: pNode?
  internal var mEndOffset: ulong = 0

  /**
   * https://dom.spec.whatwg.org/#concept-range-select
   */
  internal func _selectNode(_ node: Node) throws -> Void {
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
  public func setStart(_ node: pNode, _ offset: ulong)  {
    self.mStartContainer = node
    self.mStartOffset = offset
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-setend
   */
  public func setEnd(_ node: pNode, _ offset: ulong)  {
    self.mEndContainer = node
    self.mEndOffset = offset
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-setstartbefore
   */
  public func setStartBefore(_ node: pNode) throws -> Void {
    if let parent = node.parentNode {
      self.setStart(parent, Trees.indexOf(node as! Node))
      return
    }

    throw Exception.InvalidNodeTypeError
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-setstartafter
   */
  public func setStartAfter(_ node: pNode) throws -> Void {
    if let parent = node.parentNode {
      self.setStart(parent, Trees.indexOf(node as! Node) + 1)
      return
    }

    throw Exception.InvalidNodeTypeError
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-setendbefore
   */
  public func setEndBefore(_ node: pNode) throws -> Void {
    if let parent = node.parentNode {
      self.setEnd(parent, Trees.indexOf(node as! Node))
      return
    }

    throw Exception.InvalidNodeTypeError
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-setendafter
   */
  public func setEndAfter(_ node: pNode) throws -> Void {
    if let parent = node.parentNode {
      self.setEnd(parent, Trees.indexOf(node as! Node) + 1)
      return
    }

    throw Exception.InvalidNodeTypeError
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-collapse
   */
  public func collapse(_ toStart: Bool = false) -> Void {
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
  public func selectNode(_ node: pNode) throws -> Void {
    try self._selectNode(node as! Node)
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-selectnodecontents
   */
  public func selectNodeContents(_ node: pNode) throws -> Void {
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
  internal func _relativePosition(_ nodeA: Node, _ offsetA: ulong, _ nodeB: Node, _ offsetB: ulong) -> short {
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
  public func compareBoundaryPoints(_ how: ushort, _ sourceRange: pDOMRange) throws -> short {
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
        let index = nodesToRemove.index(where: { $0 as! Node === node!.parentNode as! Node})
        if index == nil {
          nodesToRemove.append(node!)
        }
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
   * https://dom.spec.whatwg.org/#concept-range-extract
   */
  internal func _extract(_ forCloning: Bool = false) throws -> pDocumentFragment {
    // Step 1
    let fragment = self.mStartContainer!.ownerDocument!.createDocumentFragment()

    // Step 2
    if self.collapsed {
      return fragment
    }

    // Step 3
    let originalStartNode = self.startContainer
    let originalStartOffset = self.startOffset
    let originalEndNode = self.endContainer
    let originalEndOffset = self.endOffset

    // Step 4
    if originalStartNode as! Node === originalEndNode as! Node &&
       (originalEndNode.nodeType == Node.TEXT_NODE ||
        originalEndNode.nodeType == Node.COMMENT_NODE ||
        originalEndNode.nodeType == Node.PROCESSING_INSTRUCTION_NODE) {
      // Step 4.1
      let clone = (originalStartNode as! Node).cloneNode()
      // Step 4.2
      if !forCloning {
        (clone as! CharacterData).data =
            try CharacterData._substringData(originalStartNode as! CharacterData,
                                             originalStartOffset,
                                             originalEndOffset - originalStartOffset)
      }
      // Step 4.3
      Trees.append(clone as! Node, fragment as! Node)
      return fragment
    }

    // Step 5
    var commonAncestor = originalStartNode

    // Step 6
    while !Trees.isInclusiveAncestorOf(commonAncestor as! Node, originalEndNode as! Node) {
      commonAncestor = (commonAncestor as! Node).parentNode!
    }

    // Step 7
    var firstPartiallyContainedChild: pNode? = nil

    // Step 8
    if !Trees.isInclusiveAncestorOf(originalStartNode as! Node, originalEndNode as! Node) {
      var child = commonAncestor.firstChild
      while child != nil && firstPartiallyContainedChild == nil {
        if (Trees.isInclusiveAncestorOf(child as! Node, originalStartNode as! Node) &&
            !Trees.isInclusiveAncestorOf(child as! Node, originalEndNode as! Node)) ||
           (Trees.isInclusiveAncestorOf(child as! Node, originalEndNode as! Node) &&
            !Trees.isInclusiveAncestorOf(child as! Node, originalStartNode as! Node)) {
          firstPartiallyContainedChild = child
        }
        child = child!.nextSibling
      }
    }

    // Step 9
    var lastPartiallyContainedChild: pNode? = nil

    // Step 10
    if !Trees.isInclusiveAncestorOf(originalEndNode as! Node, originalStartNode as! Node) {
      var child = commonAncestor.lastChild
      while child != nil && lastPartiallyContainedChild == nil {
        if (Trees.isInclusiveAncestorOf(child as! Node, originalStartNode as! Node) &&
            !Trees.isInclusiveAncestorOf(child as! Node, originalEndNode as! Node)) ||
           (Trees.isInclusiveAncestorOf(child as! Node, originalEndNode as! Node) &&
            !Trees.isInclusiveAncestorOf(child as! Node, originalStartNode as! Node)) {
          lastPartiallyContainedChild = child
        }
        child = child!.previousSibling
      }
    }

    // Step 11
    var containedChildren: Array<pNode> = []
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
        containedChildren.append(node!)
        node = Trees.nextInTraverseOrder(node as! Node)
        if node as? Node === endNode as! Node {
          node = nil
        }
      }
    }

    // Step 12
    for containedChild in containedChildren {
      if containedChild.nodeType == Node.DOCUMENT_TYPE_NODE {
        throw Exception.HierarchyRequestError
      }
    }

    // Step 13
    var newNode: pNode = originalStartNode
    var newOffset: ulong = originalStartOffset
    if !forCloning {
      if Trees.isInclusiveAncestorOf(originalStartNode as! Node, originalEndNode as! Node) {
        newNode = originalStartNode
        newOffset = originalStartOffset
      }
      else {
        // Step 14
        var referenceNode = originalStartNode
        while referenceNode.parentNode != nil &&
              !Trees.isInclusiveAncestorOf(referenceNode.parentNode as! Node, originalEndNode as! Node) {
          referenceNode = referenceNode.parentNode!
        }
        newNode = referenceNode.parentNode!
        newOffset = Trees.indexOf(referenceNode as! Node) + 1
      }
    }

    // Step 15
    if firstPartiallyContainedChild != nil &&
       (firstPartiallyContainedChild!.nodeType == Node.TEXT_NODE ||
        firstPartiallyContainedChild!.nodeType == Node.COMMENT_NODE ||
        firstPartiallyContainedChild!.nodeType == Node.PROCESSING_INSTRUCTION_NODE) {
      let clone = (originalStartNode as! Node)._clone(nil, false)
      (clone as! CharacterData).data = try CharacterData._substringData(
                                         originalStartNode as! CharacterData,
                                         originalStartOffset,
                                         (originalStartNode as! CharacterData).length  - originalStartOffset)
      Trees.append(clone, fragment as! Node)
      if !forCloning {
        try CharacterData._replaceData(originalStartNode as! CharacterData,
                                       originalStartOffset,
                                       (originalStartNode as! CharacterData).length  - originalStartOffset,
                                       "")
      }
    }
    else if firstPartiallyContainedChild != nil {
      // Step 16.1
      let clone = (originalStartNode as! Node)._clone(nil, false)
      // Step 16.2
      Trees.append(clone, fragment as! Node)
      // Step 16.3
      let subrange = originalStartNode.ownerDocument!.createRange() as! DOMRange
      subrange.mStartContainer = originalStartNode
      subrange.mStartOffset = originalStartOffset
      subrange.mEndContainer = firstPartiallyContainedChild!
      subrange.mStartOffset = Trees.length(firstPartiallyContainedChild as! Node)
      // Step 16.4
      let subfragment = try subrange._extract(forCloning)
      // Step 16.5
      Trees.append(subfragment as! Node, clone)
    }

    // Step 17
    for containedChild in containedChildren {
      if forCloning {
        let clone = (containedChild as! Node)._clone(nil, true)
        Trees.append(clone, fragment as! Node)
      }
      else {
        Trees.append(containedChild as! Node, fragment as! Node)
      }
    }

    // Step 18
    if lastPartiallyContainedChild != nil &&
       (lastPartiallyContainedChild!.nodeType == Node.TEXT_NODE ||
        lastPartiallyContainedChild!.nodeType == Node.COMMENT_NODE ||
        lastPartiallyContainedChild!.nodeType == Node.PROCESSING_INSTRUCTION_NODE) {
      // Step 18.1
      let clone = (originalEndNode as! Node)._clone(nil, false)
      (clone as! CharacterData).data = try CharacterData._substringData(
                                         originalEndNode as! CharacterData,
                                         0,
                                         originalEndOffset)
      Trees.append(clone, fragment as! Node)
      if !forCloning {
        try CharacterData._replaceData(originalEndNode as! CharacterData,
                                       0,
                                       originalEndOffset,
                                       "")
      }
    }
    else if lastPartiallyContainedChild != nil {
      // Step 19.1
      let clone = (originalEndNode as! Node)._clone(nil, false)
      // Step 19.2
      Trees.append(clone, fragment as! Node)
      // Step 19.3
      let subrange = originalEndNode.ownerDocument!.createRange() as! DOMRange
      subrange.mStartContainer = lastPartiallyContainedChild!
      subrange.mStartOffset = 0
      subrange.mEndContainer = originalEndNode
      subrange.mStartOffset = originalEndOffset
      // Step 19.4
      let subfragment = try subrange._extract(forCloning)
      // Step 19.5
      Trees.append(subfragment as! Node, clone)
    }

    // Step 20
    if !forCloning {
      self.setStart(newNode, newOffset)
      self.setEnd(newNode, newOffset)
    }

    // Step 21
    return fragment
  }
  
  /**
   * https://dom.spec.whatwg.org/#dom-range-extractcontents
   */
  public func extractContents() throws -> pDocumentFragment {
    return try self._extract(false)
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-clonecontents
   */
  public func cloneContents() throws -> pDocumentFragment {
    return try self._extract(true)
  }

  /**
   * https://dom.spec.whatwg.org/#concept-range-insert
   */
  internal func _insertNode(_ node: pNode) throws -> Void {
    // Step 1
    if self.startContainer.nodeType == Node.PROCESSING_INSTRUCTION_NODE ||
       self.startContainer.nodeType == Node.COMMENT_NODE ||
       (self.startContainer.nodeType == Node.TEXT_NODE &&
        self.startContainer.parentNode == nil) ||
       self.startContainer as! Node === node as! Node {
      throw Exception.HierarchyRequestError
    }

    // Step 2
    var referenceNode: pNode? = nil

    // Step 3
    if self.startContainer.nodeType == Node.TEXT_NODE {
      referenceNode = self.startContainer
    }
    else {
      // Step 4
      referenceNode = self.startContainer.childNodes.item(self.startOffset)
    }

    // Step 5
    let parent = (referenceNode == nil)
                   ? self.startContainer
                   : referenceNode!.parentNode

    // Step 6
    try MutationAlgorithms.ensurePreInsertionValidity(node as! Node, parent as! Node, referenceNode as? Node)

    // Step 7
    if self.startContainer.nodeType == Node.TEXT_NODE {
      referenceNode = (self.startContainer as! Text).splitText(self.startOffset)
    }

    // Step 8
    if node as! Node === referenceNode as? Node {
      referenceNode = referenceNode!.nextSibling
    }

    // Step 9
    if node.parentNode != nil {
      MutationAlgorithms.remove(node as! Node, node.parentNode as! Node)
    }

    // Step 10
    var newOffset = (referenceNode == nil)
                      ? Trees.length(parent as! Node)
                      : Trees.indexOf(referenceNode as! Node)

    // Step 11
    newOffset += (node.nodeType == Node.DOCUMENT_FRAGMENT_NODE)
                   ? Trees.length(node as! Node)
                   : 1

    // Step 12
    try MutationAlgorithms.preInsert(node as! Node, parent as! Node, referenceNode as? Node)

    // Step 13
    if self.collapsed {
      self.setEnd(parent as! Node, newOffset)
    }
  }

  /*
   * https://dom.spec.whatwg.org/#dom-range-insertnode
   */
  public func insertNode(_ node: pNode) throws -> Void {
    try self._insertNode(node)
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-surroundcontents
   */
  public func surroundContents(_ newParent: pNode) throws -> Void {
    // Step 1
    if self.startContainer.nodeType == Node.PROCESSING_INSTRUCTION_NODE ||
       self.startContainer.nodeType == Node.COMMENT_NODE ||
       self.endContainer.nodeType == Node.PROCESSING_INSTRUCTION_NODE ||
       self.endContainer.nodeType == Node.COMMENT_NODE {
      throw Exception.InvalidStateError
    }

    // Step 2
    if newParent.nodeType == Node.DOCUMENT_NODE ||
       newParent.nodeType == Node.DOCUMENT_TYPE_NODE ||
       newParent.nodeType == Node.DOCUMENT_FRAGMENT_NODE {
      throw Exception.InvalidNodeTypeError
    }

    // Step 3
    let fragment = try self._extract(false)

    // Step 4
    if newParent.hasChildNodes() {
      try MutationAlgorithms.replaceAll(nil, newParent as! Node)
    }

    // Step 5
    try self._insertNode(newParent as! Node)

    // Step 6
    try MutationAlgorithms.append(fragment as! Node, newParent as! Node)

    // Step 7
    try self._selectNode(newParent as! Node)
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-clonerange
   */
  public func cloneRange() -> pDOMRange {
    let range = self.startContainer.ownerDocument!.createRange() as! DOMRange
    range.mStartContainer = self.mStartContainer
    range.mStartOffset = self.mStartOffset
    range.mEndContainer = self.mEndContainer
    range.mEndOffset = self.mEndOffset
    return range
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-detach
   */
  public func detach() -> Void {}

  /**
   * https://dom.spec.whatwg.org/#dom-range-ispointinrange
   */
  public func isPointInRange(_ node: pNode, offset: ulong) throws -> Bool {
    // Step 1
    if Trees.getRootOf(node as! Node) !== Trees.getRootOf(self.startContainer as! Node) {
      return false
    }

    // Step 2
    if node.nodeType == Node.DOCUMENT_TYPE_NODE {
      throw Exception.InvalidNodeTypeError
    }

    // Step 3
    if offset > Trees.length(node as! Node) {
      throw Exception.IndexSizeError
    }

    // Step 4
    if self._relativePosition(node as! Node, offset, self.startContainer as! Node, self.startOffset) == DOMRange.POSITION_BEFORE ||
       self._relativePosition(node as! Node, offset, self.endContainer as! Node, self.endOffset) == DOMRange.POSITION_AFTER {
      return false
    }

    // Step 5
    return true
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-comparepoint
   */
  public func comparePoint(_ node: pNode, offset: ulong) throws -> short {
    // Step 1
    if Trees.getRootOf(node as! Node) !== Trees.getRootOf(self.startContainer as! Node) {
      throw Exception.WrongDocumentError
    }

    // Step 2
    if node.nodeType == Node.DOCUMENT_TYPE_NODE {
      throw Exception.InvalidNodeTypeError
    }

    // Step 3
    if offset > Trees.length(node as! Node) {
      throw Exception.IndexSizeError
    }

    // Step 4
    if self._relativePosition(node as! Node, offset, self.startContainer as! Node, self.startOffset) == DOMRange.POSITION_BEFORE {
      return -1
    }

    // Step 5
    if self._relativePosition(node as! Node, offset, self.endContainer as! Node, self.endOffset) == DOMRange.POSITION_AFTER {
      return +1
    }

    return 0
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-intersectsnode
   */
  public func intersectsNode(_ node: pNode) -> Bool {
    // Step 1
    if Trees.getRootOf(node as! Node) !== Trees.getRootOf(self.startContainer as! Node) {
      return false
    }

    // Step 2
    let parent = node.parentNode

    // Step 3
    if parent == nil {
      return true
    }

    // Step 4
    let offset = Trees.indexOf(node as! Node)

    // Step 5
    if self._relativePosition(parent as! Node, offset, self.endContainer as! Node, self.endOffset) == DOMRange.POSITION_BEFORE &&
       self._relativePosition(parent as! Node, offset + 1, self.startContainer as! Node, self.startOffset) == DOMRange.POSITION_AFTER {
      return true
    }

    // Step 6
    return false
  }

  /**
   * https://dom.spec.whatwg.org/#dom-range-stringifier
   */
  public func toString() -> DOMString {
    // Step 1
    var s = ""

    // Step 2
    if self.startContainer as! Node === self.endContainer as! Node &&
       self.startContainer.nodeType == Node.TEXT_NODE {
      do {
        return try CharacterData._substringData(self.startContainer as! CharacterData,
                                                self.startOffset,
                                                self.endOffset - self.startOffset)
      } catch {
        return s
      }
    }

    // Step 3
    if self.startContainer.nodeType == Node.TEXT_NODE {
      do {
        s += try CharacterData._substringData(self.startContainer as! CharacterData,
                                          self.startOffset,
                                          (self.startContainer as! CharacterData).length - self.startOffset)
      } catch {}
    }

    // Step 4
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
        if node!.nodeType == Node.TEXT_NODE {
          s += (node as! CharacterData).data
        }
        node = Trees.nextInTraverseOrder(node as! Node)
        if node as? Node === endNode as! Node {
          node = nil
        }
      }
    }

    // Step 4
    if self.endContainer.nodeType == Node.TEXT_NODE {
      do {
        s += try CharacterData._substringData(self.endContainer as! CharacterData,
                                              0,
                                              self.endOffset)
      } catch {}
    }

    // Step 5
    return s
  }

  init() {}

  // we absolutely need the deiniter because the documents holds a collection
  // of existing ranges and we need to clean that up when the range is deleted
  deinit {
    if mStartContainer!.ownerDocument != nil {
      (mStartContainer!.ownerDocument as! Document).removeRangeFromRangeCollection(self)
    }
  }
}
