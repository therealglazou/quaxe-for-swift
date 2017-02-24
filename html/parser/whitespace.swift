struct Characters {
  static let SPACE_CHARACTERS: [Character]
      = ["\u{0020}", "\u{0009}", "\u{000A}", "\u{000C}","\u{000D}" ]

  static func isSpaceCharacter(c: Character) -> Bool {
      return self.SPACE_CHARACTERS.contains(c);
  }
}
