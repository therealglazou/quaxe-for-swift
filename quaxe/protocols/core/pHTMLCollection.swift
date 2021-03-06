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

public protocol pHTMLCollection {
  var length: ulong { get }
  func item(_ index: ulong) -> pElement?
  func namedItem(_ name: DOMString) -> pElement?
}
