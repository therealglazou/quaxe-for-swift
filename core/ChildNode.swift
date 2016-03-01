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

  static func before(n: Node, _ nodes: Array<pNode>) -> Void {  }
  static func before(n: Node, _ node: pNode) -> Void { }
  static func before(n: Node, _ string: DOMString) -> Void { }

  static func after(n: Node, _ nodes: Array<pNode>) -> Void { }
  static func after(n: Node, _ node: pNode) -> Void { }
  static func after(n: Node, _ string: DOMString) -> Void { }

  static func replaceWith(n: Node, _ nodes: Array<pNode>) -> Void { }
  static func replaceWith(n: Node, _ node: pNode) -> Void { }
  static func replaceWith(n: Node, _ string: DOMString) -> Void { }

  static func remove(n: Node) -> Void { }
}

/*
 * extending DocumentType, Element, CharacterData
 */

extension DocumentType: pChildNode {
  public func before(nodes: Array<pNode>) -> Void {
    ChildNode.before(self, nodes)
  }
  public func before(node: pNode) -> Void {
    ChildNode.before(self, node)
  }
  public func before(string: DOMString) -> Void {
    ChildNode.before(self, string)
  }

  public func after(nodes: Array<pNode>) -> Void {
    ChildNode.after(self, nodes)
  }
  public func after(node: pNode) -> Void {
    ChildNode.after(self, node)
  }
  public func after(string: DOMString) -> Void {
    ChildNode.after(self, string)
  }

  public func replaceWith(nodes: Array<pNode>) -> Void {
    ChildNode.replaceWith(self, nodes)
  }
  public func replaceWith(node: pNode) -> Void {
    ChildNode.replaceWith(self, node)
  }
  public func replaceWith(string: DOMString) -> Void {
    ChildNode.replaceWith(self, string)
  }

  public func remove() -> Void {
    ChildNode.remove(self)
  }
}

extension Element: pChildNode {
  public func before(nodes: Array<pNode>) -> Void {
    ChildNode.before(self, nodes)
  }
  public func before(node: pNode) -> Void {
    ChildNode.before(self, node)
  }
  public func before(string: DOMString) -> Void {
    ChildNode.before(self, string)
  }

  public func after(nodes: Array<pNode>) -> Void {
    ChildNode.after(self, nodes)
  }
  public func after(node: pNode) -> Void {
    ChildNode.after(self, node)
  }
  public func after(string: DOMString) -> Void {
    ChildNode.after(self, string)
  }

  public func replaceWith(nodes: Array<pNode>) -> Void {
    ChildNode.replaceWith(self, nodes)
  }
  public func replaceWith(node: pNode) -> Void {
    ChildNode.replaceWith(self, node)
  }
  public func replaceWith(string: DOMString) -> Void {
    ChildNode.replaceWith(self, string)
  }

  public func remove() -> Void {
    ChildNode.remove(self)
  }
}

extension CharacterData: pChildNode {
  public func before(nodes: Array<pNode>) -> Void {
    ChildNode.before(self, nodes)
  }
  public func before(node: pNode) -> Void {
    ChildNode.before(self, node)
  }
  public func before(string: DOMString) -> Void {
    ChildNode.before(self, string)
  }

  public func after(nodes: Array<pNode>) -> Void {
    ChildNode.after(self, nodes)
  }
  public func after(node: pNode) -> Void {
    ChildNode.after(self, node)
  }
  public func after(string: DOMString) -> Void {
    ChildNode.after(self, string)
  }

  public func replaceWith(nodes: Array<pNode>) -> Void {
    ChildNode.replaceWith(self, nodes)
  }
  public func replaceWith(node: pNode) -> Void {
    ChildNode.replaceWith(self, node)
  }
  public func replaceWith(string: DOMString) -> Void {
    ChildNode.replaceWith(self, string)
  }

  public func remove() -> Void {
    ChildNode.remove(self)
  }
}

