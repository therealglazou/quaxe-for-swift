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

public protocol pParentNode {
  var children:               pHTMLCollection { get }
  var firstElementChild:      pElement?       { get }
  var lastElementChild:       pElement?       { get }
  var childElementCount:      ulong          { get }

  func prepend(nodes: Array<pNode>) -> Void
  func prepend(node: pNode) -> Void
  func prepend(string: DOMString) -> Void
  func append(nodes: Array<pNode>) -> Void
  func append(node: pNode) -> Void
  func append(string: DOMString) -> Void

  func query(relativeSelectors: DOMString) -> pElement?
  func queryAll(relativeSelectors: DOMString) -> pElements
  func querySelector(selectors: DOMString) -> pElement
  func querySelectorAll(selectors: DOMString) -> pNodeList
}
