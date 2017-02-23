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
 * https://dom.spec.whatwg.org/#interface-text
 * 
 * status: TODO 100%
 */
public class Text: CharacterData, pText {
  public func splitText(offset: ulong) -> pText { return Text()}
  public var wholeText: DOMString = ""

  override init() {}

  init(_ str: DOMString) {
    super.init()
    data = str
    mNodeType = Node.TEXT_NODE
  }
}
