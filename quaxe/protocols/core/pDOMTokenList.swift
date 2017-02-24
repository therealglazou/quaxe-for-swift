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

public protocol pDOMTokenList {
  var length: ulong { get }
  func item(_ index: ulong) -> DOMString?
  func contains(_ token: DOMString) throws -> Bool
  func add(_ tokens: DOMString...) throws -> Void
  func remove(_ tokens: DOMString...) throws -> Void
  func toggle(_ token: DOMString) throws -> Bool
  func toggle(_ token: DOMString, _ force: Bool) throws -> Bool
  func replace(_ token: DOMString, _ newToken: DOMString) throws -> Void
  func supports(_ token: DOMString) throws -> Bool
  var value: DOMString { get set }
  func toString() -> DOMString
}
