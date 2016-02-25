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

public class TreeWalker: pTreeWalker {
  public var root: pNode = Node()
  public var whatToShow: ulong = 0
  public var filter: pNodeFilter? = nil
  public var currentNode: pNode = Node()

  public func parentNode() -> pNode? { return nil}
  public func firstChild() -> pNode? { return nil}
  public func lastChild() -> pNode? { return nil}
  public func previousSibling() -> pNode? { return nil}
  public func nextSibling() -> pNode? { return nil}
  public func previousNode() -> pNode? { return nil}
  public func nextNode() -> pNode? { return nil}

  init() {}
}
