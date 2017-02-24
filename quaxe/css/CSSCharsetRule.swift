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
 * https://www.w3.org/TR/DOM-Level-2-Style/css.html#CSS-CSSCharsetRule
 */
public class CSSCharsetRule: CSSRule, pCSSCharsetRule {

  internal var mEncoding: DOMString

  public var encoding: DOMString {
    get {
      return mEncoding
    }
    set {
      mEncoding = newValue
    }
  }

  override init(_ parentStyleSheet: pCSSStyleSheet, _ parentRule: pCSSRule?) {
    mEncoding = "utf-8"
    super.init(parentStyleSheet, parentRule)
    mType = CSSRule.CHARSET_RULE
  }

}
