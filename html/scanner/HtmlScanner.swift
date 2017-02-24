import Foundation

class HtmlScanner {
  let mString: String
  var mPos: String.Index
  var mPreservedPos: [String.Index] = []
  var mLine: UInt

  let kDIGITS       = "0123456789"
  let kHEX_DIGITS   = "0123456789abcdef"
  let kALPHA_ASCII  = "0123456789abcdefghijklmnopqrstuvwxyz"
  let kWHITESPACES  = "\u{0009}\u{000A}\u{000C}\u{0000D}\u{0020}"

  let range = 1...5

  let mEndIndex: String.Index

  func preserveState() {
    mPreservedPos.append(mPos)
  }

  func restoreState() {
    if !mPreservedPos.isEmpty {
      mPos = mPreservedPos.removeLast()
    }
  }

  func forgetState() {
    if !mPreservedPos.isEmpty {
      mPreservedPos.removeLast()
    }
  }

  func read() -> Character? {
    if mPos < mEndIndex {
      mPos = mPos.successor()
      if mString[mPos] == "\u{000d}" {
        mLine++
      }
      return mString[mPos]
    }
    return nil
  }

  func peek() -> Character? {
    if mPos < mEndIndex {
      let pos = mPos.successor()
      return mString[pos]
    }
    return nil
  }

  func pushBack() {
    if mPos > mString.startIndex {
      mPos = mPos.predecessor()
    }
  }

  func isDigit(c: Character) -> Bool {
    return nil != kDIGITS.rangeOfString(String(c).lowercaseString)
  }

  func isHexDigit(c: Character) -> Bool {
    return nil != kHEX_DIGITS.rangeOfString(String(c).lowercaseString)
  }

  func isElementNameStart(c: Character) -> Bool {
    return nil != kALPHA_ASCII.rangeOfString(String(c).lowercaseString)
  }

  func kWHITESPACES(c: Character) -> Bool {
    return nil != kALPHA_ASCII.rangeOfString(String(c).lowercaseString)
  }

  init(aStr: String) {
    mString = aStr
    mPos = mString.startIndex
    mPreservedPos = []
    mLine = 1

    mEndIndex = mString.endIndex
  }
}
