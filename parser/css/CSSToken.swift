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

import Quaxe

public class CSSToken {

  static let NULL_TYPE: ushort             = 0;

  static let WHITESPACE_TYPE: ushort       = 1;
  static let STRING_TYPE: ushort           = 2;
  static let COMMENT_TYPE: ushort          = 3;
  static let NUMBER_TYPE: ushort           = 4;
  static let IDENT_TYPE: ushort            = 5;
  static let FUNCTION_TYPE: ushort         = 6;
  static let ATRULE_TYPE: ushort           = 7;
  static let INCLUDES_TYPE: ushort         = 8;
  static let DASHMATCH_TYPE: ushort        = 9;
  static let BEGINSMATCH_TYPE: ushort      = 10;
  static let ENDSMATCH_TYPE: ushort        = 11;
  static let CONTAINSMATCH_TYPE: ushort    = 12;
  static let SYMBOL_TYPE: ushort           = 13;
  static let DIMENSION_TYPE: ushort        = 14;
  static let PERCENTAGE_TYPE: ushort       = 15;
  static let HEX_TYPE: ushort              = 16;

  public var type: ushort
  public var doubleValue: Double
  public var stringValue : DOMString

  internal func isOfType(_ aType: ushort, _ aStringValue: DOMString = "") -> Bool {
    return type == aType && ("" == aStringValue || stringValue.lowercased() == aStringValue.lowercased())
  }

  public func isNotNull() -> Bool {
    return !isOfType(CSSToken.NULL_TYPE)
  }

  public func isWhitespace(_ aStringValue: DOMString = "") -> Bool {
    return isOfType(CSSToken.WHITESPACE_TYPE, aStringValue)
  }

  public func isString() -> Bool {
    return isOfType(CSSToken.STRING_TYPE)
  }

  public func isComment() -> Bool {
    return isOfType(CSSToken.COMMENT_TYPE)
  }

  public func isNumber() -> Bool {
    return isOfType(CSSToken.NUMBER_TYPE)
  }

  public func isZero() -> Bool {
    return isOfType(CSSToken.NUMBER_TYPE, "0")
  }

  public func isIdent(_ aIdent: DOMString = "") -> Bool {
    return isOfType(CSSToken.IDENT_TYPE, aIdent)
  }

  public func isFunction(_ aFunction: DOMString = "") -> Bool {
    return isOfType(CSSToken.FUNCTION_TYPE, aFunction)
  }

  public func isAtRule(_ aAtRule: DOMString = "") -> Bool {
    return isOfType(CSSToken.ATRULE_TYPE, aAtRule)
  }

  public func isIncludes() -> Bool {
    return isOfType(CSSToken.INCLUDES_TYPE)
  }

  public func isDashmatch() -> Bool {
    return isOfType(CSSToken.DASHMATCH_TYPE)
  }

  public func isBeginsmatch() -> Bool {
    return isOfType(CSSToken.BEGINSMATCH_TYPE)
  }

  public func isEndsmatch() -> Bool {
    return isOfType(CSSToken.ENDSMATCH_TYPE)
  }

  public func isContainsMatch() -> Bool {
    return isOfType(CSSToken.CONTAINSMATCH_TYPE)
  }

  public func isSymbol(_ aSymbol: DOMString = "") -> Bool {
    return isOfType(CSSToken.SYMBOL_TYPE, aSymbol)
  }

  public func isDimension() -> Bool {
    return isOfType(CSSToken.DIMENSION_TYPE)
  }

  public func isPercentage() -> Bool {
    return isOfType(CSSToken.PERCENTAGE_TYPE)
  }

  public func isHex() -> Bool {
    return isOfType(CSSToken.HEX_TYPE)
  }

  public func isDimensionOfUnit(_ aUnit: DOMString) -> Bool {
    return isDimension() && stringValue.lowercased() == aUnit.lowercased()
  }

  public func isLength() -> Bool {
    return isPercentage() ||
           isDimensionOfUnit("cm") ||
           isDimensionOfUnit("mm") ||
           isDimensionOfUnit("in") ||
           isDimensionOfUnit("pc") ||
           isDimensionOfUnit("px") ||
           isDimensionOfUnit("em") ||
           isDimensionOfUnit("ex") ||
           isDimensionOfUnit("pt")
  }

  public func isAngle() -> Bool {
    return isDimensionOfUnit("deg") ||
           isDimensionOfUnit("rad") ||
           isDimensionOfUnit("grad")
  }

  init(aType: ushort, aValue: Double, aString: DOMString) {
    type = aType
    doubleValue = aValue
    stringValue = aString
  }
};
