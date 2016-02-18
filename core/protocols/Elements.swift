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

protocol Elements {
  func query(relativeSelectors: DOMString) -> Element?
  func queryAll(relativeSelectors: DOMString) -> Elements
}
