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

public protocol pEventTarget {
  func addEventListener(type: DOMString, _ callback: AnyObject?, _ options: Bool) -> Void
  func addEventListener(type: DOMString, _ callback: AnyObject?, _ options: [String: Bool]) -> Void

  func removeEventListener(type: DOMString, _ callback: AnyObject?, _ options: Bool) -> Void
  func removeEventListener(type: DOMString, _ callback: AnyObject?, _ options: [String: Bool]) -> Void

  func dispatchEvent(event: pEvent) throws -> Bool
}
