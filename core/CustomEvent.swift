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

public class CustomEvent: Event, pCustomEvent {

  internal var mDetail: Any

  public var detail: Any { return mDetail }

  public func initCustomEvent(aType: DOMString, _ aBubbles: Bool, _ aCancelable: Bool, _ aDetail: Any) -> Void {
    if !hasFlag(Event.DISPATCH_FLAG) {
      super.initEvent(aType, aBubbles, aCancelable)
      mDetail = aDetail
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
