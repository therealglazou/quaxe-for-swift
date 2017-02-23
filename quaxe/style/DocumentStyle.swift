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
 * https://www.w3.org/TR/DOM-Level-2-Style/stylesheets.html#StyleSheets-StyleSheet-DocumentStyle
 */
public class DocumentStyle: pDocumentStyle {
  internal var mStyleSheets: pStyleSheetList

  public var styleSheets: pStyleSheetList { return mStyleSheets }

  init() {
    mStyleSheets = StyleSheetList()
  }
};
