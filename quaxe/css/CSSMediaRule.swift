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
 * https://www.w3.org/TR/DOM-Level-2-Style/css.html#CSS-CSSMediaRule
 */
public class CSSMediaRule: CSSRule, pCSSMediaRule {
  internal var mMedia: pMediaList
  internal var mCssRules: pCSSRuleList

  public var media: pMediaList { return mMedia }

  public var cssRules: pCSSRuleList { return mCssRules }

  public func insertRule(rule: DOMString, _ index: ulong) throws -> ulong {
    // XXXX parse and insert the rule
    return 0
  }

  public func deleteRule(index: ulong) throws -> Void {
    try (mCssRules as! CSSRuleList)._deleteRule(index)
  }

  override init(_ parentStyleSheet: pCSSStyleSheet, _ parentRule: pCSSRule?) {
    mMedia = MediaList()
    mCssRules = CSSRuleList()
    super.init(parentStyleSheet, parentRule)
    mType = CSSRule.MEDIA_RULE
  }
}
