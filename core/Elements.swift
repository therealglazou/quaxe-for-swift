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



public class Elements: pElements {
  public func query(relativeSelectors: DOMString) -> pElement? {return nil}
  public func queryAll(relativeSelectors: DOMString) -> pElements {return Elements()}

  init() {}
}
