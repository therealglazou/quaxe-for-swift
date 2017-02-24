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

public protocol pText: pCharacterData {
  func splitText(_ offset: ulong) -> pText
  var wholeText: DOMString { get }
}
