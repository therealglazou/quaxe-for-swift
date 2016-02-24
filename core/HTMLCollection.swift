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



public class HTMLCollection: pHTMLCollection {
  public var length: ulong = 0
  public func item(index: ulong) -> pElement? {return nil}
  public func namedItem(name: DOMString) -> pElement? {return nil}

  init() {}
}
