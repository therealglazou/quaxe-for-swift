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

public protocol pElements {
  func query(relativeSelectors: DOMString) -> pElement?
  func queryAll(relativeSelectors: DOMString) -> pElements
}
