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

public protocol pNode: pEventTarget {
  var nodeType: ushort { get }
  var nodeName: DOMString { get }

  var baseURI: DOMString { get }

  var ownerDocument: pDocument? { get }
  var parentNode: pNode? { get }
  var parentElement: pElement? { get }
  func hasChildNodes() -> Bool
  var childNodes: pNodeList { get }
  var firstChild: pNode? { get }
  var lastChild: pNode? { get }
  var previousSibling: pNode? { get }
  var nextSibling: pNode? { get }

  var nodeValue: DOMString? { get set }
  var textContent: DOMString? { get set }
  func normalize() throws -> Void

  func cloneNode(_ deep: Bool) -> pNode
  func isEqualNode(_ otherNode: pNode?) -> Bool

  func compareDocumentPosition(_ other: pNode) -> ushort
  func contains(_ other: pNode?) -> Bool

  func lookupPrefix(_ ns: DOMString?) -> DOMString?
  func lookupNamespaceURI(_ prefix: DOMString?) -> DOMString?
  func isDefaultNamespace(_ ns: DOMString?) -> Bool

  func insertBefore(_ node: pNode, _ child: pNode?) throws -> pNode
  func appendChild(_ node: pNode) throws -> pNode
  func replaceChild(_ node: pNode, _ child: pNode) throws -> pNode
  func removeChild(_ child: pNode) throws -> pNode
}
