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

  internal var mName: DOMString = ""
  internal var mPublicId: DOMString = ""
  internal var mSystemId: DOMString = ""

  public var name: DOMString { return mName }
  public var publicId: DOMString { return mPublicId }
  public var systemId: DOMString { return mSystemId }

  init(_ name: DOMString, _ publicId: DOMString = "", _ systemId: DOMString = "") {
    self.mName = name
    self.mPublicId = publicId
    self.mSystemId = systemId
    super.init()
  }
}
