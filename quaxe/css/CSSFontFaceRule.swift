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
 * https://www.w3.org/TR/DOM-Level-2-Style/css.html#CSS-CSSFontFaceRule
 */
public class CSSFontFaceRule: CSSRule, pCSSFontFaceRule {

  internal var mStyle: pCSSStyleDeclaration

  public var style: pCSSStyleDeclaration { return mStyle }

  override init(_ parentStyleSheet: pCSSStyleSheet, _ parentRule: pCSSRule?) {
    mStyle = CSSStyleDeclaration()
    super.init(parentStyleSheet, parentRule)
    mType = CSSRule.FONT_FACE_RULE
    (mStyle as! CSSStyleDeclaration)._setParentRule(self)
  }
}
