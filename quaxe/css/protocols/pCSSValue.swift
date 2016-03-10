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

public protocol pCSSValue {
  var type: ushort { get }
  var commaSeparated: Bool { get set }
  var length: ulong { get }

  func item(index: ulong) throws -> pCSSValue?
  func setFloatValue(floatValue: Float) throws -> Void
  func getFloatValue() throws -> Float
  func setStringValue(stringValue: DOMString) throws -> Void
  func getStringValue() throws -> DOMString
}
