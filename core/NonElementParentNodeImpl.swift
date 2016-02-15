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

class NonElementParentNodImpl {
  static func getElementById(refNode: Node, elementID: String) -> Element?
  {
    var node: Node = refNode;
    while true {
      switch node.nodeType {
        case Node.ELEMENT_NODE:
          var elt = node as! Element
          if elt.hasAttribute("id") && elt.getAttribute("id") == elementID {
            return elt;
          }
      }
  
      if nil != node.firstChild {
        node = node.firstChild;
      }
      else if nil != node.nextSibling {
        node = node.nextSibling;
      }
      else if nil == node.parentNode {
        break;
      }
      else {
        while nil == node.nextSibling
              && nil != node.parentNode
              && node.parentNode!.nodeType == Node.ELEMENT_NODE {
          node = node.parentNode!;
        }
        if nil == node.nextSibling {
          break;
        node = node.nextSibling!;
        }
      }
    }
    return nil;
  }

  init() {}
}

extension Document: NonElementParentNode {
  func getElementById(elementId: String) -> Element? {
    return NonElementParentNodImpl.getElementById(self, elementID: elementId)
  }
}

extension DocumentFragment: NonElementParentNode {
  func getElementById(elementId: String) -> Element? {
    return NonElementParentNodImpl.getElementById(self, elementID: elementId)
  }
}
