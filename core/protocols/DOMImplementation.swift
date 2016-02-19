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

public protocol pDOMImplementation {
  func createDocumentType(qualifiedName: DOMString, _ publicId: DOMString, _ systemId: DOMString) -> pDocumentType
  func createDocument(namespace: DOMString?, _ qualifiedName: DOMString?, _ doctype: pDocumentType) -> pXMLDocument
  func createHTMLDocument(title: DOMString) -> pDocument

  func hasFeatures() -> Bool
}
