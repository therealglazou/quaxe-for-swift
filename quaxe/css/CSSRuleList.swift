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

  public func item(_ index: ulong) -> pCSSRule? {
    if index >= self.length {
      return nil
    }
    return self.mRules[self.mRules.index(self.mRules.startIndex, offsetBy: Int(index))]
  }

  // XXXX
  internal func _insertRule(_ rule: DOMString, _ index: ulong) throws -> ulong {
    return 0
  }

  internal func _deleteRule(_ index: ulong) throws -> Void {
    if index >= self.length {
      throw Exception.IndexSizeError
    }
    mRules.remove(at: Int(index))
  }

  init() {
    mRules = []
  }
}
