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

/*
 * https://dom.spec.whatwg.org/#interface-customevent
 */

class CustomEvent: Event {

  var mDetail: Any
  var detail: Any { return mDetail }

  /**
   * https://dom.spec.whatwg.org/#dom-customevent-initcustomevent
   */
  func initCustomEvent(aType: String, _ canBubble: Bool, _ canBeCanceled: Bool, _ detail: Any) {
    if !mDispatchFlag {
      initEvent(aType, canBubble, canBeCanceled)
      self.mDetail = detail
    }
  }

  init(aType: String, _ canBubble: Bool, _ canBeCanceled: Bool, _ detail: Any) {
    mDetail = detail
    super.init(aType, canBubble, canBeCanceled)
  }
}
