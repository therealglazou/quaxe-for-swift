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

public class ProcessingInstruction: CharacterData, pProcessingInstruction {
  public var target: DOMString = ""

  override init() {}

  init(_ targetStr: DOMString, _ dataStr: DOMString) {
    super.init()
    self.data = dataStr
    self.target = targetStr
  }
}
