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

/**
 * https://dom.spec.whatwg.org/#element-collections
 * 
 * status: TODO 100%
 */
public class Elements: pElements {
  public func query(_ relativeSelectors: DOMString) -> pElement? {
    // TODO
    return nil
  }

  public func queryAll(_ relativeSelectors: DOMString) -> pElements {
    // TODO
    return Elements()
  }

  init() {}
}
