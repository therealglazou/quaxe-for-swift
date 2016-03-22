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

  /**
   * https://dom.spec.whatwg.org/#concept-element-attributes-get-by-namespace
   */
  static internal func getAttributeByNamespaceAndLocalName(elt: Element,
                                                           _ ns: DOMString?,
                                                           _ name: DOMString) -> Attr? {
    let namespace: DOMString? = (ns == "") ? nil : ns;

    for attr in (elt.attributes as! NamedNodeMap).mAttributes {
      if attr.namespaceURI == namespace &&
         attr.localName == name {
        return attr
      }
    }

    return nil
  }

  /**
   * https://dom.spec.whatwg.org/#concept-element-attributes-set-value
   */
  static internal func setAttributeByLocalNameAndValue(elt: Element,
                                                       _ name: DOMString,
                                                       _ v: DOMString,
                                                       _ ns: DOMString? = nil,
                                                       _ prefix: DOMString? = nil) -> Void {
    //Step 3
    let attr = Element.getAttributeByNamespaceAndLocalName(elt, ns, name)
    // Step 4
    if attr == nil {
      let newAttr = Attr(name, ns, prefix, v, elt)
      (elt.attributes as! NamedNodeMap).mAttributes.append(newAttr)
      return
    }
    // Step 5
    attr!.value = v
  }

  /**
   * https://dom.spec.whatwg.org/#concept-element-attributes-get-by-name
   */
  static internal func getAttributeByName(elt: Element,
                                          _ qname: DOMString) -> Attr? {
    let qualifiedName: DOMString = (elt.namespaceURI == Namespaces.HTML_NAMESPACE &&
                         elt.ownerDocument != nil &&
                         elt.ownerDocument!.type == "html")
                          ? qname.lowercaseString
                          : qname;

    for attr in (elt.attributes as! NamedNodeMap).mAttributes {
      if attr.name == qualifiedName {
        return attr
      }
    }

    return nil
  }

  /**
   * https://dom.spec.whatwg.org/#dom-element-namespaceuri
   */
  public var namespaceURI: DOMString? { return mNamespaceURI }

  /**
   * https://dom.spec.whatwg.org/#dom-element-prefix
   */
  public var prefix: DOMString? { return mPrefix }

  /**
   * https://dom.spec.whatwg.org/#dom-element-localname
   */
  public var localName: DOMString = ""

  /**
   * https://dom.spec.whatwg.org/#dom-element-tagname
   */
  public var tagName: DOMString {
    // Step 1
    var qname = qualifiedName

        // Step 2
    if let ns = mNamespaceURI {
      if Namespaces.HTML_NAMESPACE == ns {
        if let d = ownerDocument {
          if d.type == "html" {
            qname = qname.uppercaseString
          }
        }
      }
    }

    // Step 3
    return qname
  }

  /**
   * https://dom.spec.whatwg.org/#dom-element-id
   * https://dom.spec.whatwg.org/#concept-reflect
   */
  public var id: DOMString {
    get {
      let attr = Element.getAttributeByNamespaceAndLocalName(self, nil, "id")
      if attr == nil {
        return ""
      }
      return attr!.value
    }

    set(newValue) {
      Element.setAttributeByLocalNameAndValue(self, "id", newValue)
    }
  }

  /**
   * https://dom.spec.whatwg.org/#dom-element-classname
   * https://dom.spec.whatwg.org/#concept-reflect
   */
  public var className: DOMString {
    get {
      let attr = Element.getAttributeByNamespaceAndLocalName(self, nil, "class")
      if attr == nil {
        return ""
      }
      return attr!.value
    }

    set(newValue) {
      Element.setAttributeByLocalNameAndValue(self, "class", newValue)
    }
  }

  /**
   * https://dom.spec.whatwg.org/#dom-element-classlist
   */
  public var classList: pDOMTokenList {
    let dtl = DOMTokenList(self, "class")
    dtl.value = self.className
    return dtl
  }

  /**
   * https://dom.spec.whatwg.org/#dom-element-hasattributes
   */
  public func hasAttributes() -> Bool {
    return (self.attributes as! NamedNodeMap).mAttributes.count >= 0
  }

  /**
   * https://dom.spec.whatwg.org/#dom-element-attributes
   */
  public var attributes: pNamedNodeMap = NamedNodeMap()

  /**
   * https://dom.spec.whatwg.org/#dom-element-getattributenames
   */
  public func getAttributeNames() -> Array<DOMString> {
    var rv: Array<DOMString> = []
    for attr in (self.attributes as! NamedNodeMap).mAttributes {
      rv.append(attr.name)
    }
    return rv
  }

  /**
   * https://dom.spec.whatwg.org/#dom-element-getattribute
   */
  public func getAttribute(qualifiedName: DOMString) -> DOMString? {
    let attr = Element.getAttributeByName(self, qualifiedName)
    if attr == nil {
      return nil
    }
    return attr!.value
  }

  /**
   * https://dom.spec.whatwg.org/#dom-element-getattributens
   */
  public func getAttributeNS(ns: DOMString?, _ localName: DOMString) -> DOMString? {
    let attr = Element.getAttributeByNamespaceAndLocalName(self, ns, localName)
    if attr == nil {
      return nil
    }
    return attr!.value
  }

  /**
   * https://dom.spec.whatwg.org/#dom-element-setattribute
   */
  public func setAttribute(qname: DOMString, _ v: DOMString) throws -> Void {
    //Step 1
    try Namespaces.validateAsXMLName(qname)

    // Step 2
    let qualifiedName = (self.namespaceURI == Namespaces.HTML_NAMESPACE &&
                         self.ownerDocument != nil &&
                         self.ownerDocument!.type == "html")
                          ? qname.lowercaseString
                          : qname;

    // Step 3
    var attribute: Attr? = nil
    for attr in (self.attributes as! NamedNodeMap).mAttributes {
      if attr.name == qualifiedName {
        attribute = attr
        break;
      }
    }

    // Step 4
    if attribute == nil {
      let newAttr = Attr(qualifiedName, nil, nil, v, self)
      (self.attributes as! NamedNodeMap).mAttributes.append(newAttr)
      return
    }

    // Step 5
    attribute!.value = v
  }

  /**
   * https://dom.spec.whatwg.org/#dom-element-setattributens
   */
  public func setAttributeNS(ns: DOMString?, _ qname: DOMString, _ v: DOMString) throws -> Void {
    let d = try Namespaces.validateAndExtract(ns, qname)
    Element.setAttributeByLocalNameAndValue(self,
                                            d["localName"]!!,
                                            v,
                                            d["namespace"]!,
                                            d["prefix"]!)
  }

  /**
   * https://dom.spec.whatwg.org/#dom-element-removeattribute
   */
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
    self.attributes = NamedNodeMap(self)
  }
}