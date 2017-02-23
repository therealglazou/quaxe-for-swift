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
 * https://www.w3.org/TR/DOM-Level-2-Style/css.html#CSS-CSSRule
 */
public class CSSRule: pCSSRule {

  static let UNKNOWN_RULE: ushort                      = 0;
  static let STYLE_RULE: ushort                        = 1;
  static let CHARSET_RULE: ushort                      = 2;
  static let IMPORT_RULE: ushort                       = 3;
  static let MEDIA_RULE: ushort                        = 4;
  static let FONT_FACE_RULE: ushort                    = 5;
  static let PAGE_RULE: ushort                         = 6;

  internal var mType: ushort = UNKNOWN_RULE;
  internal var mParentStyleSheet: pCSSStyleSheet
  internal var mParentStyleRule: pCSSRule? = nil

  public var type: ushort { return mType }

  // XXXXXX
  public var cssText: DOMString {
    get {
      return ""
    }

    set {
      
    }
  }

  public var parentStyleSheet: pCSSStyleSheet { return mParentStyleSheet }
  public var parentRule: pCSSRule? { return mParentStyleRule }

  init(_ parentStyleSheet: pCSSStyleSheet, _ parentRule: pCSSRule?) {
    mParentStyleSheet = parentStyleSheet;
    mParentStyleRule = parentRule;
  }
}
