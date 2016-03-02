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

import QuaxeUtils

/*
 * https://dom.spec.whatwg.org/#parentnode
 */
public class ParentNode {

  /**
   * https://dom.spec.whatwg.org/#converting-nodes-into-a-node
   */
  static internal func _convertNodesIntoNode(n: Node, _ nodes: Array<Either<pNode, DOMString>>) throws -> Node {
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
  static func children(n: Node) -> pHTMLCollection {
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
  static func firstElementChild(n: Node) -> pElement? {
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
  static func lastElementChild(n: Node) -> pElement? {
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
  static func childElementCount(n: Node) -> ulong {
    var count: ulong = 0
    var child = n.firstChild
    while nil != child {
      if Node.ELEMENT_NODE == child!.nodeType {
        count++
      }
      child = child!.nextSibling
    }
    return count
  }

  static func prepend(n: Node, _ nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    let node = try ParentNode._convertNodesIntoNode(n, nodes)
    try MutationAlgorithms.preInsert(node, n, n.firstChild as? Node)
  }

  static func append(n: Node, _ nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    let node = try ParentNode._convertNodesIntoNode(n, nodes)
    try MutationAlgorithms.append(node, n)
  }

  static func query(n: Node, _ relativeSelectors: DOMString) -> pElement? {return nil}
  static func queryAll(n: Node, _ relativeSelectors: DOMString) -> pElements {return Elements()}
  static func querySelector(n: Node, _ selectors: DOMString) -> pElement {return Element()}
  static func querySelectorAll(n: Node, _ selectors: DOMString) -> pNodeList {return NodeList()}
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

  public func prepend(nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    try ParentNode.prepend(self, nodes)
  }
  public func append(nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    try ParentNode.append(self, nodes)
  }

  public func query(relativeSelectors: DOMString) -> pElement? {
    return ParentNode.query(self, relativeSelectors)
  }
  public func queryAll(relativeSelectors: DOMString) -> pElements {
    return ParentNode.queryAll(self, relativeSelectors)
  }
  public func querySelector(selectors: DOMString) -> pElement {
    return ParentNode.querySelector(self, selectors)
  }
  public func querySelectorAll(selectors: DOMString) -> pNodeList {
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

  public func prepend(nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    try ParentNode.prepend(self, nodes)
  }
  public func append(nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    try ParentNode.append(self, nodes)
  }

  public func query(relativeSelectors: DOMString) -> pElement? {
    return ParentNode.query(self, relativeSelectors)
  }
  public func queryAll(relativeSelectors: DOMString) -> pElements {
    return ParentNode.queryAll(self, relativeSelectors)
  }
  public func querySelector(selectors: DOMString) -> pElement {
    return ParentNode.querySelector(self, selectors)
  }
  public func querySelectorAll(selectors: DOMString) -> pNodeList {
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

  public func prepend(nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    try ParentNode.prepend(self, nodes)
  }
  public func append(nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    try ParentNode.append(self, nodes)
  }

  public func query(relativeSelectors: DOMString) -> pElement? {
    return ParentNode.query(self, relativeSelectors)
  }
  public func queryAll(relativeSelectors: DOMString) -> pElements {
    return ParentNode.queryAll(self, relativeSelectors)
  }
  public func querySelector(selectors: DOMString) -> pElement {
    return ParentNode.querySelector(self, selectors)
  }
  public func querySelectorAll(selectors: DOMString) -> pNodeList {
    return ParentNode.querySelectorAll(self, selectors)
  }
}

