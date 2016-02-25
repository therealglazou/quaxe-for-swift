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
 * https://dom.spec.whatwg.org/#nonelementparentnode
 */
public class NonElementParentNode {

  func getElementById(n: Node, _ elementId: DOMString) -> pElement? { return nil }

  init() {}
}

/*
 * extending Document, DocumentFragment
 */
extension Document: pNonElementParentNode {
  public func getElementById(elementId: DOMString) -> pElement? {
    if nil == mTearoffs.indexForKey("NonElementParentNode") { mTearoffs["NonElementParentNode"] = ChildNode() }
    return (mTearoffs["NonElementParentNode"] as! NonElementParentNode).getElementById(self, elementId)
  }
}

extension DocumentFragment: pNonElementParentNode {
  public func getElementById(elementId: DOMString) -> pElement? {
    if nil == mTearoffs.indexForKey("NonElementParentNode") { mTearoffs["NonElementParentNode"] = ChildNode() }
    return (mTearoffs["NonElementParentNode"] as! NonElementParentNode).getElementById(self, elementId)
  }
}
