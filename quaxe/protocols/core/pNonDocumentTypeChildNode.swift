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

public protocol pNonDocumentTypeChildNode {
  var previousElementSibling: pElement? { get }
  var nextElementSibling:     pElement? { get }
}
