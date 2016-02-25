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

public class NodeList: pNodeList {
  internal var mNodeArray: Array<pNode>

  internal func cloneAsArray() -> Array<Node> {
    return mNodeArray.map({$0 as! Node}) 
  }

  public var length: ulong {
    return ulong(mNodeArray.count)
  }

  public func item(index: ulong) -> pNode? {
    if index >= length {
      return nil
    }
    return mNodeArray[Int(index)]
  }

  public init() {
    mNodeArray = []
  }
}