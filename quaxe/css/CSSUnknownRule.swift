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
 * https://www.w3.org/TR/DOM-Level-2-Style/css.html#CSS-CSSUnknownRule
 */
public class CSSUnknownRule: CSSRule, pCSSUnknownRule {

  override init(_ parentStyleSheet: pCSSStyleSheet, _ parentRule: pCSSRule?) {
    super.init(parentStyleSheet, parentRule)
    mType = CSSRule.UNKNOWN_RULE
  }

}
