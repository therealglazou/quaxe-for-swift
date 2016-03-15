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
  func contains(token: DOMString) -> Bool
  func add(tokens: DOMString...) -> Void
  func remove(tokens: DOMString...) -> Void
  func toggle(token: DOMString, _ force: Bool) -> Bool
  func replace(token: DOMString, _ newToken: DOMString) -> Void
  func supports(token: DOMString) -> Bool
  var value: DOMString { get set }
  func toString() -> DOMString
}
