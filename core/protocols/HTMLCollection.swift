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

protocol HTMLCollection {
  var length: ulong { get }
  func item(index: ulong) -> Element?
  func namedItem(name: DOMString) -> Element?
}
