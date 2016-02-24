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

  internal var mNonElementParentNodeTearoff: NonElementParentNode
  internal var mParentNodeTearoff: ParentNode

  internal var rangeCollection: Array<DOMRange> = []
  internal var nodeIteratorCollection: Array<NodeIterator> = []

  public var type: DOMString = "xml"

  public var implementation: pDOMImplementation = DOMImplementation()
  public var URL: DOMString = ""
  public var documentURI: DOMString = ""
  public var origin: DOMString = ""
  public var compatMode: DOMString = ""
  public var characterSet: DOMString = ""
  public var charset: DOMString = ""
  public var inputEncoding: DOMString = ""
  public var contentType: DOMString = ""

  public var doctype: pDocumentType?
  public var documentElement: pElement?

  public func getElementsByTagName(qualifiedName: DOMString) -> pHTMLCollection { return HTMLCollection()}
  public func getElementsByTagNameNS(namespace: DOMString, _ localName: DOMString) -> pHTMLCollection {return HTMLCollection()}
  public func getElementsByClassName(classNames: DOMString) -> pHTMLCollection {return HTMLCollection()}

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

  public func createEvent(interface: DOMString) -> pEvent {return Event()}

  public func createRange() -> pDOMRange {return DOMRange()}

  public func createNodeIterator(root: pNode, _ whatToShow: ulong, _ filter: pNodeFilter?) -> pNodeIterator {return NodeIterator()}
  public func createTreeWalker(root: pNode, _ whatToShow: ulong, _ filter: pNodeFilter?) -> pTreeWalker {return TreeWalker()}

  override init() {
    self.mNonElementParentNodeTearoff = NonElementParentNode()
    self.mParentNodeTearoff = ParentNode()
    super.init()
    self.mNonElementParentNodeTearoff.setOwnerNode(self)
    self.mParentNodeTearoff.setOwnerNode(self)
  }
}
