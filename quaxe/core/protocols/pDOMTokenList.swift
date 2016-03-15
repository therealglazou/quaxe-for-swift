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

public protocol pDOMTokenList {
  var length: ulong { get }
  func item(index: ulong) -> DOMString?
  func contains(token: DOMString) throws -> Bool
  func add(tokens: DOMString...) throws -> Void
  func remove(tokens: DOMString...) throws -> Void
  func toggle(token: DOMString) throws -> Bool
  func toggle(token: DOMString, _ force: Bool) throws -> Bool
  func replace(token: DOMString, _ newToken: DOMString) throws -> Void
  func supports(token: DOMString) throws -> Bool
  var value: DOMString { get set }
  func toString() -> DOMString
}
