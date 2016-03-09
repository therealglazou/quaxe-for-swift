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
 * https://dom.spec.whatwg.org/#interface-nodelist
 * 
 * status: done
 */
public class NodeList: pNodeList {
  internal var mNodeArray: Array<pNode>

  internal func cloneAsArray() -> Array<Node> {
    return mNodeArray.map({$0 as! Node}) 
  }

  /**
   * https://dom.spec.whatwg.org/#dom-nodelist-length
   */
  public var length: ulong {
    return ulong(mNodeArray.count)
  }

  /**
   * https://dom.spec.whatwg.org/#dom-nodelist-item
   */
  public func item(index: ulong) -> pNode? {
    if index >= length {
      return nil
    }
    return mNodeArray[Int(index)]
  }

  /**
   * iterable<Node>
   */
  subscript(index: Int) -> pNode {
    get {
      return mNodeArray[index]
    }
    set(newValue) {
      mNodeArray[index] = newValue
    }
  }

  public init() {
    mNodeArray = []
  }
}