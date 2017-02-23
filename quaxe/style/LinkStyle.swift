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

import QuaxeUtils

/**
 * https://www.w3.org/TR/DOM-Level-2-Style/stylesheets.html#StyleSheets-LinkStyle
 */
public class LinkStyle: pLinkStyle {
  internal var mSheet: pStyleSheet? = nil

  public var sheet: pStyleSheet? { return mSheet }

  init() {}
};
