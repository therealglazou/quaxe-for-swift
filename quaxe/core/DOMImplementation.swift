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

  /**
   * https://dom.spec.whatwg.org/#dom-domimplementation-createdocument
   */
  public func createDocument(namespace: DOMString?, _ qualifiedName: DOMString?, _ doctype: pDocumentType? = nil) throws -> pXMLDocument {
    // Step 1
    let doc = Document()

    // Step 2
    var element: pElement? = nil

    // Step 3
    if nil != qualifiedName && !qualifiedName!.isEmpty {
      try element = doc.createElementNS(namespace, qualifiedName!)
    }

    // Step 4
    if nil != doctype {
      try MutationAlgorithms.append(doctype as! Node, doc)
    }

    // Step 5
    if nil != element {
      try MutationAlgorithms.append(element as! Node, doc)
    }

    // Step 6
    // Explicitely not implemented here

    // Step 7
    return doc
  }
  public func createHTMLDocument(title: DOMString) -> pDocument {return Document()}

  public func hasFeatures() -> Bool {return true}

  init() {}
}
