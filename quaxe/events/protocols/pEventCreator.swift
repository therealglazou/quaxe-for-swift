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

public protocol pEventCreator {
  static func createEvent(interface: DOMString, _ aEventInitDict: Dictionary<String, Any>) -> pEvent
}
