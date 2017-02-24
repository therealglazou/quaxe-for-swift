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
 * https://dom.spec.whatwg.org/#ordered%20sets
 * 
 * status: done, optimize with Foundation?
 */
internal class OrderedSets {

  static func parse(_ str: String) -> Set<String> {
    var index = str.startIndex
    var token = ""
    var set: Set<String> = []

    while index != str.endIndex {
      let c = str[index]
      switch c {
        case "\u{09}",
             "\u{0A}",
             "\u{0C}",
             "\u{0D}",
             "\u{20}":
          if !token.isEmpty {
            if !set.contains(token) {
              set.insert(token)
            }
            token = "" 
          }
        default: token.append(c)
      }
      index = str.index(after: index)
    }

    return set
  }

  static func serialize(_ set: Set<String>) -> String {
    var rv = ""
    for token in set {
      if !rv.isEmpty {
        rv += " "
      }
      rv += token
    }
    return rv
  }
}
