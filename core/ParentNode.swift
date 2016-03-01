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

/*
 * https://dom.spec.whatwg.org/#parentnode
 */
public class ParentNode {

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

  static func prepend(n: Node, _ nodes: Array<pNode>) -> Void {}
  static func prepend(n: Node, _ node: pNode) -> Void {}
  static func prepend(n: Node, _ string: DOMString) -> Void {}
  static func append(n: Node, _ nodes: Array<pNode>) -> Void {}
  static func append(n: Node, _ node: pNode) -> Void {}
  static func append(n: Node, _ string: DOMString) -> Void {}

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

  public func prepend(nodes: Array<pNode>) -> Void {
    ParentNode.prepend(self, nodes)
  }
  public func prepend(node: pNode) -> Void {
    ParentNode.prepend(self, node)
  }
  public func prepend(string: DOMString) -> Void {
    ParentNode.prepend(self, string)
  }
  public func append(nodes: Array<pNode>) -> Void {
    ParentNode.append(self, nodes)
  }
  public func append(node: pNode) -> Void {
    ParentNode.append(self, node)
  }
  public func append(string: DOMString) -> Void {
    ParentNode.append(self, string)
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

  public func prepend(nodes: Array<pNode>) -> Void {
    ParentNode.prepend(self, nodes)
  }
  public func prepend(node: pNode) -> Void {
    ParentNode.prepend(self, node)
  }
  public func prepend(string: DOMString) -> Void {
    ParentNode.prepend(self, string)
  }
  public func append(nodes: Array<pNode>) -> Void {
    ParentNode.append(self, nodes)
  }
  public func append(node: pNode) -> Void {
    ParentNode.append(self, node)
  }
  public func append(string: DOMString) -> Void {
    ParentNode.append(self, string)
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

  public func prepend(nodes: Array<pNode>) -> Void {
    ParentNode.prepend(self, nodes)
  }
  public func prepend(node: pNode) -> Void {
    ParentNode.prepend(self, node)
  }
  public func prepend(string: DOMString) -> Void {
    ParentNode.prepend(self, string)
  }
  public func append(nodes: Array<pNode>) -> Void {
    ParentNode.append(self, nodes)
  }
  public func append(node: pNode) -> Void {
    ParentNode.append(self, node)
  }
  public func append(string: DOMString) -> Void {
    ParentNode.append(self, string)
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

