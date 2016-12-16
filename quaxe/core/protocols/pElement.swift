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

public protocol pElement: pNode {
  var namespaceURI: DOMString? { get }
  var prefix: DOMString? { get }
  var localName: DOMString { get }
  var tagName: DOMString { get }

  var id: DOMString { get set }
  var className: DOMString { get set }
  var classList: pDOMTokenList { get }

  func hasAttributes() -> Bool
  var attributes: pNamedNodeMap { get }
  func getAttributeNames() -> Array<DOMString>
  func getAttribute(qualifiedName: DOMString) -> DOMString?
  func getAttributeNS(namespace: DOMString?, _ localName: DOMString) -> DOMString?
  func setAttribute(qualifiedName: DOMString, _ value: DOMString) throws -> Void
  func setAttributeNS(namespace: DOMString?, _ qualifiedName: DOMString, _ value: DOMString) throws -> Void
  func removeAttribute(qualifiedName: DOMString) -> Void
  func removeAttributeNS(namespace: DOMString?, _ qualifiedName: DOMString) -> Void
  func hasAttribute(qualifiedName: DOMString) -> Bool
  func hasAttributeNS(namespace: DOMString?, _ localName: DOMString) -> Bool

  func getAttributeNode(qualifiedName: DOMString) -> pAttr?
  func getAttributeNodeNS(namespace: DOMString?, _ localName: DOMString) -> pAttr?
  func setAttributeNode(attr: pAttr) -> pAttr?
  func setAttributeNodeNS(attr: pAttr) -> pAttr?
  func removeAttributeNode(attr: pAttr) -> pAttr

  func closest(selectors: DOMString) -> pElement?
  func matches(selectors: DOMString) -> Bool

  func getElementsByTagName(qualifiedName: DOMString) -> pHTMLCollection
  func getElementsByTagNameNS(namespace: DOMString?, _ localName: DOMString) -> pHTMLCollection
  func getElementsByClassName(classNames: DOMString) -> pHTMLCollection
}
