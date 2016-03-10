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

public protocol pStyleSheet {
  var type: DOMString { get }
  var disabled: Bool { get set }
  var ownernode: pNode { get }
  var parentStyleSheet: pStyleSheet { get }
  var href: DOMString { get }
  var title: DOMString { get }
  var media: pMediaList { get }
}
