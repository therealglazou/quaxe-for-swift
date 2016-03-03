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

import QuaxeUtils

public protocol pParentNode {
  var children:               pHTMLCollection { get }
  var firstElementChild:      pElement?       { get }
  var lastElementChild:       pElement?       { get }
  var childElementCount:      ulong          { get }

  func prepend(nodes: Array<Either<pNode, DOMString>>) throws -> Void
  func append(nodes: Array<Either<pNode, DOMString>>) throws -> Void

  func query(relativeSelectors: DOMString) -> pElement?
  func queryAll(relativeSelectors: DOMString) -> pElements
  func querySelector(selectors: DOMString) -> pElement
  func querySelectorAll(selectors: DOMString) -> pNodeList
}
