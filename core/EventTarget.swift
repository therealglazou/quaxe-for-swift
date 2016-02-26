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

  internal func getParent(event: Event) -> EventTarget? {
    return nil
  }

  static internal func _dispatchEvent(event: Event, _ target: EventTarget, _ targetOverride: EventTarget? = nil) throws -> Bool {
    // Step 1
    event.setFlag(Event.DISPATCH_FLAG)

    // Step 2
    if nil != targetOverride {
      event.mTarget = targetOverride!
    }
    else {
      event.mTarget = target
    }

    // Step 3
    var eventPath = [ target ]
    while let parent = eventPath[eventPath.endIndex].getParent(event) {
      eventPath.append(parent)
    }

    // Step 4
    event.mEventPhase = Event.CAPTURING_PHASE

    // Step 5
    // TODO
        return false
  }

  /**
   * https://dom.spec.whatwg.org/#interface-eventtarget
   */

  public func addEventListener(type: DOMString, _ callback: AnyObject?, _ options: Bool) -> Void {
    let toStore = EventListenerStruct(type, callback, options, false)
    mEventListenersArray.append(toStore)
  }

  public func addEventListener(type: DOMString, _ callback: AnyObject?, _ options: [String: Bool]) -> Void {
    var capture: Bool = false
    var passive: Bool = false
    flatten(options, &capture, &passive)
    let toStore = EventListenerStruct(type, callback, capture, passive)
    mEventListenersArray.append(toStore)
  }

  /*
   * https://dom.spec.whatwg.org/#dom-eventtarget-removeeventlistener
   */
  public func removeEventListener(type: DOMString, _ callback: AnyObject?, _ options: Bool) -> Void {
    let toStore = EventListenerStruct(type, callback, options, false)
    if let index = mEventListenersArray.indexOf(toStore) {
      mEventListenersArray.removeAtIndex(index)
    }
  }

  public func removeEventListener(type: DOMString, _ callback: AnyObject?, _ options: [String: Bool]) -> Void {
    var capture: Bool = false
    var passive: Bool = false
    flatten(options, &capture, &passive)
    let toStore = EventListenerStruct(type, callback, capture, passive)
    if let index = mEventListenersArray.indexOf(toStore) {
      mEventListenersArray.removeAtIndex(index)
    }
  }

  /*
   * https://dom.spec.whatwg.org/#dom-eventtarget-dispatchevent
   */
  public func dispatchEvent(event: pEvent) throws -> Bool {
    if (event as! Event).hasFlag(Event.DISPATCH_FLAG) ||
       !(event as! Event).hasFlag(Event.INITIALIZED_FLAG) {
      throw Exception.InvalidStateError
    }

    (event as! Event).mIsTrusted = false
    return try EventTarget._dispatchEvent(event as! Event, self as! Element)
  }

  init() { mEventListenersArray = [] }
}