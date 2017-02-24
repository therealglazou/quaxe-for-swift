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
  func getElementsByTagName(_ qualifiedName: DOMString) -> pHTMLCollection
  func getElementsByTagNameNS(_ namespace: DOMString?, _ localName: DOMString) -> pHTMLCollection
  func getElementsByClassName(_ classNames: DOMString) -> pHTMLCollection

  func createElement(_ localName: DOMString) throws -> pElement
  func createElementNS(_ namespace: DOMString?, _ qualifiedName: DOMString) throws -> pElement
  func createDocumentFragment() -> pDocumentFragment
  func createTextNode(_ data: DOMString) -> pText
  func createComment(_ data: DOMString) -> pComment
  func createProcessingInstruction(_ target: DOMString, _ data: DOMString) throws -> pProcessingInstruction

  func importNode(_ node: pNode, _ deep: Bool) throws -> pNode
  func adoptNode(_ node: pNode) throws -> pNode

  func createAttribute(_ localName: DOMString) throws -> pAttr
  func createAttributeNS(_ namespace: DOMString?, _ qualifiedName: DOMString) throws -> pAttr

  func createEvent(_ interface: DOMString) throws -> pEvent

  func createRange() -> pDOMRange

  func createNodeIterator(_ root: pNode, _ whatToShow: ulong, _ filter: pNodeFilter?) -> pNodeIterator
  func createTreeWalker(_ root: pNode, _ whatToShow: ulong, _ filter: pNodeFilter?) -> pTreeWalker
}

public typealias pXMLDocument = pDocument
