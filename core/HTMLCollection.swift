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

public class HTMLCollection: pHTMLCollection {

  internal func append(element: pElement) -> Void {
    mArray.append(element)
  }

  internal func clobber() -> Void {
    mArray = []
  }

  internal var mArray: Array<pElement> = []
  
  public var length: ulong {
    return ulong(self.mArray.count)
  }

  public func item(index: ulong) -> pElement? {
    if index >= self.length {
      return nil
    }
    return mArray[Int(index)]
  }

  public func namedItem(name: DOMString) -> pElement? {
    let index = mArray.indexOf({ return $0.getAttribute("id") == name})
    if nil != index {
      return mArray[index!]
    }
    return nil
  }

  init() {}

  init(_ elements: Array<pElement>) {
    mArray = elements
  }
}
