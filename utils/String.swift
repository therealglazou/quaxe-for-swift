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
    subscript(integerIndex: Int) -> Character
    {
        return self[self.startIndex.advancedBy(integerIndex)]
    }

    subscript(integerRange: Range<Int>) -> String
    {
        let start = self.startIndex.advancedBy(integerRange.startIndex)
        let end = self.startIndex.advancedBy(integerRange.endIndex)
        return self[start..<end]
    }

    public func length() -> Int {
      return self.characters.count
    }
}
