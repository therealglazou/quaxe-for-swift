/**
 * Quaxe for Swift
 * 
 * Copyright 2016-2017 Disruptive Innovations
 * 
 * Original author:
 *   Daniel Glazman <daniel.glazman@disruptive-innovations.com>
 *
 * Contributors:
 * 
 */

public protocol pTreeWalker {
  var root: pNode { get }
  var whatToShow: ulong { get }
  var filter: pNodeFilter? { get }
  var currentNode: pNode { get set }

  func parentNode() -> pNode?
  func firstChild() -> pNode?
  func lastChild() -> pNode?
  func previousSibling() -> pNode?
  func nextSibling() -> pNode?
  func previousNode() -> pNode?
  func nextNode() -> pNode?
}
