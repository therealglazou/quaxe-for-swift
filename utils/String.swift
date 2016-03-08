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

extension String
{
    public subscript(integerIndex: Int) -> UnicodeScalar 
    {
        return self.unicodeScalars[self.unicodeScalars.startIndex.advancedBy(integerIndex)]
    }

    public subscript(integerRange: Range<Int>) -> UnicodeScalarView
    {
        let start = self.unicodeScalars.startIndex.advancedBy(integerRange.startIndex)
        let end = self.unicodeScalars.startIndex.advancedBy(integerRange.endIndex)
        return self.unicodeScalars[start..<end]
    }

    public func length() -> Int {
      return self.unicodeScalars.count
    }

    public func substr(from: Int, _ to: Int) -> String {
        let start = self.startIndex.advancedBy(from)
        let end = self.startIndex.advancedBy(from + to)
        return self[start..<end]
    }
}
