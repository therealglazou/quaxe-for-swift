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

/**
 * https://dom.spec.whatwg.org/#interface-eventtarget
 * 
 * status: done
 */
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

  /**
   * https://dom.spec.whatwg.org/#concept-event-listener-inner-invoke
   */
  static internal func _innerInvoke(object: EventTarget, _ event: Event) -> Bool {
    // Step 1
    var found = false

    // Step 2
    for listener in object.mEventListenersArray {
      // Step 2.1
      if event.type != listener.type {
        continue;
      }

      // Step 2.2
      found = true

      // Step 2.3
      if event.eventPhase == Event.CAPTURING_PHASE &&
         !listener.capture {
        continue;
      }

      // Step 2.4
      if event.eventPhase == Event.BUBBLING_PHASE &&
         listener.capture {
        continue;
      }

      // Step 2.5
      if listener.passive {
        event.setFlag(Event.IN_PASSIVE_LISTENER_FLAG)
      }

      // Step 2.6
      // WARNING: no "callback this value" setting
      // Cf. https://dom.spec.whatwg.org/#concept-event-listener-inner-invoke
      (listener.callback as! pEventListener).handleEvent(event)

      // Step2.7
      event.unsetFlag(Event.IN_PASSIVE_LISTENER_FLAG)

      // Step 2.8
      if event.hasFlag(Event.STOP_IMMEDIATE_PROPAGATION_FLAGS) {
        return found
      }
    }

    // Step 3
    return found
  }

  /**
   * https://dom.spec.whatwg.org/#concept-event-listener-invoke
   */
  static internal func _invoke(object: EventTarget, _ event: Event) -> Void {
    //Step 1
    var listeners: Array<EventListenerStruct> = []

    // Step 2
    for e in object.mEventListenersArray {
      listeners.append(e)
    }

    // Step 3
    event.mCurrentTarget = object

    // Step 4
    let found = EventTarget._innerInvoke(object, event)

    // Step 5
    if !found {
      // Step 5.1
      let originalEventType = event.type

      // Step 5.2
      switch event.type {
        case "animationend":
          event.mType = "webkitAnimationEnd"
        case "animationiteration":
          event.mType = "webkitAnimationIteration"
        case "animationstart":
          event.mType = "webkitAnimationStart"
        case "transitionend":
          event.mType = "webkitTransitionEnd"
        default: return
      }

      // Step 5.3
      EventTarget._innerInvoke(object, event)

      // Step 5.4
      event.mType = originalEventType
    }
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

    // Step 4
    while let parent = eventPath[eventPath.endIndex].getParent(event) {
      eventPath.append(parent)
    }

    // Step 5
    event.mEventPhase = Event.CAPTURING_PHASE

    // Step 6
    for index in (0...eventPath.count-1).reverse() {
      if !event.hasFlag(Event.STOP_PROPAGATION_FLAG) &&
         eventPath[index] !== target {
        EventTarget._invoke(eventPath[index], event)
      }
    }

    // Step 7
    event.mEventPhase = Event.AT_TARGET

    // Step 8
    if !event.hasFlag(Event.STOP_PROPAGATION_FLAG) {
      EventTarget._invoke(target, event)
    }

    // Step 9
    if event.bubbles {
      // Step 9.1
      event.mEventPhase = Event.BUBBLING_PHASE
      // Step 9.2
      for index in (0...eventPath.count-1) {
        if !event.hasFlag(Event.STOP_PROPAGATION_FLAG) &&
           eventPath[index] !== target {
          EventTarget._invoke(eventPath[index], event)
        }
      }
    }

    // Step 10
    event.unsetFlag(Event.DISPATCH_FLAG)

    // Step 11
    event.mEventPhase = Event.NONE

    // Step 12
    event.mCurrentTarget = nil

    // Step 13
    return !event.hasFlag(Event.CANCELED_FLAG)
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
