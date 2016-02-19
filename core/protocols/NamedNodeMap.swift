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

public protocol pNamedNodeMap {
  var length: ulong { get }
  func item(index: ulong) -> pAttr?
  func getNamedItem(qualifiedName: DOMString) -> pAttr?
  func getNamedItemNS(namespace: DOMString?, _ localName: DOMString) -> pAttr?
  func setNamedItem(attr: pAttr) -> pAttr?
  func setNamedItemNS(attr: pAttr) -> pAttr?
  func removeNamedItem(qualifiedName: DOMString) -> pAttr
  func removeNamedItem(namespace: DOMString?, _ localName: DOMString) -> pAttr
}
