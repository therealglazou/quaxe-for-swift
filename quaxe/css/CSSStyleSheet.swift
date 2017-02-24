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

public class CSSStyleSheet: pCSSStyleSheet {

  internal var mOwnerRule: pCSSRule? = nil
  internal var mCSSRuleList: pCSSRuleList
  
  public var ownerRule: pCSSRule? { return mOwnerRule }

  public var cssRules: pCSSRuleList { return mCSSRuleList }

  // XXXX
  public func insertRule(_ rule: DOMString, _ index: ulong) throws -> ulong {return 0}
  // XXXX
  public func deleteRule(_ index: ulong) throws -> Void {}

  init() {
    mOwnerRule = nil
    mCSSRuleList = CSSRuleList()
  }
}
