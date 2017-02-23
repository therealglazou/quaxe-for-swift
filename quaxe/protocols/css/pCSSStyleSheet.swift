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

public protocol pCSSStyleSheet {
  var ownerRule: pCSSRule? { get }
  var cssRules: pCSSRuleList { get }
  func insertRule(rule: DOMString, _ index: ulong) throws -> ulong
  func deleteRule(index: ulong) throws -> Void
}
