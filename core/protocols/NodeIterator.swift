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

protocol NodeIterator {
  var root: Node { get }
  var referenceNode: Node { get }
  var pointerBeforeReferenceNode: Bool { get }
  var whatToShow: ulong { get }
  var filter: NodeFilter? { get }

  func nextNode() -> Node?
  func previousNode() -> Node?

  func detach() -> Void
}
