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

public class NamedNodeMap: pNamedNodeMap {
  public var length: ulong = 0
  public func item(index: ulong) -> pAttr? {return nil}
  public func getNamedItem(qualifiedName: DOMString) -> pAttr? {return nil}
  public func getNamedItemNS(namespace: DOMString?, _ localName: DOMString) -> pAttr? {return nil}
  public func setNamedItem(attr: pAttr) -> pAttr? {return nil}
  public func setNamedItemNS(attr: pAttr) -> pAttr? {return nil}
  public func removeNamedItem(qualifiedName: DOMString) -> pAttr {return Attr()}
  public func removeNamedItem(namespace: DOMString?, _ localName: DOMString) -> pAttr {return Attr()}

  init() {}
}
