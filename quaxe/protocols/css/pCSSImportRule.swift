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

public protocol pCSSImportRule {
  var href: DOMString { get }
  var media: pMediaList { get }
  var styleSheet: pCSSStyleSheet { get }
}
