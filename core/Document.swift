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

public class Document: Node, pDocument {


  internal var rangeCollection: Array<DOMRange> = []
  internal var nodeIteratorCollection: Array<NodeIterator> = []

  override internal func getParent(event: Event) -> EventTarget? {
    // A document's get the parent algorithm, given an event, returns
    // null if event's type attribute value is "load" or document does
    // not have a browsing context, and the document's associated
    // Window object otherwise. 
    // TODO
    return nil
  }

  internal var mURL: DOMString
  internal var mMode: DOMString
  internal var mInputEncoding: DOMString
  internal var mContentType: DOMString

  /**
   * public
   */
  public var type: DOMString

  /**
   * https://dom.spec.whatwg.org/#dom-document-implementation
   */
  public var implementation: pDOMImplementation = DOMImplementation()

  /**
   * https://dom.spec.whatwg.org/#dom-document-url
   */
  public var URL: DOMString { return mURL }
  public var documentURI: DOMString { return mURL }

  /**
   * https://dom.spec.whatwg.org/#dom-document-origin
   * Explicitely not implemented here
   */
  public var origin: DOMString { return "" }

  /**
   * https://dom.spec.whatwg.org/#dom-document-compatmode
   */
  public var compatMode: DOMString {
    return (mMode == "quirks") ? "BackCompat" : "CSS1Compat"
  }

  /**
   * https://dom.spec.whatwg.org/#dom-document-characterset
   */
  public var characterSet: DOMString { return mInputEncoding }
  public var charset: DOMString { return mInputEncoding }
  public var inputEncoding: DOMString { return mInputEncoding }

  /**
   * https://dom.spec.whatwg.org/#dom-document-contenttype
   */
  public var contentType: DOMString = ""

  /**
   * https://dom.spec.whatwg.org/#dom-document-doctype
   */
  public var doctype: pDocumentType? {
    var child = self.firstChild
    while nil != child {
      if child!.nodeType == Node.DOCUMENT_TYPE_NODE {
        return child as? DocumentType
      }
      child = child!.nextSibling
    }
    return nil
  }

  /**
   * https://dom.spec.whatwg.org/#dom-document-documentelement
   */
  public var documentElement: pElement? {
    var child = self.firstChild
    while nil != child {
      if child!.nodeType == Node.ELEMENT_NODE {
        return child as? Element
      }
      child = child!.nextSibling
    }
    return nil
  }

  /**
   * https://dom.spec.whatwg.org/#dom-document-getelementsbytagname
   */
  public func getElementsByTagName(qualifiedName: DOMString) -> pHTMLCollection {
    return Trees.listElementsWithQualifiedName(self, qualifiedName)
  }

  /**
   * https://dom.spec.whatwg.org/#dom-document-getelementsbytagnamens
   */
  public func getElementsByTagNameNS(namespace: DOMString?, _ localName: DOMString) -> pHTMLCollection {
    return Trees.listElementsWithQualifiedNameAndNamespace(self, namespace, localName)
  }

  /**
   * https://dom.spec.whatwg.org/#dom-document-getelementsbyclassname
   */
  public func getElementsByClassName(classNames: DOMString) -> pHTMLCollection {
    return Trees.listElementsWithClassNames(self, classNames)
  }

  public func createElement(localName: DOMString) -> pElement { return Element()}
  public func createElementNS(namespace: DOMString?, _ qualifiedName: DOMString) -> pElement {return Element()}
  public func createDocumentFragment() -> pDocumentFragment {return DocumentFragment()}
  public func createTextNode(data: DOMString) -> pText {return Text()}
  public func createComment(data: DOMString) -> pText {return Text()}
  public func createProcessingInstruction(target: DOMString, _ data: DOMString) -> pProcessingInstruction {return ProcessingInstruction()}

  public func importNode(node: pNode, _ deep: Bool) -> pNode {return Node()}
  public func adoptNode(node: pNode) -> pNode {return Node()}

  public func createAttribute(localName: DOMString) -> pAttr {return Attr()}
  public func createAttributeNS(namespace: DOMString?, _ qualifiedName: DOMString) -> pAttr {return Attr()}

  public func createEvent(interface: DOMString) -> pEvent {return Event("", [:])}

  public func createRange() -> pDOMRange {return DOMRange()}

  public func createNodeIterator(root: pNode, _ whatToShow: ulong, _ filter: pNodeFilter?) -> pNodeIterator {return NodeIterator()}
  public func createTreeWalker(root: pNode, _ whatToShow: ulong, _ filter: pNodeFilter?) -> pTreeWalker {return TreeWalker()}

  override init() {
    mURL = "about:blank"
    mMode = "no-quirks"
    type = "xml"
    mInputEncoding = "utf-8"
    mContentType = "application/xml"
    super.init()
  }
}
