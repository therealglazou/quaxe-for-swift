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

protocol Document: Node {
  var implementation: DOMImplementation { get }
  var URL: DOMString { get }
  var documentURI: DOMString { get }
  var origin: DOMString { get }
  var compatMode: DOMString { get }
  var characterSet: DOMString { get }
  var charset: DOMString { get }
  var inputEncoding: DOMString { get }
  var contentType: DOMString { get }

  var doctype: DocumentType? { get }
  var documentElement: Element? { get }
  func getElementsByTagName(qualifiedName: DOMString) -> HTMLCollection
  func getElementsByTagNameNS(namespace: DOMString, _ localName: DOMString) -> HTMLCollection
  func getElementsByClassName(classNames: DOMString) -> HTMLCollection

  func createElement(localName: DOMString) -> Element
  func createElementNS(namespace: DOMString?, _ qualifiedName: DOMString) -> Element
  func createDocumentFragment() -> DocumentFragment
  func createTextNode(data: DOMString) -> Text
  func createComment(data: DOMString) -> Text
  func createProcessingInstruction(target: DOMString, _ data: DOMString)

  func importNode(node: Node, _ deep: Bool) -> Node
  func adoptNode(node: Node) -> Node

  func createAttribute(localName: DOMString) -> Attr
  func createAttributeNS(namespace: DOMString?, _ qualifiedName: DOMString) -> Attr

  func createEvent(interface: DOMString) -> Event

  func createRange() -> DOMRange

  func createNodeIterator(root: Node, _ whatToShow: ulong, _ filter: NodeFilter?) -> NodeIterator
  func createTreeWalker(root: Node, _ whatToShow: ulong, _ filter: NodeFilter?) -> TreeWalker
}

typealias XMLDocument = Document
