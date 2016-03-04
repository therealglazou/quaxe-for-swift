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

public protocol pCharacterData: pNode {
  var data: DOMString { get set }
  var length: ulong { get }
  func substringData(offset: ulong, _ count: ulong) throws -> DOMString
  func appendData(data: DOMString) throws -> Void
  func insertData(offset: ulong, _ data: DOMString) throws -> Void
  func deleteData(offset: ulong, _ count: ulong) throws -> Void
  func replaceData(offset: ulong, _ count: ulong, _ data: DOMString) throws -> Void
}
