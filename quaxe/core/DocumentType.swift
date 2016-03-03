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

import QuaxeCoreProtocols

public class DocumentType: Node, pDocumentType {

  internal var mName: DOMString = ""
  internal var mPublicId: DOMString = ""
  internal var mSystemId: DOMString = ""

  public var name: DOMString { return mName }
  public var publicId: DOMString { return mPublicId }
  public var systemId: DOMString { return mSystemId }

  override init() {
    super.init()
  }
}
