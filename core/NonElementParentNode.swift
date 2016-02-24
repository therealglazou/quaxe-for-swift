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

  internal weak var mOwnerNode: Node?
  func setOwnerNode(node: Node) -> Void {
    mOwnerNode = node
  }

  func getElementById(elementId: DOMString) -> pElement? { return nil }

  init() {}
}

/*
 * extending Document, DocumentFragment
 */
extension Document: pNonElementParentNode {
  public func getElementById(elementId: DOMString) -> pElement? {
    return mNonElementParentNodeTearoff.getElementById(elementId)
  }
}

extension DocumentFragment: pNonElementParentNode {
  public func getElementById(elementId: DOMString) -> pElement? {
    return mNonElementParentNodeTearoff.getElementById(elementId)
  }
}
