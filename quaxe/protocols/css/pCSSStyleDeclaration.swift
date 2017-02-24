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

  func getPropertyValue(_ propertyName: DOMString) -> DOMString
  // func getPropertyCSSValue(propertyName: DOMString) -> pCSSValue
  func removeProperty(_ propertyName: DOMString) throws -> DOMString
  func getPropertyPriority(_ propertyName: DOMString) -> DOMString
  func setProperty(_ propertyName: DOMString, _ value: DOMString, _ priority: DOMString) throws -> Void

  var length: ulong { get }
  func item(_ index: ulong) -> DOMString
  var parentRule: pCSSRule { get }
}
