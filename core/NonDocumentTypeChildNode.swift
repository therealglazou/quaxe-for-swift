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



/*
 * https://dom.spec.whatwg.org/#nondocumenttypechildnode
 */
public class NonDocumentTypeChildNode {

  internal weak var mOwnerNode: Node?
  func setOwnerNode(node: Node) -> Void {
    mOwnerNode = node
  }

  var previousElementSibling: pElement?
  var nextElementSibling:     pElement?

  init() {}
}

/*
 * extending Element, CharacterData
 */

extension CharacterData: pNonDocumentTypeChildNode {
  public var previousElementSibling: pElement? {
    return mNonDocumentTypeChildNodeTearoff.previousElementSibling
  }
  public var nextElementSibling:     pElement? {
    return mNonDocumentTypeChildNodeTearoff.nextElementSibling
  }
}

extension Element: pNonDocumentTypeChildNode {
  public var previousElementSibling: pElement? {
    return mNonDocumentTypeChildNodeTearoff.previousElementSibling
  }
  public var nextElementSibling:     pElement? {
    return mNonDocumentTypeChildNodeTearoff.nextElementSibling
  }
}
