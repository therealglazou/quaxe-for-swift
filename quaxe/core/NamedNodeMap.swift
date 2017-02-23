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

/**
 * https://dom.spec.whatwg.org/#interface-namednodemap
 * 
 * status: TODO 100%
 */
public class NamedNodeMap: pNamedNodeMap {

  internal var mAttributes: Array<Attr> = []
  internal weak var mOwnerElement: Element?

  /**
   * https://dom.spec.whatwg.org/#dom-namednodemap-length
   */
  public var length: ulong {
    return ulong(self.mAttributes.count)
  }

  /**
   * https://dom.spec.whatwg.org/#dom-namednodemap-item
   */
  public func item(index: ulong) -> pAttr? {
    if index >= self.length {
      return nil
    }
    return self.mAttributes[self.mAttributes.startIndex.advancedBy(Int(index))]
  }

  /**
   * https://dom.spec.whatwg.org/#dom-namednodemap-getnameditem
   */
  public func getNamedItem(qualifiedName: DOMString) -> pAttr? {return nil}
  public func getNamedItemNS(namespace: DOMString?, _ localName: DOMString) -> pAttr? {return nil}
  public func setNamedItem(attr: pAttr) -> pAttr? {return nil}
  public func setNamedItemNS(attr: pAttr) -> pAttr? {return nil}
  public func removeNamedItem(qualifiedName: DOMString) -> pAttr {return Attr()}
  public func removeNamedItem(namespace: DOMString?, _ localName: DOMString) -> pAttr {return Attr()}

  public init(_ elt: Element) {
    self.mOwnerElement = elt
  }

  init() {}
}
