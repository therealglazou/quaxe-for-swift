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

protocol CustomEvent: Event {
  var detail:             Any    { get }

  func initCustomEvent(type: DOMString, _ bubbles: Bool, _ cancelable: Bool) -> Void

  init(type: DOMString, _ eventInitDict: Dictionary<String, Any>)
}
