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

public protocol pMediaList {
  var mediaText: DOMString { get set }

  var length: ulong { get }
  func item(index: ulong) -> DOMString?
  func deleteMedium(oldMedium: DOMString) throws -> Void
  func appendMedium(newMedium: DOMString) throws -> Void
}
