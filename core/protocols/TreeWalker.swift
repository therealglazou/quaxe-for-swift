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

public protocol TreeWalker {
  var root: Node { get }
  var whatToShow: ulong { get }
  var filter: NodeFilter? { get }
  var currentNode: Node { get set }

  func parentNode() -> Node?
  func firstChild() -> Node?
  func lastChild() -> Node?
  func previousSibling() -> Node?
  func nextSibling() -> Node?
  func previousNode() -> Node?
  func nextNode() -> Node?
}
