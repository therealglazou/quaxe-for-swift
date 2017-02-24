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

public protocol pDOMImplementation {
  func createDocumentType(_ qualifiedName: DOMString, _ publicId: DOMString, _ systemId: DOMString) throws -> pDocumentType
  func createDocument(_ namespace: DOMString?, _ qualifiedName: DOMString?, _ doctype: pDocumentType?) throws -> pXMLDocument
  func createHTMLDocument(_ title: DOMString?) throws -> pDocument

  func hasFeatures() -> Bool
}
