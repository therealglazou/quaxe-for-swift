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

public class CSSScanner {

  static let CSS_ESCAPE = "\\"

  static let IS_HEX_DIGIT:ushort   = 1
  static let START_IDENT:ushort    = 2
  static let IS_IDENT: ushort      = 4
  static let IS_WHITESPACE: ushort = 8

  static let W    = IS_WHITESPACE
  static let I    = IS_IDENT
  static let S    = START_IDENT
  static let SI   = IS_IDENT | START_IDENT
  static let XI   = IS_IDENT | IS_HEX_DIGIT
  static let XSI  = IS_IDENT | START_IDENT | IS_HEX_DIGIT

  static let kLexTable: Array<ushort> =  [
        //                                     TAB LF      FF  CR
           0,  0,  0,  0,  0,  0,  0,  0,  0,  W,  W,  0,  W,  W,  0,  0,
        //
           0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
        // SPC !   "   #   $   %   &   '   (   )   *   +   ,   -   .   /
           W,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  I,  0,  0,
        // 0   1   2   3   4   5   6   7   8   9   :   ;   <   =   >   ?
           XI, XI, XI, XI, XI, XI, XI, XI, XI, XI, 0,  0,  0,  0,  0,  0,
        // @   A   B   C   D   E   F   G   H   I   J   K   L   M   N   O
           0,  XSI,XSI,XSI,XSI,XSI,XSI,SI, SI, SI, SI, SI, SI, SI, SI, SI,
        // P   Q   R   S   T   U   V   W   X   Y   Z   [   \   ]   ^   _
           SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, 0,  S,  0,  0,  SI,
        // `   a   b   c   d   e   f   g   h   i   j   k   l   m   n   o
           0,  XSI,XSI,XSI,XSI,XSI,XSI,SI, SI, SI, SI, SI, SI, SI, SI, SI,
        // p   q   r   s   t   u   v   w   x   y   z   {   |   }   ~
           SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, 0,  0,  0,  0,  0,
        //
           0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
        //
           0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
        //     ¡   ¢   £   ¤   ¥   ¦   §   ¨   ©   ª   «   ¬   ­   ®   ¯
           0,  SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI,
        // °   ±   ²   ³   ´   µ   ¶   ·   ¸   ¹   º   »   ¼   ½   ¾   ¿
           SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI,
        // À   Á   Â   Ã   Ä   Å   Æ   Ç   È   É   Ê   Ë   Ì   Í   Î   Ï
           SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI,
        // Ð   Ñ   Ò   Ó   Ô   Õ   Ö   ×   Ø   Ù   Ú   Û   Ü   Ý   Þ   ß
           SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI,
        // à   á   â   ã   ä   å   æ   ç   è   é   ê   ë   ì   í   î   ï
           SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI,
        // ð   ñ   ò   ó   ô   õ   ö   ÷   ø   ù   ú   û   ü   ý   þ   ÿ
           SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI, SI
    ]

    static let kHexValues: Dictionary<String, UInt> = [
        "0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9,
        "a": 10, "b": 11, "c": 12, "d": 13, "e": 14, "f": 15
    ]

    internal var mString: DOMString = ""
    internal var mPos: UInt = 0
    internal var mPreservedPos: Array<UInt> = []

    /***** PUBLIC *****/

    init(_ aString: DOMString) {
      mString = aString
      mPos = 0;
      mPreservedPos = []
    }

    public func preserveState() -> Void {
      mPreservedPos.append(mPos)
    }

    public func restoreState() -> Void {
      if (0 < mPreservedPos.count) {
        mPos = mPreservedPos.removeLast()
      }
    }

    public func forgetState() -> Void {
      if (0 < mPreservedPos.count) {
        mPreservedPos.removeLast()
      }
    }

   /* public func nextHexValue() ->*/ 

    /***** PRIVATE *****/

    internal func getCurrentPos() -> UInt {
      return mPos
    }

    internal func getAlreadyScanned() -> DOMString {
      return mString.substr(0, Int(mPos))
    }

    internal func read() -> DOMString {
      if Int(mPos) < self.mString.characters.count {
        mPos += 1
        return String(self.mString[self.mString.index(self.mString.startIndex, offsetBy: Int(mPos - 1))])
      }
      return ""
    }

    internal func peek() -> DOMString {
      if Int(mPos) < self.mString.unicodeScalars.count {
        return String(self.mString[self.mString.index(self.mString.startIndex, offsetBy: Int(mPos))])
      }
      return ""
    }

    internal func isHexDigit(_ c: DOMString) -> Bool {
      let utf8 = c.utf8
      let firstUtf8AsInt = Int(utf8[utf8.startIndex])
      return firstUtf8AsInt < 256 &&
             (CSSScanner.kLexTable[firstUtf8AsInt] & CSSScanner.IS_HEX_DIGIT) != 0
    }

    internal func isIdentStart(_ c: DOMString) -> Bool {
      let utf8 = c.utf8
      let firstUtf8AsInt = Int(utf8[utf8.startIndex])
      return firstUtf8AsInt >= 256 ||
             (CSSScanner.kLexTable[firstUtf8AsInt] & CSSScanner.START_IDENT) != 0
    }

    internal func startsWithIdent(_ aFirstChar : String, _ aSecondChar : String) -> Bool {
      return isIdentStart(aFirstChar) ||
             (aFirstChar == "-" && isIdentStart(aSecondChar))
    }

    internal func isIdent(_ c: DOMString) -> Bool {
      let utf8 = c.utf8
      let firstUtf8AsInt = Int(utf8[utf8.startIndex])
      return firstUtf8AsInt >= 256 || (CSSScanner.kLexTable[firstUtf8AsInt] & CSSScanner.IS_IDENT != 0)
    }

    internal func pushback() -> Void {
      mPos = mPos - 1;
    }
};
