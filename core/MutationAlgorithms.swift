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

import QuaxeCoreProtocols

public class MutationAlgorithms {

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
    var count = node.nodeType == Node.DOCUMENT_FRAGMENT_NODE
                ? node.getChildCount()
                : 1

    // Step 2
    if (nil != child && nil != parent.ownerDocument) {
      let rangeCollection = (parent.ownerDocument as! Document).rangeCollection
      let index: UInt = child!.index
      // Step 2.1
      rangeCollecion.forEach( {
        if ($0.startContainer === parent && $0.startOffset > index) {
          $0.setStart($0.startContainer, $0.startOffset + count);
        }
      })
      // Step 2.2
      rangeCollecion.forEach( {
        if ($0.endContainer === parent && $0.endOffset > index) {
          $0.setEnd($0.endContainer, $0.endOffset + count);
        }
      })
    }

    // Step 3
    var nodes = (node.nodeType == Node.DOCUMENT_FRAGMENT_NODE)
                  ? (node.childNodes as! NodeList).cloneAsArray()
                  : [node];

    // Step 4
    if node.nodeType == Node.DOCUMENT_FRAGMENT_NODE {
      MutationAlgorithms.remove(nodes, parent, true)
    }

    // Step 5
    if node.nodeType == Node.DOCUMENT_FRAGMENT_NODE {
      MutationUtils.queueMutationRecord(node, "childList", nil, nil, nil, nil, nodes, nil, nil)
    }

    // Step 6
    try nodes.forEach({
      if nil == child {
        try MutationAlgorithms.append($0, parent)
      }
      else {
        try MutationAlgorithms.insert($0, parent, child)
      }
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
  }
}