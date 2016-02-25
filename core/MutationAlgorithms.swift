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

internal class MutationAlgorithms {

  /**
   * https://dom.spec.whatwg.org/#concept-node-ensure-pre-insertion-validity
   */
  static func ensurePreInsertionValidity(node: Node, _ parent: Node, _ child: Node?) throws -> Void {
    // step 1
    if Node.DOCUMENT_NODE != parent.nodeType &&
       Node.DOCUMENT_FRAGMENT_NODE != parent.nodeType &&
       Node.ELEMENT_NODE != parent.nodeType {
      throw Exception.HierarchyRequestError
    }

    // step 2
    if node.isInclusiveAncestorOf(parent) {
      throw Exception.HierarchyRequestError
    }

    // step 3
    if nil != child &&
       parent !== (child!.parentNode as? Node) {
      throw Exception.NotFoundError
    }

    // step 4
    if Node.DOCUMENT_NODE != node.nodeType &&
       Node.DOCUMENT_TYPE_NODE != node.nodeType &&
       Node.ELEMENT_NODE != node.nodeType &&
       Node.TEXT_NODE != node.nodeType &&
       Node.COMMENT_NODE != node.nodeType &&
       Node.PROCESSING_INSTRUCTION_NODE != node.nodeType {
      throw Exception.HierarchyRequestError
    }

    // step 5
    if (Node.TEXT_NODE == node.nodeType &&
        Node.DOCUMENT_NODE == parent.nodeType) ||
       (Node.DOCUMENT_TYPE_NODE == node.nodeType &&
        Node.DOCUMENT_NODE != parent.nodeType) {
      throw Exception.HierarchyRequestError
    } 

    // step 6
    if Node.DOCUMENT_NODE == parent.nodeType {
      switch node.nodeType {
        case Node.DOCUMENT_FRAGMENT_NODE:
          var elementChildCount: UInt = 0
          var textChildCount: UInt = 0
          node.getCounts(&elementChildCount, &textChildCount)
          if elementChildCount > 1 || textChildCount != 0 {
            throw Exception.HierarchyRequestError
          }
          var elementChildCountForParent: UInt = 0
          var textChildCountForParent: UInt = 0
          parent.getCounts(&elementChildCountForParent, &textChildCountForParent)
          if elementChildCount == 1 &&
             (elementChildCountForParent >= 1 ||
              (nil != child && child!.nodeType == Node.DOCUMENT_TYPE_NODE) ||
              (nil != child && child!.hasFollowingDoctype())) {
            throw Exception.HierarchyRequestError
          }
        case Node.ELEMENT_NODE:
          var elementChildCountForParent: UInt = 0
          var textChildCountForParent: UInt = 0
          node.getCounts(&elementChildCountForParent, &textChildCountForParent)
          if elementChildCountForParent >= 1 ||
             (nil != child && child!.nodeType == Node.DOCUMENT_TYPE_NODE) ||
             (nil != child && child!.hasFollowingDoctype()) {
            throw Exception.HierarchyRequestError
          }
        case Node.DOCUMENT_TYPE_NODE:
          var elementChildCountForParent: UInt = 0
          var textChildCountForParent: UInt = 0
          parent.getCounts(&elementChildCountForParent, &textChildCountForParent)
          if parent.hasDoctypeChild() ||
             (nil != child && child!.hasPrecedingElement()) ||
             (nil == child && elementChildCountForParent >= 1) {
            throw Exception.HierarchyRequestError
          }
        default: break;
      }
    } 
  }

  /**
   * https://dom.spec.whatwg.org/#concept-node-pre-insert
   */
  static func preInsert(node: Node, _ parent: Node, _ child: Node?) throws -> Node {
    try MutationAlgorithms.ensurePreInsertionValidity(node, parent, child)
    var referenceChild = child
    if referenceChild != nil && referenceChild! === node {
      referenceChild = node.nextSibling as? Node
    }
    MutationAlgorithms.adopt(node, parent.ownerDocument as? Document)
    try MutationAlgorithms.insert(node, parent, referenceChild)
    return node
  }

 /**
  * https://dom.spec.whatwg.org/#concept-node-insert
  */
  static func insert(node: Node, _ parent: Node, _ child: Node?, _ supressObserverFlag: Bool = false) throws -> Void {
    // Step 1
    let count = node.nodeType == Node.DOCUMENT_FRAGMENT_NODE
                ? node.getChildCount()
                : 1

    // Step 2
    if (nil != child && nil != parent.ownerDocument) {
      let rangeCollection = (parent.ownerDocument as! Document).rangeCollection
      let index = child!.index
      // Step 2.1
      rangeCollection.forEach( {
        if ($0.startContainer as! Node === parent && $0.startOffset > index) {
          $0.setStart($0.startContainer!, $0.startOffset + ulong(count));
        }
      })
      // Step 2.2
      rangeCollection.forEach( {
        if ($0.endContainer as! Node === parent && $0.endOffset > index) {
          $0.setEnd($0.endContainer!, $0.endOffset + ulong(count));
        }
      })
    }

    // Step 3
    let nodes = (node.nodeType == Node.DOCUMENT_FRAGMENT_NODE)
                  ? (node.childNodes as! NodeList).cloneAsArray()
                  : [node];

    // Step 4
    if node.nodeType == Node.DOCUMENT_FRAGMENT_NODE {
      nodes.forEach( { MutationAlgorithms.remove($0, parent, true) } )
    }

    // Step 5
    if node.nodeType == Node.DOCUMENT_FRAGMENT_NODE {
      MutationUtils.queueMutationRecord(node, "childList", nil, nil, nil, nil, nodes, nil, nil)
    }

    // Step 6
    nodes.forEach({
      AtomicTreeActions.insertBefore($0, parent, child)
    })

    // Step 7
    if supressObserverFlag {
      MutationUtils.queueMutationRecord(parent, "childList", nil, nil, nil, nodes, nil,
                                        (nil != child) ? child!.previousSibling as? Node
                                                       : parent.lastChild as? Node,
                                        nil)
    }

  }

  /**
   * https://dom.spec.whatwg.org/#concept-node-append
   */
  static func append(node: Node, _ parent: Node) throws -> Void {
    try MutationAlgorithms.preInsert(node, parent, nil)
  }

  /*
   * https://dom.spec.whatwg.org/#concept-node-replace
   */
  static func replace(child: Node, _ node: Node, _ parent: Node) throws -> Node {
    // Step 1
    if Node.DOCUMENT_NODE != parent.nodeType &&
       Node.DOCUMENT_FRAGMENT_NODE != parent.nodeType &&
       Node.ELEMENT_NODE != parent.nodeType {
      throw Exception.HierarchyRequestError
    }

    // Step 2
    if node.isInclusiveAncestorOf(parent) {
      throw Exception.HierarchyRequestError
    }

    // Step 3
    if child.parentNode as? Node !== parent {
      throw Exception.NotFoundError
    }

    // step 4
    if Node.DOCUMENT_NODE != node.nodeType &&
       Node.DOCUMENT_TYPE_NODE != node.nodeType &&
       Node.ELEMENT_NODE != node.nodeType &&
       Node.TEXT_NODE != node.nodeType &&
       Node.COMMENT_NODE != node.nodeType &&
       Node.PROCESSING_INSTRUCTION_NODE != node.nodeType {
      throw Exception.HierarchyRequestError
    }

    // Step 5
    if (node.nodeType == Node.TEXT_NODE && parent.nodeType == Node.DOCUMENT_NODE) ||
       (node.nodeType == Node.DOCUMENT_TYPE_NODE && parent.nodeType != Node.DOCUMENT_NODE) {
      throw Exception.HierarchyRequestError
    }

    // Step 6
    if parent.nodeType == Node.DOCUMENT_NODE {
      switch node.nodeType {
      case Node.DOCUMENT_FRAGMENT_NODE:
        // first halfcase
        let n = node as! DocumentFragment
        if nil != n.firstElementChild &&
           nil != n.lastElementChild &&
           n.firstElementChild as! Element !== n.lastElementChild as! Element {
          throw Exception.HierarchyRequestError
        }

        // second half case
        var c = node.firstChild
        while nil != c {
          if c!.nodeType == Node.TEXT_NODE {
            throw Exception.HierarchyRequestError
          }
          c = c!.nextSibling
        }

        // otherwise...
        if nil != n.firstElementChild {
          var parentElementChild = (parent as! Document).firstElementChild
          while nil != parentElementChild {
            if parentElementChild!.nodeType == Node.ELEMENT_NODE &&
               parentElementChild as! Node !== child {
              throw Exception.HierarchyRequestError
            }
            parentElementChild = (parentElementChild as! Element).nextElementSibling
          }

          if child.hasFollowingDoctype() {
            throw Exception.HierarchyRequestError
          }
        }

      case Node.ELEMENT_NODE:
        var parentElementChild = (parent as! Element).firstElementChild
        while nil != parentElementChild {
          if parentElementChild!.nodeType == Node.ELEMENT_NODE &&
             parentElementChild as! Node !== child {
            throw Exception.HierarchyRequestError
          }
          parentElementChild = (parentElementChild as! Element).nextElementSibling
        }

        if child.hasFollowingDoctype() {
          throw Exception.HierarchyRequestError
        }

      case Node.DOCUMENT_TYPE_NODE:
        var parentElementChild = (parent as! Document).firstElementChild
        while nil != parentElementChild {
          if parentElementChild!.nodeType == Node.DOCUMENT_TYPE_NODE &&
             parentElementChild as! Node !== child {
            throw Exception.HierarchyRequestError
          }
          parentElementChild = (parentElementChild as! Element).nextElementSibling
        }

        if child.hasPrecedingElement() {
          throw Exception.HierarchyRequestError
        }

      default: break;
      }
    }

    // Step 7
    var referenceChild = child.nextSibling

    // Step 8
    if referenceChild != nil && (referenceChild as! Node) === node {
      referenceChild = node.nextSibling
    }

    // Step 9
    let previousSibling = child.previousSibling

    // Step 10
    MutationAlgorithms.adopt(node, parent.ownerDocument as? Document)

    // Step 11
    var removedNodes: Array<Node> = []

    // Step 12
    if child.parentNode != nil {
      removedNodes = [ child ]
      MutationAlgorithms.remove(child, parent, true)
    }

    // Step 13
    let nodes: Array<Node> = node.nodeType == Node.DOCUMENT_FRAGMENT_NODE
                               ? (node.childNodes as! NodeList).cloneAsArray()
                               : [ node ]

    // Step 14
    try MutationAlgorithms.insert(node, parent, referenceChild as? Node, true)

    // Step 15
    MutationUtils.queueMutationRecord(parent, "childList", nil, nil, nil,
                                      nodes, removedNodes,
                                      previousSibling as? Node,
                                      referenceChild as? Node)

    // Step 16
    return child
  }

  static func replaceAll(node: Node?, _ parent: Node) throws -> Void {
    // Step 1
    if nil != node {
      MutationAlgorithms.adopt(node!, parent.ownerDocument as? Document)
    }

    // Step 2
    let removedNodes: Array<Node> = (parent.childNodes as! NodeList).cloneAsArray()

    // Step 3
    var addedNodes: Array<Node>
    if nil == node {
      addedNodes = []
    }
    else if node!.nodeType == Node.DOCUMENT_FRAGMENT_NODE {
      addedNodes = (node!.childNodes as! NodeList).cloneAsArray()
    }
    else {
      addedNodes = [ node! ]
    }

    // Step 4
    removedNodes.forEach({
      MutationAlgorithms.remove($0, parent, true)
    })

    // Step 5
    if nil != node {
      try MutationAlgorithms.insert(node!, parent, nil, true)
    }

    // Step 6
    MutationUtils.queueMutationRecord(parent, "childList", nil, nil, nil,
        addedNodes, removedNodes,
        nil, nil)
  }

  /*
   * https://dom.spec.whatwg.org/#concept-node-pre-remove
   */
  static func preRemove(child: Node, _ parent: Node) throws -> Node {
    // Step 1
    if child.parentNode != nil &&
       child.parentNode as! Node !== parent {
      throw Exception.NotFoundError
    }

    // Step 2
    MutationAlgorithms.remove(child, parent)

    // Step 3
    return child
  }

  /*
   * https://dom.spec.whatwg.org/#concept-node-remove
   */
  static func remove(node: Node, _ parent: Node, _ suppressObserversFlag: Bool = false) -> Void {
    // Step 1
    let index = node.index

    let rangeCollection = (parent.ownerDocument as! Document).rangeCollection
    // Step 2
    rangeCollection.forEach( {
      if ($0.startContainer as! Node).isInclusiveAncestorOf(node) {
        $0.setStart(parent, index);
      }
    })
    // Step 3
    rangeCollection.forEach( {
      if ($0.endContainer as! Node).isInclusiveAncestorOf(node) {
        $0.setEnd(parent, index);
      }
    })
    // Step 4
    rangeCollection.forEach( {
      if ($0.startContainer as! Node) === parent &&
          $0.startOffset > index {
        $0.setStart($0.startContainer!, $0.startOffset - 1);
      }
    })
    // Step 5
    rangeCollection.forEach( {
      if ($0.endContainer as! Node) === parent &&
          $0.endOffset > index {
        $0.setEnd($0.endContainer!, $0.endOffset - 1);
      }
    })

    // Step 6
    let nodeIteratorCollection = (parent.ownerDocument as! Document).nodeIteratorCollection
    nodeIteratorCollection.forEach({
      if $0.root.ownerDocument as? Document === node.ownerDocument as? Document {
        $0.preRemovingSteps(node)
      }
    })

    // Step 7 
    let oldPreviousSibling = node.previousSibling

    // Step 8
    let oldNextSibling = node.nextSibling

    // Step 9
    AtomicTreeActions.remove(node, parent)

    // Step 10
    // no removing steps defined...

    // Step 11 TODO
  }

  /*
   * https://dom.spec.whatwg.org/#concept-node-adopt
   */
  static func adopt(node: Node, _ document: Document?) -> Void {
    // Step 1
    let oldDocument = node.ownerDocument

    //Step 2
    if nil != node.parentNode {
      MutationAlgorithms.remove(node, node.parentNode as! Node)
    }

    //Step 3.1
    func setOwnerNode(n: Node?) {
      if nil == n {
        return
      }
      n!.mOwnerDocument = document
      var child = n!.firstChild
      while nil != child {
        setOwnerNode(child as? Node)
        child = child!.nextSibling
      }
    }
    setOwnerNode(node)

    // Step 3.2
    // no adopting steps here...
  }
}
