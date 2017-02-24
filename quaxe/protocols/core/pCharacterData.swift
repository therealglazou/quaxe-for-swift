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

public protocol pCharacterData: pNode {
  var data: DOMString { get set }
  var length: ulong { get }
  func substringData(_ offset: ulong, _ count: ulong) throws -> DOMString
  func appendData(_ data: DOMString) throws -> Void
  func insertData(_ offset: ulong, _ data: DOMString) throws -> Void
  func deleteData(_ offset: ulong, _ count: ulong) throws -> Void
  func replaceData(_ offset: ulong, _ count: ulong, _ data: DOMString) throws -> Void
}
