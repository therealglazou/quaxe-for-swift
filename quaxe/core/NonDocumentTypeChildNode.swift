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
 * https://dom.spec.whatwg.org/#NonDocumentTypeChildNode
 * 
 * status: done
 */
public class NonDocumentTypeChildNode {

  /**
   * https://dom.spec.whatwg.org/#dom-nondocumenttypechildnode-previouselementsibling
   */
  static func previousElementSibling(n: Node) -> pElement? {
    var child = n.previousSibling
    while nil != child {
      if child!.nodeType == Node.ELEMENT_NODE {
        return child as? Element
      }
      child = child!.previousSibling
    }
    return nil
  }

  /**
   * https://dom.spec.whatwg.org/#dom-nondocumenttypechildnode-nextelementsibling
   */
  static func nextElementSibling(n: Node) -> pElement? {
    var child = n.nextSibling
    while nil != child {
      if child!.nodeType == Node.ELEMENT_NODE {
        return child as? Element
      }
      child = child!.nextSibling
    }
    return nil
  }

}

/*
 * extending Element, CharacterData
 */

extension CharacterData: pNonDocumentTypeChildNode {
  public var previousElementSibling: pElement? {
    return NonDocumentTypeChildNode.previousElementSibling(self)
  }
  public var nextElementSibling:     pElement? {
    return NonDocumentTypeChildNode.nextElementSibling(self)
  }
}

extension Element: pNonDocumentTypeChildNode {
  public var previousElementSibling: pElement? {
    return NonDocumentTypeChildNode.previousElementSibling(self)
  }
  public var nextElementSibling:     pElement? {
    return NonDocumentTypeChildNode.nextElementSibling(self)
  }
}
