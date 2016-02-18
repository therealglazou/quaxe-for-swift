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

public protocol EventTarget {
  func addEventListener(type: DOMString, _ callback: EventListener?, _ options: Bool) -> Void
  func addEventListener(type: DOMString, _ callback: EventListener?, _ options: [String: Bool]) -> Void

  func removeEventListener(type: DOMString, _ callback: EventListener?, _ options: Bool) -> Void
  func removeEventListener(type: DOMString, _ callback: EventListener?, _ options: [String: Bool]) -> Void

  func dispatchEvent(event: Event) -> Bool
}
