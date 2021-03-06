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
 * https://dom.spec.whatwg.org/#interface-htmlcollection
 * 
 * status: done
 */
public class HTMLCollection: pHTMLCollection {

  internal func append(_ element: pElement) -> Void {
    mArray.append(element)
  }

  internal func clobber() -> Void {
    mArray = []
  }

  internal var mArray: Array<pElement> = []
  
  /**
   * https://dom.spec.whatwg.org/#dom-htmlcollection-length
   */
  public var length: ulong {
    return ulong(self.mArray.count)
  }

  /**
   * https://dom.spec.whatwg.org/#dom-htmlcollection-item
   */
  public func item(_ index: ulong) -> pElement? {
    if index >= self.length {
      return nil
    }
    return mArray[Int(index)]
  }

  /**
   * https://dom.spec.whatwg.org/#dom-htmlcollection-nameditem
   */
  public func namedItem(_ name: DOMString) -> pElement? {
    // Step 1
    if name.isEmpty {
      return nil
    }

    // Step 2
    for element in mArray {
      if element.getAttribute("id") == name ||
         (element.namespaceURI != nil &&
          element.namespaceURI! == Namespaces.HTML_NAMESPACE &&
          element.getAttributeNS(nil, "name") == name) {
        return element
      }
    }
    return nil;
  }

  init() {}

  init(_ elements: Array<pElement>) {
    mArray = elements
  }
}
