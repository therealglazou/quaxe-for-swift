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



public class DocumentFragment: Node, pDocumentFragment {

  internal var mNonElementParentNodeTearoff: NonElementParentNode
  internal var mParentNodeTearoff: ParentNode

  override init() {
    self.mNonElementParentNodeTearoff = NonElementParentNode()
    self.mParentNodeTearoff = ParentNode()
    super.init()
    self.mNonElementParentNodeTearoff.setOwnerNode(self)
    self.mParentNodeTearoff.setOwnerNode(self)
  }
}