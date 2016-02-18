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

protocol NamedNodeMap {
  var length: ulong { get }
  func item(index: ulong) -> Attr?
  func getNamedItem(qualifiedName: DOMString) -> Attr?
  func getNamedItemNS(namespace: DOMString?, _ localName: DOMString) -> Attr?
  func setNamedItem(attr: Attr) -> Attr?
  func setNamedItemNS(attr: Attr) -> Attr?
  func removeNamedItem(qualifiedName: DOMString) -> Attr
  func removeNamedItem(namespace: DOMString?, _ localName: DOMString) -> Attr
}
