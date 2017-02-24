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
  func query(_ relativeSelectors: DOMString) -> pElement?
  func queryAll(_ relativeSelectors: DOMString) -> pElements
}
