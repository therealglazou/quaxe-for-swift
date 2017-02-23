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

public protocol pMutationRecord {
  var type:               DOMString   { get }
  var target:             pNode       { get }
  var addedNodes:         pNodeList   { get }
  var removedNodes:       pNodeList   { get }
  var previousSibling:    pNode?      { get }
  var nextSibling:        pNode?      { get }
  var attributeName:      DOMString? { get }
  var attributeNamespace: DOMString? { get }
  var oldValue:           DOMString? { get }
}
