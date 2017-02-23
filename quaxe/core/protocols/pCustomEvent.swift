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

public protocol pCustomEvent: pEvent {
  var detail:             Any    { get }

  func initCustomEvent(type: DOMString, _ bubbles: Bool, _ cancelable: Bool, _ detail: Any) -> Void

  init(_ type: DOMString, _ eventInitDict: Dictionary<String, Any>,
       _ aIsTrusted: Bool)
}
