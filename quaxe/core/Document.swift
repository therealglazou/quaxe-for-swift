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

import QuaxeUtils

/**
 * https://dom.spec.whatwg.org/#interface-document
 * 
 * status: XXX nodeIteratorCollection
 */
public class Document: Node, pDocument {


  internal var rangeCollection: Array<Weak<DOMRange>> = []
  internal var nodeIteratorCollection: Array<Weak<NodeIterator>> = []

  internal func addNodeIteratorToNodeIteratorCollection(_ iterator: NodeIterator) -> Void {
    nodeIteratorCollection.append(Weak<NodeIterator>(iterator))
  }

  internal func removeNodeIteratorFromNodeIteratorCollection(_ iterator: NodeIterator) -> Void {
    if let index = nodeIteratorCollection.index(where: { $0.value === iterator}) {
      nodeIteratorCollection.remove(at: index)
    }
  }

  internal func addRangeToRangeCollection(_ range: DOMRange) -> Void {
    rangeCollection.append(Weak<DOMRange>(range))
  }

  internal func removeRangeFromRangeCollection(_ range: DOMRange) -> Void {
    if let index = rangeCollection.index(where: { $0.value === range}) {
      rangeCollection.remove(at: index)
    }
  }

  override internal func getParent(_ event: Event) -> EventTarget? {
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
  public func getElementsByTagName(_ qualifiedName: DOMString) -> pHTMLCollection {
    return Trees.listElementsWithQualifiedName(self, qualifiedName)
  }

  /**
   * https://dom.spec.whatwg.org/#dom-document-getelementsbytagnamens
   */
  public func getElementsByTagNameNS(_ namespace: DOMString?, _ localName: DOMString) -> pHTMLCollection {
    return Trees.listElementsWithQualifiedNameAndNamespace(self, namespace, localName)
  }

  /**
   * https://dom.spec.whatwg.org/#dom-document-getelementsbyclassname
   */
  public func getElementsByClassName(_ classNames: DOMString) -> pHTMLCollection {
    return Trees.listElementsWithClassNames(self, classNames)
  }

  /**
   * https://dom.spec.whatwg.org/#dom-document-createelement
   */
  public func createElement(_ ln: DOMString) throws -> pElement {
    var localName = ln
    //Step 1
    try Namespaces.validateAsXMLName(localName)

    // Step 2
    if self.type == "html" {
        localName = localName.lowercased() 
    }

    let rv = Element()
    rv.mNamespaceURI = Namespaces.HTML_NAMESPACE
    rv.mLocalName = localName
    rv.mOwnerDocument = self

    return rv
  }

  /**
   * https://dom.spec.whatwg.org/#dom-document-createelementns
   */
  public func createElementNS(_ namespace: DOMString?, _ qualifiedName: DOMString) throws -> pElement {
    let dict: Dictionary<DOMString, DOMString?> = try Namespaces.validateAndExtract(namespace, qualifiedName)

    let rv = Element()
    if let n = dict["namespace"] {
      rv.mNamespaceURI = n
    }
    rv.mLocalName = dict["localName"]!!
    if let p = dict["prefix"] {
      rv.mPrefix = p
    }
    rv.mOwnerDocument = self

    return rv
  }

  /**
   * https://dom.spec.whatwg.org/#dom-document-createdocumentfragment
   */
  public func createDocumentFragment() -> pDocumentFragment {
    let rv = DocumentFragment()
    rv.mOwnerDocument = self
    return rv
  }

  /**
   * https://dom.spec.whatwg.org/#dom-document-createtextnode
   */
  public func createTextNode(_ data: DOMString) -> pText {
    let rv = Text(data)
    rv.mOwnerDocument = self
    return rv
  }

  /**
   * https://dom.spec.whatwg.org/#dom-document-createcomment
   */
  public func createComment(_ data: DOMString) -> pComment {
    let rv = Comment(data)
    rv.mOwnerDocument = self
    return rv
  }

  /**
   * https://dom.spec.whatwg.org/#dom-document-createprocessinginstruction
   */
  public func createProcessingInstruction(_ target: DOMString, _ data: DOMString) throws -> pProcessingInstruction {
    try Namespaces.validateAsXMLName(target)

    if data.range(of: "?>") != nil {
      throw Exception.InvalidCharacterError
    }

    let rv = ProcessingInstruction(target, data)
    rv.mOwnerDocument = self
    return rv
  }

  /**
   * https://dom.spec.whatwg.org/#dom-document-importnode
   */
  public func importNode(_ node: pNode, _ deep: Bool) throws -> pNode {
    if node.nodeType == Node.DOCUMENT_NODE {
      throw Exception.NotSupportedError
    }
    return (node as! Node)._clone(self, deep)
  }

  /**
   * https://dom.spec.whatwg.org/#dom-document-adoptnode
   */
  public func adoptNode(_ node: pNode) throws -> pNode {
    if node.nodeType == Node.DOCUMENT_NODE {
      throw Exception.NotSupportedError
    }

    MutationAlgorithms.adopt(node as! Node, self)
    return node
  }

  /**
   * https://dom.spec.whatwg.org/#dom-document-createattribute
   */
  public func createAttribute(_ ln: DOMString) throws -> pAttr {
    var localName = ln
    try Namespaces.validateAsXMLName(localName)

    if self.type == "html" {
      localName = localName.lowercased() 
    }

    return Attr(localName)
  }

  /**
   * https://dom.spec.whatwg.org/#dom-document-createattributens
   */
  public func createAttributeNS(_ namespace: DOMString?, _ qualifiedName: DOMString) throws -> pAttr {
    let dict: Dictionary<DOMString, DOMString?> = try Namespaces.validateAndExtract(namespace, qualifiedName)

    let rv = Attr(dict["localName"]!!)
    if let n = dict["namespace"] {
      rv.mNamespaceURI = n
    }
    if let p = dict["prefix"] {
      rv.mPrefix = p
    }
    return rv
  }

  /**
   * https://dom.spec.whatwg.org/#dom-document-createevent
   */
  public func createEvent(_ interface: DOMString) throws -> pEvent {
    var rv: pEvent
    switch interface {
      case "customevent": rv = CustomEvent("", [:])
      case "event",
           "events",
           "htmlevents":  rv = Event("", [:])
      case "keyboardevent",
           "messageevent",
           "mouseevent",
           "mouseevents",
           "touchevent",
           "uievent",
           "uievents": rv = EventCreator.createEvent("", [:])
      default: throw Exception.NotSupportedError
    }

    (rv as! Event).unsetFlag(Event.INITIALIZED_FLAG)
    
    return rv
  }

  /**
   * https://dom.spec.whatwg.org/#dom-document-createrange
   */
  public func createRange() -> pDOMRange {
    let r = DOMRange()
    r.mStartContainer = self
    r.mEndContainer = self
    r.mStartOffset = 0
    r.mEndOffset = 0
    self.addRangeToRangeCollection(r)
    return r
  }

  /**
   * https://dom.spec.whatwg.org/#dom-document-createnodeiterator
   */
  public func createNodeIterator(_ root: pNode, _ whatToShow: ulong, _ filter: pNodeFilter?) -> pNodeIterator {
    let ni = NodeIterator(root)
    ni.mPointerBeforeReferenceNode = true
    ni.mWhatToShow = whatToShow
    ni.mFilter = filter
    self.addNodeIteratorToNodeIteratorCollection(ni)
    return ni
  }

  /**
   * https://dom.spec.whatwg.org/#dom-document-createtreewalker
   */
  public func createTreeWalker(_ root: pNode, _ whatToShow: ulong, _ filter: pNodeFilter?) -> pTreeWalker {
    let tw = TreeWalker(root)
    tw.mWhatToShow = whatToShow
    tw.mFilter = filter
    return tw
  }

  override init() {
    mURL = "about:blank"
    mMode = "no-quirks"
    type = "xml"
    mInputEncoding = "utf-8"
    mContentType = "application/xml"
    super.init()
  }
}

public typealias XMLDocument = Document
