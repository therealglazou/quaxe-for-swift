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

  /**
   * https://dom.spec.whatwg.org/#dom-nonelementparentnode-getelementbyid
   */
  static func _getElementById(child: Node?, _ elementId: DOMString) -> pElement? {
    var n = child
    while nil != n {
      if Node.ELEMENT_NODE == n!.nodeType &&
         elementId == (n as! Element).getAttribute("id") {
        return n as! Element
      }
      let rv = _getElementById(n!.firstChild as? Node, elementId)
      if nil != rv {
        return rv
      }
      n = n!.nextSibling as? Node
    }
    return nil
  }

  static func getElementById(n: Node, _ elementId: DOMString) -> pElement? {
    if Node.ELEMENT_NODE == n.nodeType &&
       elementId == (n as! Element).getAttribute("id") {
      return n as! Element
    }
    return _getElementById(n.firstChild as? Node, elementId)
  }
}

/*
 * extending Document, DocumentFragment
 */
extension Document: pNonElementParentNode {
  public func getElementById(elementId: DOMString) -> pElement? {
    return NonElementParentNode.getElementById(self, elementId)
  }
}

extension DocumentFragment: pNonElementParentNode {
  public func getElementById(elementId: DOMString) -> pElement? {
    return NonElementParentNode.getElementById(self, elementId)
  }
}
