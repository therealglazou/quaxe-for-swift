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

import QuaxeCoreProtocols

/*
 * https://dom.spec.whatwg.org/#ordered%20sets
 */
internal class OrderedSets {

  static func parse(str: String) -> Set<String> {
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
      index = index.successor()
    }

    return set
  }

  static func serialize(set: Set<String>) -> String {
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
