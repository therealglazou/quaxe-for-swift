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

import Foundation
import QuaxeUtils

/**
 * https://dom.spec.whatwg.org/#interface-event
 */
 
class Event {

  /**
   * https://dom.spec.whatwg.org/#stop-propagation-flag
   */
  var mStopPropagationFlag: Bool = false
  var mStopImmediatePropagationFlag: Bool = false
  var mCanceledFlag: Bool = false
  var mInitializedFlag: Bool = false
  var mDispatchFlag: Bool = false
  var mInPassiveListenerFlag: Bool = false

  static let NONE :UInt8 = 0
  static let CAPTURING_PHASE :UInt8 = 1
  static let AT_TARGET :UInt8 = 2
  static let BUBBLING_PHASE :UInt8 = 3

  var mType: String
  var type: String { return mType }

  var mTarget: EventTarget?
  var target: EventTarget? { return mTarget }

  var mCurrentTarget: EventTarget?
  var currentTarget: EventTarget? { return mCurrentTarget }

  var mEventPhase: UInt8
  var eventPhase: UInt8 { return mEventPhase } 

  /**
   * https://dom.spec.whatwg.org/#dom-event-stoppropagation
   */
  func stopPropagation() {
    mStopPropagationFlag = true;
  }

  /**
   * https://dom.spec.whatwg.org/#dom-event-stopimmediatepropagation
   */
  func stopImmediatePropagation() {
    mStopPropagationFlag = true
    mStopImmediatePropagationFlag = true
  }

  var mBubbles: Bool
  var bubbles: Bool { return mBubbles }

  var mCancelable: Bool
  var cancelable: Bool { return mCancelable }

  /**
   * https://dom.spec.whatwg.org/#dom-event-preventdefault
   */
  func preventDefault() {
    if mCancelable && !mInPassiveListenerFlag {
      mCanceledFlag = true
    }
  }

  /*
   * https://dom.spec.whatwg.org/#dom-event-defaultprevented
   */
  var defaultPrevented: Bool { return !mCanceledFlag }

  /**
   * https://dom.spec.whatwg.org/#dom-event-istrusted
   */
  var mIsTrusted: Bool
  var isTrusted: Bool { return mIsTrusted }

  var mTimeStamp: DOMTimeStamp
  var timestamp: DOMTimeStamp { return mTimeStamp }

  /**
   * https://dom.spec.whatwg.org/#dom-event-initevent
   */
  func initEvent(type: String, _ bubbles: Bool, _ cancelable: Bool) {
    if !mDispatchFlag {
      mType = type
      mBubbles = bubbles
      mCancelable = cancelable
    }
  }
  
  init(_ type: String, _ canBubble: Bool, _ canBeCanceled: Bool) {
    mType = type
    mBubbles = canBubble
    mCancelable = canBeCanceled

    mTarget = nil
    mCurrentTarget = nil

    mEventPhase = Event.NONE

    mIsTrusted = false
    mTimeStamp = UInt64(NSDate().timeIntervalSince1970 * 1000)
  }
}
