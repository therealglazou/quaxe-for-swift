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

  internal weak var mOwnerNode: Node?
  func setOwnerNode(node: Node) -> Void {
    mOwnerNode = node
  }

  var children:               pHTMLCollection = HTMLCollection()
  var firstElementChild:      pElement?
  var lastElementChild:       pElement?
  var childElementCount:      ulong = 0

  func prepend(nodes: Array<pNode>) -> Void {}
  func prepend(node: pNode) -> Void {}
  func prepend(string: DOMString) -> Void {}
  func append(nodes: Array<pNode>) -> Void {}
  func append(node: pNode) -> Void {}
  func append(string: DOMString) -> Void {}

  func query(relativeSelectors: DOMString) -> pElement? {return nil}
  func queryAll(relativeSelectors: DOMString) -> pElements {return Elements()}
  func querySelector(selectors: DOMString) -> pElement {return Element()}
  func querySelectorAll(selectors: DOMString) -> pNodeList {return NodeList()}

  init() {}
}

/*
 * extending Document, DocumentFragment, Element
 */
extension Document: pParentNode {
  public var children: pHTMLCollection {
    return mParentNodeTearoff.children
  }
  public var firstElementChild: pElement? {
    return mParentNodeTearoff.firstElementChild
  }
  public var lastElementChild: pElement? {
    return mParentNodeTearoff.lastElementChild
  }
  public var childElementCount: ulong {
    return mParentNodeTearoff.childElementCount
  }

  public func prepend(nodes: Array<pNode>) -> Void {
    mParentNodeTearoff.prepend(nodes)
  }
  public func prepend(node: pNode) -> Void {
    mParentNodeTearoff.prepend(node)
  }
  public func prepend(string: DOMString) -> Void {
    mParentNodeTearoff.prepend(string)
  }
  public func append(nodes: Array<pNode>) -> Void {
    mParentNodeTearoff.append(nodes)
  }
  public func append(node: pNode) -> Void {
    mParentNodeTearoff.append(node)
  }
  public func append(string: DOMString) -> Void {
    mParentNodeTearoff.append(string)
  }

  public func query(relativeSelectors: DOMString) -> pElement? {
    return mParentNodeTearoff.query(relativeSelectors)
  }
  public func queryAll(relativeSelectors: DOMString) -> pElements {
    return mParentNodeTearoff.queryAll(relativeSelectors)
  }
  public func querySelector(selectors: DOMString) -> pElement {
    return mParentNodeTearoff.querySelector(selectors)
  }
  public func querySelectorAll(selectors: DOMString) -> pNodeList {
    return mParentNodeTearoff.querySelectorAll(selectors)
  }
}

extension DocumentFragment: pParentNode {
  public var children: pHTMLCollection {
    return mParentNodeTearoff.children
  }
  public var firstElementChild: pElement? {
    return mParentNodeTearoff.firstElementChild
  }
  public var lastElementChild: pElement? {
    return mParentNodeTearoff.lastElementChild
  }
  public var childElementCount: ulong {
    return mParentNodeTearoff.childElementCount
  }

  public func prepend(nodes: Array<pNode>) -> Void {
    mParentNodeTearoff.prepend(nodes)
  }
  public func prepend(node: pNode) -> Void {
    mParentNodeTearoff.prepend(node)
  }
  public func prepend(string: DOMString) -> Void {
    mParentNodeTearoff.prepend(string)
  }
  public func append(nodes: Array<pNode>) -> Void {
    mParentNodeTearoff.append(nodes)
  }
  public func append(node: pNode) -> Void {
    mParentNodeTearoff.append(node)
  }
  public func append(string: DOMString) -> Void {
    mParentNodeTearoff.append(string)
  }

  public func query(relativeSelectors: DOMString) -> pElement? {
    return mParentNodeTearoff.query(relativeSelectors)
  }
  public func queryAll(relativeSelectors: DOMString) -> pElements {
    return mParentNodeTearoff.queryAll(relativeSelectors)
  }
  public func querySelector(selectors: DOMString) -> pElement {
    return mParentNodeTearoff.querySelector(selectors)
  }
  public func querySelectorAll(selectors: DOMString) -> pNodeList {
    return mParentNodeTearoff.querySelectorAll(selectors)
  }
}

extension Element: pParentNode {
  public var children: pHTMLCollection {
    return mParentNodeTearoff.children
  }
  public var firstElementChild: pElement? {
    return mParentNodeTearoff.firstElementChild
  }
  public var lastElementChild: pElement? {
    return mParentNodeTearoff.lastElementChild
  }
  public var childElementCount: ulong {
    return mParentNodeTearoff.childElementCount
  }

  public func prepend(nodes: Array<pNode>) -> Void {
    mParentNodeTearoff.prepend(nodes)
  }
  public func prepend(node: pNode) -> Void {
    mParentNodeTearoff.prepend(node)
  }
  public func prepend(string: DOMString) -> Void {
    mParentNodeTearoff.prepend(string)
  }
  public func append(nodes: Array<pNode>) -> Void {
    mParentNodeTearoff.append(nodes)
  }
  public func append(node: pNode) -> Void {
    mParentNodeTearoff.append(node)
  }
  public func append(string: DOMString) -> Void {
    mParentNodeTearoff.append(string)
  }

  public func query(relativeSelectors: DOMString) -> pElement? {
    return mParentNodeTearoff.query(relativeSelectors)
  }
  public func queryAll(relativeSelectors: DOMString) -> pElements {
    return mParentNodeTearoff.queryAll(relativeSelectors)
  }
  public func querySelector(selectors: DOMString) -> pElement {
    return mParentNodeTearoff.querySelector(selectors)
  }
  public func querySelectorAll(selectors: DOMString) -> pNodeList {
    return mParentNodeTearoff.querySelectorAll(selectors)
  }
}

