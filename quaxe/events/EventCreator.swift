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

public class EventCreator: pEventCreator {
  public static func createEvent(interface: DOMString, _ aEventInitDict: Dictionary<String, Any>) -> pEvent {
    // TODO
    return Event(interface, [:])
  }
}
