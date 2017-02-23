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

/**
 * https://dom.spec.whatwg.org/#interface-processinginstruction
 * 
 * status: done
 */
public class ProcessingInstruction: CharacterData, pProcessingInstruction {

  /**
   * https://dom.spec.whatwg.org/#dom-processinginstruction-target
   * 
   * Making 'target' read-only in spec is ridiculous and counter-productive for
   * editing environments; making it read-write here...
   */
  public var target: DOMString = ""

  override init() {}

  init(_ targetStr: DOMString, _ dataStr: DOMString) {
    super.init()
    self.data = dataStr
    self.target = targetStr
  }
}
