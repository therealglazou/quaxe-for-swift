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

protocol ParentNode {
  var children:               HTMLCollection { get }
  var firstElementChild:      Element?       { get }
  var lastElementChild:       Element?       { get }
  var childElementCount:      ulong          { get }

  func prepend(nodes: Array<Node>) -> Void
  func prepend(node: Node) -> Void
  func prepend(string: DOMString) -> Void
  func append(nodes: Array<Node>) -> Void
  func append(node: Node) -> Void
  func append(string: DOMString) -> Void

  func query(relativeSelectors: DOMString) -> Element?
  func queryAll(relativeSelectors: DOMString) -> Elements
  func querySelector(selectors: DOMString) -> Element
  func querySelectorAll(selectors: DOMString) -> NodeList
}
