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

public protocol pEventTarget {
  func addEventListener(_ type: DOMString, _ callback: AnyObject?, _ options: Bool) -> Void
  func addEventListener(_ type: DOMString, _ callback: AnyObject?, _ options: [String: Bool]) -> Void

  func removeEventListener(_ type: DOMString, _ callback: AnyObject?, _ options: Bool) -> Void
  func removeEventListener(_ type: DOMString, _ callback: AnyObject?, _ options: [String: Bool]) -> Void

  func dispatchEvent(_ event: pEvent) throws -> Bool
}
