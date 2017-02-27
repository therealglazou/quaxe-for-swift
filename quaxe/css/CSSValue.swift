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
 * http://www.glazman.org/weblog/dotclear/index.php?post/2014/03/19/A-better-CSS-OM-for-parsed-values
 */
public class CSSValue: pCSSValue {

  static let CSS_SYMBOL: ushort      = 0;
  static let CSS_NUMBER: ushort      = 1;
  static let CSS_UNIT: ushort        = 2;
  static let CSS_STRING: ushort      = 3;
  static let CSS_URI: ushort         = 4;
  static let CSS_IDENT: ushort       = 5;
  static let CSS_VALUE_LIST: ushort  = 6;

  internal var mType: ushort = CSS_SYMBOL
  internal var mCommaSeparated: Bool
  internal var mValues: Array<CSSValue>

  internal var mFloatValue: Double = 0
  internal var mStringValue: DOMString = ""

  public var type: ushort { return mType }
  public var commaSeparated: Bool {
    get  {
      return mCommaSeparated
    }
    set {
      mCommaSeparated = newValue
    }
  }
  public var length: ulong {
    return ulong(mValues.count)
  }

  public func item(_ index: ulong) throws -> pCSSValue? {
    if CSSValue.CSS_VALUE_LIST != type {
      throw Exception.InvalidAccessError
    }
    if index >= length {
      return nil
    }
    return mValues[Int(index)]
  }

  public func setFloatValue(_ floatValue: Double) throws -> Void {
    if CSSValue.CSS_NUMBER != type &&
       CSSValue.CSS_UNIT != type {
      throw Exception.InvalidAccessError
    }

    mFloatValue = floatValue
  }

  public func getFloatValue() throws -> Double {
    if CSSValue.CSS_NUMBER != type &&
       CSSValue.CSS_UNIT != type {
      throw Exception.InvalidAccessError
    }

    return mFloatValue
  }

  public func setStringValue(_ stringValue: DOMString) throws -> Void {

    if CSSValue.CSS_NUMBER == type ||
       CSSValue.CSS_UNIT == type {
      throw Exception.InvalidAccessError
    }

    mStringValue = stringValue
  }

  public func getStringValue() throws -> DOMString {
    if CSSValue.CSS_NUMBER == type ||
       CSSValue.CSS_UNIT == type {
      throw Exception.InvalidAccessError
    }

    return mStringValue
  }

  public var cssText: DOMString {
    var s = "";
    switch type {
      case CSSValue.CSS_SYMBOL, CSSValue.CSS_IDENT:
        s = mStringValue
      case CSSValue.CSS_STRING:
        s = "\"" + mStringValue + "\""
      case CSSValue.CSS_URI:
        s = "url(" + mStringValue + ")"
      case CSSValue.CSS_NUMBER:
        s = String(mFloatValue)
      case CSSValue.CSS_UNIT:
        s = String(mFloatValue) + mStringValue
      case CSSValue.CSS_VALUE_LIST:
        if "" != mStringValue {
          s += mStringValue + "("
        }
        for v in mValues {
          if "" != s {
            if commaSeparated {
              s += ","
            }
            s += " "
          }
          s += v.cssText
        }
        if "" != mStringValue {
          s += ")"
        }
      default: break
    }
    return s
  }

  public func set(_ type: ushort, _ floatValue: Double, _ stringValue: DOMString, _ commaSeparated: Bool) -> Void {
    mType = type
    mFloatValue = floatValue
    mStringValue = stringValue
    mCommaSeparated = commaSeparated
    mValues = []
  }

  public func appendValueToValueList(_ value: CSSValue) throws -> Void {
    if CSSValue.CSS_VALUE_LIST != type {
      throw Exception.InvalidAccessError
    }

    mValues.append(value)
  }

  init() {
    mCommaSeparated = false
    mValues = []
  }
}
