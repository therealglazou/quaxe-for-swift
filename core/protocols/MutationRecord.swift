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

protocol MutationRecord {
  var type:              DOMString   { get }
  var target:             Node       { get }
  var addedNodes:         NodeList   { get }
  var removedNodes:       NodeList   { get }
  var previousSibling:    Node?      { get }
  var nextSibling:        Node?      { get }
  var attributeName:      DOMString? { get }
  var attributeNamespace: DOMString? { get }
  var oldValue:           DOMString? { get }
}
