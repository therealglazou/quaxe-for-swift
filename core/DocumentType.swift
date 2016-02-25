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

import Foundation

public class DocumentType: Node, pDocumentType {

  internal var mTearoffs: Dictionary<String, AnyObject> = [:]

  public var name: DOMString = ""
  public var publicId: DOMString = ""
  public var systemId: DOMString = ""

  override init() {
    super.init()
  }
}
