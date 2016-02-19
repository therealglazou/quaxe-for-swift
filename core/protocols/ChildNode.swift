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

public protocol pChildNode {
  func before(nodes: Array<pNode>) -> Void
  func before(node: pNode) -> Void
  func before(string: DOMString) -> Void

  func after(nodes: Array<pNode>) -> Void
  func after(node: pNode) -> Void
  func after(string: DOMString) -> Void

  func replaceWith(nodes: Array<pNode>) -> Void
  func replaceWith(node: pNode) -> Void
  func replaceWith(string: DOMString) -> Void

  func remove() -> Void
}
