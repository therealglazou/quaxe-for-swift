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

/**
 * https://dom.spec.whatwg.org/#interface-domimplementation
 */
public class DOMImplementation: pDOMImplementation {

  /**
   * https://dom.spec.whatwg.org/#dom-domimplementation-createdocumenttype
   */
  public func createDocumentType(qualifiedName: DOMString, _ publicId: DOMString, _ systemId: DOMString) throws -> pDocumentType {
    //Step 1
    try Namespaces.validateQualifiedName(qualifiedName)

    // Step 2
    let dt = DocumentType()
    dt.mName = qualifiedName
    dt.mPublicId = publicId
    dt.mSystemId = systemId
    return dt
  }
  public func createDocument(namespace: DOMString?, _ qualifiedName: DOMString?, _ doctype: pDocumentType) -> pXMLDocument {return Document()}
  public func createHTMLDocument(title: DOMString) -> pDocument {return Document()}

  public func hasFeatures() -> Bool {return true}

  init() {}
}
