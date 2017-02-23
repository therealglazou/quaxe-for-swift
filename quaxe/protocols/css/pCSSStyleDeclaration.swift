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

public protocol pCSSStyleDeclaration {
  var cssText: DOMString { get set }

  func getPropertyValue(propertyName: DOMString) -> DOMString
  func getPropertyCSSValue(propertyName: DOMString) -> pCSSValue
  func removeProperty(propertyName: DOMString) throws -> DOMString
  func getPropertyPriority(propertyName: DOMString) -> DOMString
  func setProperty(propertyName: DOMString, _ value: DOMString, _ priority: DOMString) throws -> Void

  var length: ulong { get }
  func item(index: ulong) -> DOMString
  var parentRule: pCSSRule { get }
}
