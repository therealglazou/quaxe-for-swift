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

public protocol pDocument: pNode {
  var type: DOMString { get }

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
  func getElementsByTagNameNS(namespace: DOMString?, _ localName: DOMString) -> pHTMLCollection
  func getElementsByClassName(classNames: DOMString) -> pHTMLCollection

  func createElement(localName: DOMString) throws -> pElement
  func createElementNS(namespace: DOMString?, _ qualifiedName: DOMString) throws -> pElement
  func createDocumentFragment() -> pDocumentFragment
  func createTextNode(data: DOMString) -> pText
  func createComment(data: DOMString) -> pComment
  func createProcessingInstruction(target: DOMString, _ data: DOMString) throws -> pProcessingInstruction

  func importNode(node: pNode, _ deep: Bool) throws -> pNode
  func adoptNode(node: pNode) throws -> pNode

  func createAttribute(localName: DOMString) throws -> pAttr
  func createAttributeNS(namespace: DOMString?, _ qualifiedName: DOMString) throws -> pAttr

  func createEvent(interface: DOMString) throws -> pEvent

  func createRange() -> pDOMRange

  func createNodeIterator(root: pNode, _ whatToShow: ulong, _ filter: pNodeFilter?) -> pNodeIterator
  func createTreeWalker(root: pNode, _ whatToShow: ulong, _ filter: pNodeFilter?) -> pTreeWalker
}

public typealias pXMLDocument = pDocument
