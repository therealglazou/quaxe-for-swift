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



public class DocumentType: Node, pDocumentType {

  internal var mChildNodeTearoff: ChildNode

  public var name: DOMString = ""
  public var publicId: DOMString = ""
  public var systemId: DOMString = ""

  override init() {
    self.mChildNodeTearoff = ChildNode()
    super.init()
    self.mChildNodeTearoff.setOwnerNode(self)
  }
}
