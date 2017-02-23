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
 * https://dom.spec.whatwg.org/#interface-comment
 * 
 * status: done
 */
public class Comment: CharacterData, pComment {
  override init() {}

  init(_ str: DOMString) {
    super.init()
    data = str
    mNodeType = Node.COMMENT_NODE
  }

}
