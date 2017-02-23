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
 * https://www.w3.org/TR/DOM-Level-2-Style/stylesheets.html#StyleSheets-StyleSheetList
 */
public class StyleSheetList: pStyleSheetList {

  internal var mStyleSheetList: Array<StyleSheet> = []

  public var length: ulong {
    return ulong(self.mStyleSheetList.count)
  }

  public func item(index: ulong) -> pStyleSheet? {
    if index >= self.length {
      return nil
    }
    return self.mStyleSheetList[self.mStyleSheetList.startIndex.advancedBy(Int(index))]
  }

  init() {}
};
