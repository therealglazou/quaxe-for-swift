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

protocol Element: Node {
  var namespaceURI: DOMString? { get }
  var prefix: DOMString? { get }
  var localName: DOMString { get }
  var tagName: DOMString { get }

  var id: DOMString { get set }
  var className: DOMString { get set }
  var classList: DOMTokenList { get }

  func hasAttributes() -> Bool
  var attributes: NamedNodeMap { get }
  func getAttributeNames() -> Array<DOMString>
  func getAttribute(qualifiedName: DOMString) -> DOMString?
  func getAttributeNS(namespace: DOMString, _localName: DOMString) -> DOMString?
  func setAttribute(qualifiedName: DOMString, _ value: DOMString) -> Void
  func setAttributeNS(namespace: DOMString?, _ qualifiedName: DOMString, _ value: DOMString) -> Void
  func removeAttribute(qualifiedName: DOMString) -> Void
  func removeAttributeNS(namespace: DOMString?, _ qualifiedName: DOMString) -> Void
  func hasAttribute(qualifiedName: DOMString) -> Bool
  func hasAttributeNS(namespace: DOMString?, _ qualifiedName: DOMString) -> Bool

  func getAttributeNode(qualifiedName: DOMString) -> Attr?
  func getAttributeNodeNS(namespace: DOMString?, _ localName: DOMString) -> Attr?
  func setAttributeNode(attr: Attr) -> Attr?
  func setAttributeNodeNS(attr: Attr) -> Attr?
  func removeAttributeNode(attr: Attr) -> Attr

  func closest(selectors: DOMString) -> Element?
  func matches(selectors: DOMString) -> Bool

  func getElementsByTagName(qualifiedName: DOMString) -> HTMLCollection
  func getElementsByTagNameNS(namespace: DOMString?, _ localName: DOMString) -> HTMLCollection
  func getElementsByClassName(classNames: DOMString) -> HTMLCollection
}
