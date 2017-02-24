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

public protocol pNamedNodeMap {
  var length: ulong { get }
  func item(_ index: ulong) -> pAttr?
  func getNamedItem(_ qualifiedName: DOMString) -> pAttr?
  func getNamedItemNS(_ namespace: DOMString?, _ localName: DOMString) -> pAttr?
  func setNamedItem(_ attr: pAttr) -> pAttr?
  func setNamedItemNS(_ attr: pAttr) -> pAttr?
  func removeNamedItem(_ qualifiedName: DOMString) -> pAttr
  func removeNamedItem(_ namespace: DOMString?, _ localName: DOMString) -> pAttr
}
