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

  func children(n: Node) -> pHTMLCollection {
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

  func firstElementChild(n: Node) -> pElement? {
    var child = n.firstChild
    while nil != child {
      if Node.ELEMENT_NODE == child!.nodeType {
        return child as! Element
      }
      child = child!.nextSibling
    }
    return nil
  }

  func lastElementChild(n: Node) -> pElement? {
    var child = n.lastChild
    while nil != child {
      if Node.ELEMENT_NODE == child!.nodeType {
        return child as! Element
      }
      child = child!.previousSibling
    }
    return nil
  }

  func childElementCount(n: Node) -> ulong {
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

  func prepend(n: Node, _ nodes: Array<pNode>) -> Void {}
  func prepend(n: Node, _ node: pNode) -> Void {}
  func prepend(n: Node, _ string: DOMString) -> Void {}
  func append(n: Node, _ nodes: Array<pNode>) -> Void {}
  func append(n: Node, _ node: pNode) -> Void {}
  func append(n: Node, _ string: DOMString) -> Void {}

  func query(n: Node, _ relativeSelectors: DOMString) -> pElement? {return nil}
  func queryAll(n: Node, _ relativeSelectors: DOMString) -> pElements {return Elements()}
  func querySelector(n: Node, _ selectors: DOMString) -> pElement {return Element()}
  func querySelectorAll(n: Node, _ selectors: DOMString) -> pNodeList {return NodeList()}

  init() {}
}

/*
 * extending Document, DocumentFragment, Element
 */
extension Document: pParentNode {
  public var children: pHTMLCollection {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    return (mTearoffs["ParentNode"] as! ParentNode).children(self)
  }
  public var firstElementChild: pElement? {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    return (mTearoffs["ParentNode"] as! ParentNode).firstElementChild(self)
  }
  public var lastElementChild: pElement? {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    return (mTearoffs["ParentNode"] as! ParentNode).lastElementChild(self)
  }
  public var childElementCount: ulong {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    return (mTearoffs["ParentNode"] as! ParentNode).childElementCount(self)
  }

  public func prepend(nodes: Array<pNode>) -> Void {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    (mTearoffs["ParentNode"] as! ParentNode).prepend(self, nodes)
  }
  public func prepend(node: pNode) -> Void {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    (mTearoffs["ParentNode"] as! ParentNode).prepend(self, node)
  }
  public func prepend(string: DOMString) -> Void {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    (mTearoffs["ParentNode"] as! ParentNode).prepend(self, string)
  }
  public func append(nodes: Array<pNode>) -> Void {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    (mTearoffs["ParentNode"] as! ParentNode).append(self, nodes)
  }
  public func append(node: pNode) -> Void {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    (mTearoffs["ParentNode"] as! ParentNode).append(self, node)
  }
  public func append(string: DOMString) -> Void {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    (mTearoffs["ParentNode"] as! ParentNode).append(self, string)
  }

  public func query(relativeSelectors: DOMString) -> pElement? {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    return (mTearoffs["ParentNode"] as! ParentNode).query(self, relativeSelectors)
  }
  public func queryAll(relativeSelectors: DOMString) -> pElements {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    return (mTearoffs["ParentNode"] as! ParentNode).queryAll(self, relativeSelectors)
  }
  public func querySelector(selectors: DOMString) -> pElement {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    return (mTearoffs["ParentNode"] as! ParentNode).querySelector(self, selectors)
  }
  public func querySelectorAll(selectors: DOMString) -> pNodeList {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    return (mTearoffs["ParentNode"] as! ParentNode).querySelectorAll(self, selectors)
  }
}

extension DocumentFragment: pParentNode {
  public var children: pHTMLCollection {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    return (mTearoffs["ParentNode"] as! ParentNode).children(self)
  }
  public var firstElementChild: pElement? {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    return (mTearoffs["ParentNode"] as! ParentNode).firstElementChild(self)
  }
  public var lastElementChild: pElement? {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    return (mTearoffs["ParentNode"] as! ParentNode).lastElementChild(self)
  }
  public var childElementCount: ulong {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    return (mTearoffs["ParentNode"] as! ParentNode).childElementCount(self)
  }

  public func prepend(nodes: Array<pNode>) -> Void {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    (mTearoffs["ParentNode"] as! ParentNode).prepend(self, nodes)
  }
  public func prepend(node: pNode) -> Void {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    (mTearoffs["ParentNode"] as! ParentNode).prepend(self, node)
  }
  public func prepend(string: DOMString) -> Void {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    (mTearoffs["ParentNode"] as! ParentNode).prepend(self, string)
  }
  public func append(nodes: Array<pNode>) -> Void {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    (mTearoffs["ParentNode"] as! ParentNode).append(self, nodes)
  }
  public func append(node: pNode) -> Void {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    (mTearoffs["ParentNode"] as! ParentNode).append(self, node)
  }
  public func append(string: DOMString) -> Void {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    (mTearoffs["ParentNode"] as! ParentNode).append(self, string)
  }

  public func query(relativeSelectors: DOMString) -> pElement? {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    return (mTearoffs["ParentNode"] as! ParentNode).query(self, relativeSelectors)
  }
  public func queryAll(relativeSelectors: DOMString) -> pElements {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    return (mTearoffs["ParentNode"] as! ParentNode).queryAll(self, relativeSelectors)
  }
  public func querySelector(selectors: DOMString) -> pElement {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    return (mTearoffs["ParentNode"] as! ParentNode).querySelector(self, selectors)
  }
  public func querySelectorAll(selectors: DOMString) -> pNodeList {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    return (mTearoffs["ParentNode"] as! ParentNode).querySelectorAll(self, selectors)
  }
}

extension Element: pParentNode {
  public var children: pHTMLCollection {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    return (mTearoffs["ParentNode"] as! ParentNode).children(self)
  }
  public var firstElementChild: pElement? {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    return (mTearoffs["ParentNode"] as! ParentNode).firstElementChild(self)
  }
  public var lastElementChild: pElement? {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    return (mTearoffs["ParentNode"] as! ParentNode).lastElementChild(self)
  }
  public var childElementCount: ulong {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    return (mTearoffs["ParentNode"] as! ParentNode).childElementCount(self)
  }

  public func prepend(nodes: Array<pNode>) -> Void {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    (mTearoffs["ParentNode"] as! ParentNode).prepend(self, nodes)
  }
  public func prepend(node: pNode) -> Void {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    (mTearoffs["ParentNode"] as! ParentNode).prepend(self, node)
  }
  public func prepend(string: DOMString) -> Void {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    (mTearoffs["ParentNode"] as! ParentNode).prepend(self, string)
  }
  public func append(nodes: Array<pNode>) -> Void {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    (mTearoffs["ParentNode"] as! ParentNode).append(self, nodes)
  }
  public func append(node: pNode) -> Void {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    (mTearoffs["ParentNode"] as! ParentNode).append(self, node)
  }
  public func append(string: DOMString) -> Void {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    (mTearoffs["ParentNode"] as! ParentNode).append(self, string)
  }

  public func query(relativeSelectors: DOMString) -> pElement? {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    return (mTearoffs["ParentNode"] as! ParentNode).query(self, relativeSelectors)
  }
  public func queryAll(relativeSelectors: DOMString) -> pElements {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    return (mTearoffs["ParentNode"] as! ParentNode).queryAll(self, relativeSelectors)
  }
  public func querySelector(selectors: DOMString) -> pElement {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    return (mTearoffs["ParentNode"] as! ParentNode).querySelector(self, selectors)
  }
  public func querySelectorAll(selectors: DOMString) -> pNodeList {
    if nil == mTearoffs.indexForKey("ParentNode") { mTearoffs["ParentNode"] = ChildNode() }
    return (mTearoffs["ParentNode"] as! ParentNode).querySelectorAll(self, selectors)
  }
}

