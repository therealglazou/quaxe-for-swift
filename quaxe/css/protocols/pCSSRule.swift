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

public protocol pCSSRule {
  var type: ushort { get }
  var cssText: DOMString { get set }

  var parentStyleSheet: pCSSStyleSheet { get }
  var parentRule: pCSSRule { get }
}
