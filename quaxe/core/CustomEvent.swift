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

/*
 * https://dom.spec.whatwg.org/#interface-customevent
 * 
 * status: done
 */
public class CustomEvent: Event, pCustomEvent {

  internal var mDetail: Any

  /*
   * https://dom.spec.whatwg.org/#dom-customevent-detail
   */
  public var detail: Any { return mDetail }

  /*
   * https://dom.spec.whatwg.org/#dom-customevent-initcustomevent
   */
  public func initCustomEvent(_ type: DOMString, _ bubbles: Bool, _ cancelable: Bool, _ detail: Any) -> Void {
    if !hasFlag(Event.DISPATCH_FLAG) {
      super.initEvent(type, bubbles, cancelable)
      mDetail = detail
    }
  }

  public required init(_ aType: DOMString, _ aEventInitDict: Dictionary<String, Any>,
                       _ aIsTrusted: Bool = false) {
    if let detail = aEventInitDict["detail"] {
      self.mDetail = detail
    }
    else {
      self.mDetail = 0
    }
    super.init(aType, aEventInitDict, false)
  }
}
