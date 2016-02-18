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

protocol ChildNode {
  func before(nodes: Array<Node>) -> Void
  func before(node: Node) -> Void
  func before(string: DOMString) -> Void

  func after(nodes: Array<Node>) -> Void
  func after(node: Node) -> Void
  func after(string: DOMString) -> Void

  func replaceWith(nodes: Array<Node>) -> Void
  func replaceWith(node: Node) -> Void
  func replaceWith(string: DOMString) -> Void

  func remove() -> Void
}
