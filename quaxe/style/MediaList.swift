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
 * https://www.w3.org/TR/DOM-Level-2-Style/stylesheets.html#StyleSheets-MediaList
 */
public class MediaList: pMediaList {

  internal var mMediaList: Set<String> = []

  public var length: ulong {
    return ulong(self.mMediaList.count)
  }

  public func item(index: ulong) -> DOMString? {
    if index >= self.length {
      return nil
    }
    return self.mMediaList[self.mMediaList.startIndex.advancedBy(Int(index))]
  }

  public var mediaText: DOMString { return OrderedSets.serialize(mMediaList) }

  public func deleteMedium(oldMedium: DOMString) throws -> Void {
    var found: Bool = false
    for token in mMediaList {
      if token.isEmpty {
        throw Exception.SyntaxError
      }
      if self.mMediaList.contains(token) {
        self.mMediaList.remove(token)
        found = true
      }
    }

    if !found {
      throw Exception.NotFoundError
    }
  }

  public func appendMedium(newMedium: DOMString) throws -> Void {
    try deleteMedium(newMedium)

    mMediaList.insert(newMedium)
  }

  init() {}
};
