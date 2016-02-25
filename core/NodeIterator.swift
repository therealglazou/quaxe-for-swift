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

public class NodeIterator: pNodeIterator {
  internal func preRemovingSteps(node: Node) {}
  public var root: pNode = Node()
  public var referenceNode: pNode = Node()
  public var pointerBeforeReferenceNode: Bool = false
  public var whatToShow: ulong = 0
  public var filter: pNodeFilter? 

  public func nextNode() -> pNode? {return nil}
  public func previousNode() -> pNode? {return nil}

  public func detach() -> Void {}

  init() {}
}
