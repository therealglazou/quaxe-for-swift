/**
 * Quaxe for Swift
 * 
 * Copyright 2016 Disruptive Innovations
 * 
 * Original author:
 *   Daniel Glazman <daniel.glazman@disruptive-innovations.com>
 *
 * Contributors:
 * 
 */

public protocol pCSSMediaRule {
  var media: pMediaList { get }
  var cssRules: pCSSRuleList { get }
  func insertRule(rule: DOMString, _ index: ulong) throws -> ulong
  func deleteRule(index: ulong) throws -> Void
}
