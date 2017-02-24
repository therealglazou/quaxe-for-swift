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

public protocol pEvent {
  var type:             DOMString    { get }
  var target:           pEventTarget?     { get }
  var currentTarget:    pEventTarget?     { get }

  var eventPhase:       ushort        { get }

  func stopPropagation() -> Void
  func stopImmediatePropagation() -> Void

  var bubbles:          Bool         { get }
  var cancelable:       Bool         { get }
  func preventDefault() -> Void
  var defaultPrevented: Bool         { get }

  var isTrusted:        Bool         { get }
  var timeStamp:        DOMTimeStamp { get }

  func initEvent(_ type: DOMString, _ bubbles: Bool, _ cancelable: Bool) -> Void

  init(_ aType: DOMString, _ aEventInitDict: Dictionary<String, Any>,
       _ aIsTrusted: Bool)
}
