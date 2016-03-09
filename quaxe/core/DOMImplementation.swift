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
    return DocumentType(qualifiedName, publicId, systemId)
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
      element = try doc.createElementNS(namespace, qualifiedName!)
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

  /**
   * https://dom.spec.whatwg.org/#dom-domimplementation-createhtmldocument
   */
  public func createHTMLDocument(title: DOMString? = nil) throws -> pDocument {
    // Step 1
    let doc = Document()
    doc.type = "html"

    // Step 2
    doc.mContentType = "text/html"

    // Step 3
    let dt = try createDocumentType("html", "", "")
    try MutationAlgorithms.append(dt as! Node, doc)

    // Step 4
    let htmlElement = try doc.createElementNS(Namespaces.HTML_NAMESPACE, "html")
    try MutationAlgorithms.append(htmlElement as! Node, doc)

    // Step 5
    let headElement = try doc.createElementNS(Namespaces.HTML_NAMESPACE, "head")
    try MutationAlgorithms.append(headElement as! Node, htmlElement as! Node)

    // Step 6
    if let t = title {
      // Step 6.1
      let titleElement = try doc.createElementNS(Namespaces.HTML_NAMESPACE, "title")
      try MutationAlgorithms.append(titleElement as! Node, headElement as! Node)

      let textNode = doc.createTextNode(t)
      try MutationAlgorithms.append(textNode as! Node, titleElement as! Node)
    }

    // Step 7
    let bodyElement = try doc.createElementNS(Namespaces.HTML_NAMESPACE, "head")
    try MutationAlgorithms.append(bodyElement as! Node, htmlElement as! Node)

    // Step 8
    // explicitely not implemented by Quaxe

    // Step 9
    return doc
  }

  /**
   * https://dom.spec.whatwg.org/#dom-domimplementation-hasfeature
   */
  public func hasFeatures() -> Bool {return true}

  init() {}
}
