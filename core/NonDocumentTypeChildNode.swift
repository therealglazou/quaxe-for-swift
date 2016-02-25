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
 * https://dom.spec.whatwg.org/#NonDocumentTypeChildNode
 */
public class NonDocumentTypeChildNode {

  func previousElementSibling(n: Node) -> pElement? {
    var child = n.previousSibling
    while nil != child {
      if child!.nodeType == Node.ELEMENT_NODE {
        return child as? Element
      }
      child = child!.previousSibling
    }
    return nil
  }
  func nextElementSibling(n: Node) -> pElement? {
    var child = n.nextSibling
    while nil != child {
      if child!.nodeType == Node.ELEMENT_NODE {
        return child as? Element
      }
      child = child!.nextSibling
    }
    return nil
  }

  init() {}
}

/*
 * extending Element, CharacterData
 */

extension CharacterData: pNonDocumentTypeChildNode {
  public var previousElementSibling: pElement? {
    if nil == mTearoffs.indexForKey("NonDocumentTypeChildNode") { mTearoffs["NonDocumentTypeChildNode"] = NonDocumentTypeChildNode() }
    return (mTearoffs["NonDocumentTypeChildNode"] as! NonDocumentTypeChildNode).previousElementSibling(self)
  }
  public var nextElementSibling:     pElement? {
    if nil == mTearoffs.indexForKey("NonDocumentTypeChildNode") { mTearoffs["NonDocumentTypeChildNode"] = NonDocumentTypeChildNode() }
    return (mTearoffs["NonDocumentTypeChildNode"] as! NonDocumentTypeChildNode).nextElementSibling(self)
  }
}

extension Element: pNonDocumentTypeChildNode {
  public var previousElementSibling: pElement? {
    if nil == mTearoffs.indexForKey("NonDocumentTypeChildNode") { mTearoffs["NonDocumentTypeChildNode"] = NonDocumentTypeChildNode() }
    return (mTearoffs["NonDocumentTypeChildNode"] as! NonDocumentTypeChildNode).previousElementSibling(self)
  }
  public var nextElementSibling:     pElement? {
    if nil == mTearoffs.indexForKey("NonDocumentTypeChildNode") { mTearoffs["NonDocumentTypeChildNode"] = NonDocumentTypeChildNode() }
    return (mTearoffs["NonDocumentTypeChildNode"] as! NonDocumentTypeChildNode).nextElementSibling(self)
  }
}
