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

import QuaxeUtils

public protocol pParentNode {
  var children:               pHTMLCollection { get }
  var firstElementChild:      pElement?       { get }
  var lastElementChild:       pElement?       { get }
  var childElementCount:      ulong          { get }

  func prepend(_ nodes: Array<Either<pNode, DOMString>>) throws -> Void
  func append(_ nodes: Array<Either<pNode, DOMString>>) throws -> Void

  func query(_ relativeSelectors: DOMString) -> pElement?
  func queryAll(_ relativeSelectors: DOMString) -> pElements
  func querySelector(_ selectors: DOMString) -> pElement
  func querySelectorAll(_ selectors: DOMString) -> pNodeList
}
