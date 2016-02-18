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

protocol Node {
  var nodeType: ushort { get }
  var nodeName: DOMString { get }

  var baseURI: DOMString { get }

  var ownerDocument: Document? { get }
  var parentNode: Node? { get }
  var parentElement: Element? { get }
  func hasChildNodes() -> Bool
  var childNodes: NodeList { get }
  var firstChild: Node? { get }
  var lastChild: Node? { get }
  var previousSibling: Node? { get }
  var nextSibling: Node? { get }

  var nodeValue: DOMString? { get set }
  var textContent: DOMString? { get set }
  func normalize() -> Void

  func cloneNode(deep: Bool) -> Node
  func isEqualNode(otherNode: Node?) -> Bool

  func compareDocumentPosition(other: Node) -> ushort
  func contains(other: Node?) -> Bool

  func lookupPrefix(namespace: DOMString?) -> DOMString?
  func lookupNamespaceURI(prefix: DOMString?) -> DOMString?
  func isDefaultNamespace(namespace: DOMString?) -> Bool

  func insertBefore(node: Node, _ child: Node?) -> Node
  func appendChild(node: Node) -> Node
  func replaceChild(node: Node, _ child: Node) -> Node
  func removeChild(child: Node) -> Node
}
