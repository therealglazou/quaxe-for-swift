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

public protocol pEvent {
  var type:             DOMString    { get }
  var target:           pElement?     { get }
  var currentTarget:    pElement?     { get }

  var eventPhase:       ushort        { get }

  func stopPropagation() -> Void
  func stopImmediatePropagation() -> Void

  var bubbles:          Bool         { get }
  var cancelable:       Bool         { get }
  func preventDefault() -> Void
  var defaultPrevented: Bool         { get }

  var isTrusted:        Bool         { get }
  var timeStamp:        DOMTimeStamp { get }

  func initEvent(type: DOMString, _ bubbles: Bool, _ cancelable: Bool) -> Void

  init(_ type: DOMString, _ eventInitDict: Dictionary<String, Bool>)
}
