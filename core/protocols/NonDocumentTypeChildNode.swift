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

public protocol NonDocumentTypeChildNode {
  var previousElementSibling: Element? { get }
  var nextElementSibling:     Element? { get }
}
