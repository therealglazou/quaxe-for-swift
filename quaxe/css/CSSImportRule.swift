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
 * https://www.w3.org/TR/DOM-Level-2-Style/css.html#CSS-CSSImportRule
 */
public class CSSImportRule: CSSRule, pCSSImportRule {
  internal var mHref: DOMString = ""
  internal var mMedia: pMediaList
  internal var mStyleSheet: pCSSStyleSheet?

  public var href: DOMString { return mHref }
  public var media: pMediaList { return mMedia }
  public var styleSheet: pCSSStyleSheet? { return mStyleSheet }

  override init(_ parentStyleSheet: pCSSStyleSheet, _ parentRule: pCSSRule?) {
    mHref = ""
    mMedia = MediaList()
    mStyleSheet = nil
    super.init(parentStyleSheet, parentRule)
    mType = CSSRule.IMPORT_RULE
  }
}
