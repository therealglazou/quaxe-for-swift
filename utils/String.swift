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

extension String
{
    public subscript(_ integerIndex: Int) -> UnicodeScalar 
    {
        return self.unicodeScalars[self.unicodeScalars.index(self.unicodeScalars.startIndex, offsetBy: integerIndex)]
    }

    public subscript(_ integerRange: Range<Int>) -> UnicodeScalarView
    {
        let start = self.unicodeScalars.index(self.unicodeScalars.startIndex, offsetBy: integerRange.lowerBound)
        let end = self.unicodeScalars.index(self.unicodeScalars.startIndex, offsetBy: integerRange.upperBound)
        return self.unicodeScalars[start..<end]
    }

    public func length() -> Int {
      return self.unicodeScalars.count
    }

    public func substr(_ from: Int, _ to: Int) -> String {
        let start = self.index(self.startIndex, offsetBy: from)
        let end = self.index(self.startIndex, offsetBy: from + to)
        return self[start..<end]
    }
}
