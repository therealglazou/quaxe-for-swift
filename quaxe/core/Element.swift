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
 * https://dom.spec.whatwg.org/#interface-element
 * 
 * status: TODO 80%
 */
public class Element: Node, pElement {

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
      if Namespaces.HTML_NAMESPACE == ns {
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
  public func getAttributeNS(namespace: DOMString?, _ localName: DOMString) -> DOMString? { return nil}
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

  public func definesSupportedTokens(attributeName: DOMString) -> Bool {
    return true
  }

  public func supportsToken(attributeName: DOMString, _ token: DOMString) -> Bool {
    return true
  }

  override init() {
    super.init()
  }
}