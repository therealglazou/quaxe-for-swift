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

public class ProcessingInstruction: CharacterData, pProcessingInstruction {
  public var target: DOMString = ""

  override init() {}
}
