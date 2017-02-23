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
 * https://www.w3.org/TR/DOM-Level-2-Style/css.html#CSS-CSSRuleList
 */
public class CSSRuleList: pCSSRuleList {
  internal var mRules: Array<CSSRule>

  public var length: ulong { return ulong(self.mRules.count) }

  public func item(index: ulong) -> pCSSRule? {
    if index >= self.length {
      return nil
    }
    return self.mRules[self.mRules.startIndex.advancedBy(Int(index))]
  }

  // XXXX
  internal func _insertRule(rule: DOMString, _ index: ulong) throws -> ulong {
    return 0
  }

  init() {
    mRules = []
  }
}
