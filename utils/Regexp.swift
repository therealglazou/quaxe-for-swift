import Foundation

public class Regex {
  var internalExpression: NSRegularExpression?
  let pattern: String

  public init(_ pattern: String) throws  {
    self.pattern = pattern
    self.internalExpression = nil
    self.internalExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
  }

  public func match(_ input: String) -> Array<String?>? {
    if nil != self.internalExpression {
      let matches = self.internalExpression!.matches(in: input, options: [], range:NSMakeRange(0, input.characters.count))
      var rv: Array<String?> = []
      for index in 0..<matches.count {
        let m = matches[index]
        for rangeIndex in 0..<m.numberOfRanges {
          if m.rangeAt(rangeIndex).location == NSNotFound {
            rv.append(nil)
          }
          else {
            rv.append(input.substr(m.rangeAt(rangeIndex).location, m.rangeAt(rangeIndex).length))
          }
        }
      }
      return rv
    }
    return nil
  }
}
