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

import QuaxeCoreProtocols

public class DOMImplementation: pDOMImplementation {
  public func createDocumentType(qualifiedName: DOMString, _ publicId: DOMString, _ systemId: DOMString) -> pDocumentType {return DocumentType()}
  public func createDocument(namespace: DOMString?, _ qualifiedName: DOMString?, _ doctype: pDocumentType) -> pXMLDocument {return Document()}
  public func createHTMLDocument(title: DOMString) -> pDocument {return Document()}

  public func hasFeatures() -> Bool {return true}

  init() {}
}
