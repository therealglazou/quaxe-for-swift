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
 * https://www.w3.org/TR/DOM-Level-2-Style/stylesheets.html#StyleSheets-StyleSheet
 */
public class StyleSheet: pStyleSheet {

  internal var mDisabled: Bool = false
  internal var mOwnerNode: pNode? = nil
  internal var mParentStyleSheet: pStyleSheet? = nil
  internal var mHref: DOMString? = nil
  internal var mTitle: DOMString = ""
  internal var mMedia: pMediaList

  public var type: DOMString { return "text/css" }

  public var disabled: Bool {
    get {
      return mDisabled
    }

    set {
      mDisabled = newValue
    }
  }

  public var ownerNode: pNode? { return mOwnerNode }

  public var parentStyleSheet: pStyleSheet? { return mParentStyleSheet }

  public var href: DOMString? { return mHref }

  public var title: DOMString { return mTitle }

  public var media: pMediaList { return mMedia }

  init() {
    mMedia = MediaList()
  }
};