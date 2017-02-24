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
 * https://dom.spec.whatwg.org/#interface-nodeiterator
 *
 * status: TODO 100%
 */
public class NodeIterator: pNodeIterator {

  internal var mRoot: pNode
  internal var mReferenceNode: pNode
  internal var mWhatToShow: ulong = 0
  internal var mPointerBeforeReferenceNode: Bool = true
  internal var mFilter: pNodeFilter?

  internal func preRemovingSteps(_ node: Node) {}

  public var root: pNode { return mRoot }
  public var referenceNode: pNode { return mReferenceNode }
  public var pointerBeforeReferenceNode: Bool { return mPointerBeforeReferenceNode }
  public var whatToShow: ulong { return mWhatToShow }
  public var filter: pNodeFilter? { return mFilter }

  public func nextNode() -> pNode? {return nil}
  public func previousNode() -> pNode? {return nil}

  public func detach() -> Void {}

  init(_ root: pNode) {
    mRoot = root
    mReferenceNode = root
  }

  // we absolutely need the deiniter because the documents holds a collection
  // of existing iterators and we need to clean that up when the iterator is deleted
  deinit {
    if mRoot.ownerDocument != nil {
      (mRoot.ownerDocument as! Document).removeNodeIteratorFromNodeIteratorCollection(self)
    }
  }

}
