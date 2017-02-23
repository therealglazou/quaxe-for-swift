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
 * https://www.w3.org/TR/DOM-Level-2-Style/css.html#CSS-CSSStyleRule
 */
public class CSSStyleRule: CSSRule, pCSSStyleRule {

  internal var mSelectorText: DOMString
  internal var mStyle: pCSSStyleDeclaration

  // XXXX
  public var selectorText: DOMString {
    get {
      return mSelectorText
    }
    set {
      mSelectorText = newValue
    }
  }

  public var style: pCSSStyleDeclaration { return mStyle }

  override init(_ parentStyleSheet: pCSSStyleSheet, _ parentRule: pCSSRule?) {
    mSelectorText = ""
    mStyle = CSSStyleDeclaration()
    super.init(parentStyleSheet, parentRule)
    mType = CSSRule.STYLE_RULE
    (mStyle as! CSSStyleDeclaration)._setParentRule(self)
  }
}
