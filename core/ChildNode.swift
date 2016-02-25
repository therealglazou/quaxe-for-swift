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
 * https://dom.spec.whatwg.org/#childnode
 */
public class ChildNode {

  func before(n: Node, _ nodes: Array<pNode>) -> Void {  }
  func before(n: Node, _ node: pNode) -> Void { }
  func before(n: Node, _ string: DOMString) -> Void { }

  func after(n: Node, _ nodes: Array<pNode>) -> Void { }
  func after(n: Node, _ node: pNode) -> Void { }
  func after(n: Node, _ string: DOMString) -> Void { }

  func replaceWith(n: Node, _ nodes: Array<pNode>) -> Void { }
  func replaceWith(n: Node, _ node: pNode) -> Void { }
  func replaceWith(n: Node, _ string: DOMString) -> Void { }

  func remove(n: Node) -> Void { }

  init() { }
}

/*
 * extending DocumentType, Element, CharacterData
 */

extension DocumentType: pChildNode {
  public func before(nodes: Array<pNode>) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).before(self, nodes)
  }
  public func before(node: pNode) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).before(self, node)
  }
  public func before(string: DOMString) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).before(self, string)
  }

  public func after(nodes: Array<pNode>) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).after(self, nodes)
  }
  public func after(node: pNode) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).after(self, node)
  }
  public func after(string: DOMString) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).after(self, string)
  }

  public func replaceWith(nodes: Array<pNode>) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).replaceWith(self, nodes)
  }
  public func replaceWith(node: pNode) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).replaceWith(self, node)
  }
  public func replaceWith(string: DOMString) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).replaceWith(self, string)
  }

  public func remove() -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).remove(self)
  }
}

extension Element: pChildNode {
  public func before(nodes: Array<pNode>) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).before(self, nodes)
  }
  public func before(node: pNode) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).before(self, node)
  }
  public func before(string: DOMString) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).before(self, string)
  }

  public func after(nodes: Array<pNode>) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).after(self, nodes)
  }
  public func after(node: pNode) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).after(self, node)
  }
  public func after(string: DOMString) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).after(self, string)
  }

  public func replaceWith(nodes: Array<pNode>) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).replaceWith(self, nodes)
  }
  public func replaceWith(node: pNode) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).replaceWith(self, node)
  }
  public func replaceWith(string: DOMString) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).replaceWith(self, string)
  }

  public func remove() -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).remove(self)
  }
}

extension CharacterData: pChildNode {
  public func before(nodes: Array<pNode>) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).before(self, nodes)
  }
  public func before(node: pNode) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).before(self, node)
  }
  public func before(string: DOMString) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).before(self, string)
  }

  public func after(nodes: Array<pNode>) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).after(self, nodes)
  }
  public func after(node: pNode) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).after(self, node)
  }
  public func after(string: DOMString) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).after(self, string)
  }

  public func replaceWith(nodes: Array<pNode>) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).replaceWith(self, nodes)
  }
  public func replaceWith(node: pNode) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).replaceWith(self, node)
  }
  public func replaceWith(string: DOMString) -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).replaceWith(self, string)
  }

  public func remove() -> Void {
    if nil == mTearoffs.indexForKey("ChildNode") { mTearoffs["ChildNode"] = ChildNode() }
    (mTearoffs["ChildNode"] as! ChildNode).remove(self)
  }
}

