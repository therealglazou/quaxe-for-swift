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

import QuaxeCoreProtocols

internal struct EventListenerStruct: Equatable {
  var type: DOMString
  var callback: AnyObject?
  var capture: Bool
  var passive: Bool

  init(_ aType: DOMString, _ aCallback: AnyObject?, _ aCapture: Bool, _ aPassive: Bool) {
    type = aType
    callback = aCallback
    capture = aCapture
    passive = aPassive
  }

}

func == (lhs: EventListenerStruct, rhs: EventListenerStruct) -> Bool {
  return lhs.type == rhs.type &&
         ((nil == lhs.callback && nil != rhs.callback) ||
          (nil == rhs.callback && nil != lhs.callback) ||
          lhs.callback! === rhs.callback!) &&
         lhs.capture == rhs.capture &&
         lhs.passive == rhs.passive
}

public class EventTarget: pEventTarget {

  internal var mEventListenersArray: Array<EventListenerStruct>

  private func flatten(options: [String: Bool], inout _ capture: Bool, inout _ passive: Bool) -> Void {
    capture = false
    passive = false
    if let captureTemp = options["capture"] {
      capture = captureTemp
    } 
    if let passiveTemp = options["passive"] {
      passive = passiveTemp
    } 
  }

  /**
   * https://dom.spec.whatwg.org/#interface-eventtarget
   */

  public func addEventListener(type: DOMString, _ callback: AnyObject?, _ options: Bool) -> Void {
    let toStore = EventListenerStruct(type, callback, options, false)
    mEventListenersArray.append(toStore)
  }

  public func addEventListener(type: DOMString, _ callback: AnyObject?, _ options: [String: Bool]) -> Void {
    var capture: Bool
    var passive: Bool
    flatten(options, &capture, &passive)
    let toStore = EventListenerStruct(type, callback, capture, passive)
    mEventListenersArray.append(toStore)
  }

  public func removeEventListener(type: DOMString, _ callback: AnyObject?, _ options: Bool) -> Void {
    let toStore = EventListenerStruct(type, callback, options, false)
    if let index = mEventListenersArray.indexOf(toStore) {
      mEventListenersArray.removeAtIndex(index)
    }
  }

  public func removeEventListener(type: DOMString, _ callback: AnyObject?, _ options: [String: Bool]) -> Void {
    var capture: Bool
    var passive: Bool
    flatten(options, &capture, &passive)
    let toStore = EventListenerStruct(type, callback, capture, passive)
    if let index = mEventListenersArray.indexOf(toStore) {
      mEventListenersArray.removeAtIndex(index)
    }
  }

  public func dispatchEvent(event: pEvent) throws -> Bool {
    // TODO
    return false
  }

  init() {}
}