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


import Foundation

public class Element: Node, pElement {

  internal var mChildNodeTearoff: ChildNode
  internal var mNonDocumentTypeChildNodeTearoff: NonDocumentTypeChildNode
  internal var mParentNodeTearoff: ParentNode

  static let HTML_NAMESPACE: DOMString = "http://www.w3.org/1999/xhtml"

  internal var mNamespaceURI: DOMString?
  internal var mPrefix: DOMString?
  internal var mLocalName: DOMString = ""

  internal var qualifiedName: DOMString {
    var rv = ""
    if nil != mPrefix {
     rv += mPrefix! + ":"
    }
    return rv + mLocalName
  }

  public var namespaceURI: DOMString? { return mNamespaceURI }

  public var prefix: DOMString? { return mPrefix }

  public var tagName: DOMString {
    var qname = qualifiedName
    if let ns = mNamespaceURI {
      if Element.HTML_NAMESPACE == ns {
        if let d = ownerDocument {
          if d.type == "html" {
            qname = qname.uppercaseString
          }
        }
      }
    }
    return qname
  }

  public var localName: DOMString = ""
  public var id: DOMString = ""
  public var className: DOMString = ""
  public var classList: pDOMTokenList = DOMTokenList()

  public func hasAttributes() -> Bool {return false}
  public var attributes: pNamedNodeMap = NamedNodeMap()
  public func getAttributeNames() -> Array<DOMString> { return []}
  public func getAttribute(qualifiedName: DOMString) -> DOMString? { return nil}
  public func getAttributeNS(namespace: DOMString, _localName: DOMString) -> DOMString? { return nil}
  public func setAttribute(qualifiedName: DOMString, _ value: DOMString) -> Void {}
  public func setAttributeNS(namespace: DOMString?, _ qualifiedName: DOMString, _ value: DOMString) -> Void {}
  public func removeAttribute(qualifiedName: DOMString) -> Void {}
  public func removeAttributeNS(namespace: DOMString?, _ qualifiedName: DOMString) -> Void {}
  public func hasAttribute(qualifiedName: DOMString) -> Bool {return false}
  public func hasAttributeNS(namespace: DOMString?, _ qualifiedName: DOMString) -> Bool {return false}

  public func getAttributeNode(qualifiedName: DOMString) -> pAttr? { return nil}
  public func getAttributeNodeNS(namespace: DOMString?, _ localName: DOMString) -> pAttr? { return nil}
  public func setAttributeNode(attr: pAttr) -> pAttr? { return nil}
  public func setAttributeNodeNS(attr: pAttr) -> pAttr? { return nil}
  public func removeAttributeNode(attr: pAttr) -> pAttr { return Attr()}

  public func closest(selectors: DOMString) -> pElement? { return nil}
  public func matches(selectors: DOMString) -> Bool {return false}

  public func getElementsByTagName(qualifiedName: DOMString) -> pHTMLCollection { return HTMLCollection() }
  public func getElementsByTagNameNS(namespace: DOMString?, _ localName: DOMString) -> pHTMLCollection { return HTMLCollection() }
  public func getElementsByClassName(classNames: DOMString) -> pHTMLCollection { return HTMLCollection() }

  override init() {
    self.mChildNodeTearoff = ChildNode()
    self.mNonDocumentTypeChildNodeTearoff = NonDocumentTypeChildNode()
    self.mParentNodeTearoff = ParentNode()
    super.init()
    self.mChildNodeTearoff.setOwnerNode(self)
    self.mNonDocumentTypeChildNodeTearoff.setOwnerNode(self)
    self.mParentNodeTearoff.setOwnerNode(self)
  }
}