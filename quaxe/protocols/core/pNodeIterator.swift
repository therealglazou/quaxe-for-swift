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

public protocol pNodeIterator {
  var root: pNode { get }
  var referenceNode: pNode { get }
  var pointerBeforeReferenceNode: Bool { get }
  var whatToShow: ulong { get }
  var filter: pNodeFilter? { get }

  func nextNode() -> pNode?
  func previousNode() -> pNode?

  func detach() -> Void
}
