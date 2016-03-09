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
 * https://dom.spec.whatwg.org/#interface-treewalker
 * 
 * status: TODO 100%
 */
public class TreeWalker: pTreeWalker {

  internal var mRoot: pNode
  internal var mWhatToShow: ulong = 0
  internal var mFilter: pNodeFilter?

  public var root: pNode { return mRoot}
  public var whatToShow: ulong { return mWhatToShow }
  public var filter: pNodeFilter? { return mFilter }
  public var currentNode: pNode

  public func parentNode() -> pNode? { return nil}
  public func firstChild() -> pNode? { return nil}
  public func lastChild() -> pNode? { return nil}
  public func previousSibling() -> pNode? { return nil}
  public func nextSibling() -> pNode? { return nil}
  public func previousNode() -> pNode? { return nil}
  public func nextNode() -> pNode? { return nil}

  init(_ root: pNode) {
    mRoot = root
    currentNode = root
  }
}
