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
  func getAttribute(_ qualifiedName: DOMString) -> DOMString?
  func getAttributeNS(_ namespace: DOMString?, _ localName: DOMString) -> DOMString?
  func setAttribute(_ qualifiedName: DOMString, _ value: DOMString) throws -> Void
  func setAttributeNS(_ namespace: DOMString?, _ qualifiedName: DOMString, _ value: DOMString) throws -> Void
  func removeAttribute(_ qualifiedName: DOMString) -> Void
  func removeAttributeNS(_ namespace: DOMString?, _ qualifiedName: DOMString) -> Void
  func hasAttribute(_ qualifiedName: DOMString) -> Bool
  func hasAttributeNS(_ namespace: DOMString?, _ localName: DOMString) -> Bool

  func getAttributeNode(_ qualifiedName: DOMString) -> pAttr?
  func getAttributeNodeNS(_ namespace: DOMString?, _ localName: DOMString) -> pAttr?
  func setAttributeNode(_ attr: pAttr) -> pAttr?
  func setAttributeNodeNS(_ attr: pAttr) -> pAttr?
  func removeAttributeNode(_ attr: pAttr) -> pAttr

  func closest(_ selectors: DOMString) -> pElement?
  func matches(_ selectors: DOMString) -> Bool

  func getElementsByTagName(_ qualifiedName: DOMString) -> pHTMLCollection
  func getElementsByTagNameNS(_ namespace: DOMString?, _ localName: DOMString) -> pHTMLCollection
  func getElementsByClassName(_ classNames: DOMString) -> pHTMLCollection
}
