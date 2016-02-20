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

public class CustomEvent: Event, pCustomEvent {

  internal var mDetail: Any

  public var detail: Any { return mDetail }

  public func initCustomEvent(aType: DOMString, _ aBubbles: Bool, _ aCancelable: Bool, _ aDetail: Any) -> Void {
    if !hasFlag(Event.DISPATCH_FLAG) {
      super.initEvent(aType, aBubbles, aCancelable)
      mDetail = aDetail
    }
  }

  public required init(_ aType: DOMString, _ aEventInitDict: Dictionary<String, Any>) {
    super.init(aType, aEventInitDict)
    if let detail = aEventInitDict["detail"] {
      mDetail = detail
    }
  }
}
