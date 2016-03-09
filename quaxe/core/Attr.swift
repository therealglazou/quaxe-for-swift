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
 * https://dom.spec.whatwg.org/#interface-attr
 * 
 * status: done
 */

public class Attr: pAttr {

  internal var mNamespaceURI: DOMString?
  internal var mPrefix: DOMString?
  internal var mLocalName: DOMString = ""
  internal var mValue: DOMString = ""
  internal var mOwnerElement: pElement?

  /**
   * https://dom.spec.whatwg.org/#dom-attr-namespaceuri
   */
  public var namespaceURI: DOMString? {
    return mNamespaceURI
  }

  /**
   * https://dom.spec.whatwg.org/#dom-attr-prefix
   */
  public var prefix: DOMString? {
    return mPrefix
  }

  /**
   * https://dom.spec.whatwg.org/#dom-attr-localname
   */
  public var localName: DOMString {
    return mLocalName
  }

  /**
   * https://dom.spec.whatwg.org/#dom-attr-name
   */
  public var name: DOMString {
    var rv: DOMString = ""
    if nil != mPrefix {
      rv += mPrefix! + ":"
    }
    rv += mLocalName
    return rv
  }

  /**
   * https://dom.spec.whatwg.org/#dom-attr-nodename
   */
  public var nodeName: DOMString { return self.name }

  /**
   * https://dom.spec.whatwg.org/#dom-attr-value
   */
  public var value: DOMString {
    get {
      return mValue
    }

    set {
      mValue = newValue
      if nil != mOwnerElement {
        mOwnerElement!.setAttributeNS(mNamespaceURI, mLocalName, newValue)
      }
    }
  }

  public var nodeValue: DOMString {
    get {
      return self.value
    }

    set {
      self.value = newValue
    }
  }

  public var textContent: DOMString {
    get {
      return self.value
    }

    set {
      self.value = newValue
    }
  }

  /**
   * https://dom.spec.whatwg.org/#dom-attr-ownerelement
   */
  public var ownerElement: pElement? {
    return mOwnerElement
  }

  /**
   * https://dom.spec.whatwg.org/#dom-attr-specified
   */
  public var specified: Bool { return true }

  init() {}

  init(_ givenName: DOMString) {
    mLocalName = givenName
  }

  init(givenName: DOMString, _ namespaceURI: DOMString?, _ prefix: DOMString?, _ value: DOMString, _ownerElement: Element?) {
    mLocalName = givenName
    mNamespaceURI = namespaceURI
    mPrefix = prefix
    mValue = value
    mOwnerElement = ownerElement
  }
}
