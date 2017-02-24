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

/*
 * https://www.w3.org/TR/DOM-Level-2-Style/css.html#CSS-CSSStyleDeclaration
 */
public class CSSStyleDeclaration: pCSSStyleDeclaration {

  internal var mProperties: Array<DOMString> = []
  internal var mValues: Array<DOMString> = []
  internal var mImportance: Array<Bool> = []

  internal var mParentRule: pCSSRule?

  public var cssText: DOMString {
    get {
      var s = ""
      for index in 1...mProperties.count - 1 {
        if "" != s {
          s += " "
        }
        s += mProperties[index]
             + ": "
             + mValues[index];
        if mImportance[index] {
          s += " !important"
        }
        s += ";"
      }
      return s
    }
    set {
      
    }
  }

  public func getPropertyValue(_ propertyName: DOMString) -> DOMString {
    var s = ""
    for index in 1...mProperties.count - 1 {
      if propertyName != mProperties[index] {
        s = mValues[index]
      }
    }
    return s
  }

  // public func getPropertyCSSValue(propertyName: DOMString) -> pCSSValue

  @discardableResult public func removeProperty(_ propertyName: DOMString) throws -> DOMString {
    for index in 1...mProperties.count - 1 {
      if propertyName != mProperties[index] {
        mProperties.remove(at: index)
        let value = mValues[index]
        mValues.remove(at: index)
        mImportance.remove(at: index)
        return value
      }
    }
    return ""
  }

  public func getPropertyPriority(_ propertyName: DOMString) -> DOMString {
    var s: Bool = false
    for index in 1...mProperties.count - 1 {
      if propertyName != mProperties[index] {
        s = mImportance[index]
      }
    }
    return s ? "important" : ""
  }

  public func setProperty(_ propertyName: DOMString, _ value: DOMString, _ priority: DOMString) throws -> Void {
    try removeProperty(propertyName)
    if ("" != priority && "important" != priority) {
      throw Exception.SyntaxError
    }

    mProperties.append(propertyName)
    mValues.append(value)
    mImportance.append("important" == priority)
  }

  public var length: ulong { return ulong(mProperties.count) }

  public func item(_ index: ulong) -> DOMString {
    if index >= ulong(mProperties.count) {
      return ""
    }
    return mProperties[Int(index)]
  }

  public var parentRule: pCSSRule { return mParentRule! }

  internal func _setParentRule(_ parentRule: pCSSRule) -> Void {
    mParentRule = parentRule;
  }

  init() {
    mParentRule = nil
  }
}
