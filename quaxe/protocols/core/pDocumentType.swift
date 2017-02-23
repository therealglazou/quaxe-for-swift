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

public protocol pDocumentType: pNode {
  var name: DOMString { get }
  var publicId: DOMString { get }
  var systemId: DOMString { get }
}
