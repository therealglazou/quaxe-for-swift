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
  internal weak var mOwnerNode: Node?
  func setOwnerNode(node: Node) -> Void {
    mOwnerNode = node
  }

  func before(nodes: Array<pNode>) -> Void {  }
  func before(node: pNode) -> Void { }
  func before(string: DOMString) -> Void { }

  func after(nodes: Array<pNode>) -> Void { }
  func after(node: pNode) -> Void { }
  func after(string: DOMString) -> Void { }

  func replaceWith(nodes: Array<pNode>) -> Void { }
  func replaceWith(node: pNode) -> Void { }
  func replaceWith(string: DOMString) -> Void { }

  func remove() -> Void { }

  init() {}
}

/*
 * extending DocumentType, Element, CharacterData
 */

extension DocumentType: pChildNode {
  public func before(nodes: Array<pNode>) -> Void {
    mChildNodeTearoff.before(nodes)
  }
  public func before(node: pNode) -> Void {
    mChildNodeTearoff.before(node)
  }
  public func before(string: DOMString) -> Void {
    mChildNodeTearoff.before(string)
  }

  public func after(nodes: Array<pNode>) -> Void {
    mChildNodeTearoff.after(nodes)
  }
  public func after(node: pNode) -> Void {
    mChildNodeTearoff.after(node)
  }
  public func after(string: DOMString) -> Void {
    mChildNodeTearoff.after(string)
  }

  public func replaceWith(nodes: Array<pNode>) -> Void {
    mChildNodeTearoff.replaceWith(nodes)
  }
  public func replaceWith(node: pNode) -> Void {
    mChildNodeTearoff.replaceWith(node)
  }
  public func replaceWith(string: DOMString) -> Void {
    mChildNodeTearoff.replaceWith(string)
  }

  public func remove() -> Void {
    mChildNodeTearoff.remove()
  }
}

extension Element: pChildNode {
  public func before(nodes: Array<pNode>) -> Void {
    mChildNodeTearoff.before(nodes)
  }
  public func before(node: pNode) -> Void {
    mChildNodeTearoff.before(node)
  }
  public func before(string: DOMString) -> Void {
    mChildNodeTearoff.before(string)
  }

  public func after(nodes: Array<pNode>) -> Void {
    mChildNodeTearoff.after(nodes)
  }
  public func after(node: pNode) -> Void {
    mChildNodeTearoff.after(node)
  }
  public func after(string: DOMString) -> Void {
    mChildNodeTearoff.after(string)
  }

  public func replaceWith(nodes: Array<pNode>) -> Void {
    mChildNodeTearoff.replaceWith(nodes)
  }
  public func replaceWith(node: pNode) -> Void {
    mChildNodeTearoff.replaceWith(node)
  }
  public func replaceWith(string: DOMString) -> Void {
    mChildNodeTearoff.replaceWith(string)
  }

  public func remove() -> Void {
    mChildNodeTearoff.remove()
  }
}

extension CharacterData: pChildNode {
  public func before(nodes: Array<pNode>) -> Void {
    mChildNodeTearoff.before(nodes)
  }
  public func before(node: pNode) -> Void {
    mChildNodeTearoff.before(node)
  }
  public func before(string: DOMString) -> Void {
    mChildNodeTearoff.before(string)
  }

  public func after(nodes: Array<pNode>) -> Void {
    mChildNodeTearoff.after(nodes)
  }
  public func after(node: pNode) -> Void {
    mChildNodeTearoff.after(node)
  }
  public func after(string: DOMString) -> Void {
    mChildNodeTearoff.after(string)
  }

  public func replaceWith(nodes: Array<pNode>) -> Void {
    mChildNodeTearoff.replaceWith(nodes)
  }
  public func replaceWith(node: pNode) -> Void {
    mChildNodeTearoff.replaceWith(node)
  }
  public func replaceWith(string: DOMString) -> Void {
    mChildNodeTearoff.replaceWith(string)
  }

  public func remove() -> Void {
    mChildNodeTearoff.remove()
  }
}

