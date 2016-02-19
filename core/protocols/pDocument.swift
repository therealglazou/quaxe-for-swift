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

public protocol pDocument: pNode {
  var implementation: pDOMImplementation { get }
  var URL: DOMString { get }
  var documentURI: DOMString { get }
  var origin: DOMString { get }
  var compatMode: DOMString { get }
  var characterSet: DOMString { get }
  var charset: DOMString { get }
  var inputEncoding: DOMString { get }
  var contentType: DOMString { get }

  var doctype: pDocumentType? { get }
  var documentElement: pElement? { get }
  func getElementsByTagName(qualifiedName: DOMString) -> pHTMLCollection
  func getElementsByTagNameNS(namespace: DOMString, _ localName: DOMString) -> pHTMLCollection
  func getElementsByClassName(classNames: DOMString) -> pHTMLCollection

  func createElement(localName: DOMString) -> pElement
  func createElementNS(namespace: DOMString?, _ qualifiedName: DOMString) -> pElement
  func createDocumentFragment() -> pDocumentFragment
  func createTextNode(data: DOMString) -> pText
  func createComment(data: DOMString) -> pText
  func createProcessingInstruction(target: DOMString, _ data: DOMString) -> pProcessingInstruction

  func importNode(node: pNode, _ deep: Bool) -> pNode
  func adoptNode(node: pNode) -> pNode

  func createAttribute(localName: DOMString) -> pAttr
  func createAttributeNS(namespace: DOMString?, _ qualifiedName: DOMString) -> pAttr

  func createEvent(interface: DOMString) -> pEvent

  func createRange() -> pDOMRange

  func createNodeIterator(root: pNode, _ whatToShow: ulong, _ filter: pNodeFilter?) -> pNodeIterator
  func createTreeWalker(root: pNode, _ whatToShow: ulong, _ filter: pNodeFilter?) -> pTreeWalker
}

public typealias pXMLDocument = pDocument
