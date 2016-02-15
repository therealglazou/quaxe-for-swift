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

/**
 * https://dom.spec.whatwg.org/#interface-eventtarget
 */
 
 protocol EventListener {
  func handleEvent()
 }
 
 protocol EventTarget {
  func addEventListener(type: String, callback: EventListener?, capture: Bool) -> Void
  func removeEventListener(type: String, callback: EventListener?, capture: Bool) -> Void
  func dispatchEvent(event: Event) -> Void
 }
 