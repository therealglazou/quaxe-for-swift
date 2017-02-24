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

import QuaxeUtils
/*
 * https://dom.spec.whatwg.org/#parentnode
 * 
 * status: TODO 50%, querySelector and friends
 */
public class ParentNode {

  /**
   * https://dom.spec.whatwg.org/#converting-nodes-into-a-node
   */
  static internal func _convertNodesIntoNode(_ nodes: Array<Either<pNode, DOMString>>) throws -> Node {
    var node: Node
    var convertedNodes: Array<Node> = []
    for either in nodes {
      switch either {
        case .Left(let eitherNode): convertedNodes.append(eitherNode as! Node)
        case .Right(let s): convertedNodes.append(Text(s))
      }
    }
    if convertedNodes.count == 1 {
      node = convertedNodes[0]
    }
    else {
      node = DocumentFragment()
      for convertedNode in convertedNodes {
        try MutationAlgorithms.append(convertedNode, node)
      }
    }
    return node
  }

  /**
   * https://dom.spec.whatwg.org/#dom-parentnode-children
   */
  static func children(_ n: Node) -> pHTMLCollection {
    let collection = HTMLCollection()
    var child = n.firstChild
    while nil != child {
      if Node.ELEMENT_NODE == child!.nodeType {
        collection.append(child as! Element)
      }
      child = child!.nextSibling
    }
    return collection
  }

  /**
   * https://dom.spec.whatwg.org/#dom-parentnode-firstelementchild
   */
  static func firstElementChild(_ n: Node) -> pElement? {
    var child = n.firstChild
    while nil != child {
      if Node.ELEMENT_NODE == child!.nodeType {
        return child as! Element
      }
      child = child!.nextSibling
    }
    return nil
  }

  /**
   * https://dom.spec.whatwg.org/#dom-parentnode-lastelementchild
   */
  static func lastElementChild(_ n: Node) -> pElement? {
    var child = n.lastChild
    while nil != child {
      if Node.ELEMENT_NODE == child!.nodeType {
        return child as! Element
      }
      child = child!.previousSibling
    }
    return nil
  }

  /**
   * https://dom.spec.whatwg.org/#dom-parentnode-childelementcount
   */
  static func childElementCount(_ n: Node) -> ulong {
    var count: ulong = 0
    var child = n.firstChild
    while nil != child {
      if Node.ELEMENT_NODE == child!.nodeType {
        count += 1
      }
      child = child!.nextSibling
    }
    return count
  }

  static func prepend(_ n: Node, _ nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    let node = try ParentNode._convertNodesIntoNode(nodes)
    try MutationAlgorithms.preInsert(node, n, n.firstChild as? Node)
  }

  static func append(_ n: Node, _ nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    let node = try ParentNode._convertNodesIntoNode(nodes)
    try MutationAlgorithms.append(node, n)
  }

  static func query(_ n: Node, _ relativeSelectors: DOMString) -> pElement? {
    // TODO
    return nil
  }

  static func queryAll(_ n: Node, _ relativeSelectors: DOMString) -> pElements {
    // TODO
    return Elements()
  }

  static func querySelector(_ n: Node, _ selectors: DOMString) -> pElement {
    // TODO
    return Element()
  }

  static func querySelectorAll(_ n: Node, _ selectors: DOMString) -> pNodeList {
    // TODO
    return NodeList()
  }
}

/*
 * extending Document, DocumentFragment, Element
 */
extension Document: pParentNode {
  public var children: pHTMLCollection {
    return ParentNode.children(self)
  }
  public var firstElementChild: pElement? {
    return ParentNode.firstElementChild(self)
  }
  public var lastElementChild: pElement? {
    return ParentNode.lastElementChild(self)
  }
  public var childElementCount: ulong {
    return ParentNode.childElementCount(self)
  }

  public func prepend(_ nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    try ParentNode.prepend(self, nodes)
  }
  public func append(_ nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    try ParentNode.append(self, nodes)
  }

  public func query(_ relativeSelectors: DOMString) -> pElement? {
    return ParentNode.query(self, relativeSelectors)
  }
  public func queryAll(_ relativeSelectors: DOMString) -> pElements {
    return ParentNode.queryAll(self, relativeSelectors)
  }
  public func querySelector(_ selectors: DOMString) -> pElement {
    return ParentNode.querySelector(self, selectors)
  }
  public func querySelectorAll(_ selectors: DOMString) -> pNodeList {
    return ParentNode.querySelectorAll(self, selectors)
  }
}

extension DocumentFragment: pParentNode {
  public var children: pHTMLCollection {
    return ParentNode.children(self)
  }
  public var firstElementChild: pElement? {
    return ParentNode.firstElementChild(self)
  }
  public var lastElementChild: pElement? {
    return ParentNode.lastElementChild(self)
  }
  public var childElementCount: ulong {
    return ParentNode.childElementCount(self)
  }

  public func prepend(_ nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    try ParentNode.prepend(self, nodes)
  }
  public func append(_ nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    try ParentNode.append(self, nodes)
  }

  public func query(_ relativeSelectors: DOMString) -> pElement? {
    return ParentNode.query(self, relativeSelectors)
  }
  public func queryAll(_ relativeSelectors: DOMString) -> pElements {
    return ParentNode.queryAll(self, relativeSelectors)
  }
  public func querySelector(_ selectors: DOMString) -> pElement {
    return ParentNode.querySelector(self, selectors)
  }
  public func querySelectorAll(_ selectors: DOMString) -> pNodeList {
    return ParentNode.querySelectorAll(self, selectors)
  }
}

extension Element: pParentNode {
  public var children: pHTMLCollection {
    return ParentNode.children(self)
  }
  public var firstElementChild: pElement? {
    return ParentNode.firstElementChild(self)
  }
  public var lastElementChild: pElement? {
    return ParentNode.lastElementChild(self)
  }
  public var childElementCount: ulong {
    return ParentNode.childElementCount(self)
  }

  public func prepend(_ nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    try ParentNode.prepend(self, nodes)
  }
  public func append(_ nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    try ParentNode.append(self, nodes)
  }

  public func query(_ relativeSelectors: DOMString) -> pElement? {
    return ParentNode.query(self, relativeSelectors)
  }
  public func queryAll(_ relativeSelectors: DOMString) -> pElements {
    return ParentNode.queryAll(self, relativeSelectors)
  }
  public func querySelector(_ selectors: DOMString) -> pElement {
    return ParentNode.querySelector(self, selectors)
  }
  public func querySelectorAll(_ selectors: DOMString) -> pNodeList {
    return ParentNode.querySelectorAll(self, selectors)
  }
}

