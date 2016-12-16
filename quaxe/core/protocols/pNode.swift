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

  func cloneNode(deep: Bool) -> pNode
  func isEqualNode(otherNode: pNode?) -> Bool

  func compareDocumentPosition(other: pNode) -> ushort
  func contains(other: pNode?) -> Bool

  func lookupPrefix(ns: DOMString?) -> DOMString?
  func lookupNamespaceURI(prefix: DOMString?) -> DOMString?
  func isDefaultNamespace(ns: DOMString?) -> Bool

  func insertBefore(node: pNode, _ child: pNode?) throws -> pNode
  func appendChild(node: pNode) throws -> pNode
  func replaceChild(node: pNode, _ child: pNode) -> pNode
  func removeChild(child: pNode) -> pNode
}
