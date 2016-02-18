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

protocol DOMImplementation {
  func createDocumentType(qualifiedName: DOMString, _ publicId: DOMString, _ systemId: DOMString) -> DocumentType
  func createDocument(namespace: DOMString?, _ qualifiedName: DOMString?, _ doctype: DocumentType) -> XMLDocument
  func createHTMLDocument(title: DOMString) -> Document

  func hasFeatures() -> Bool
}
