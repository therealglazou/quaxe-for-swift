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
 * https://dom.spec.whatwg.org/#trees
 * 
 * status: done
 */
internal class Trees {

  static func remove(node: Node, _ parent: Node) -> Void {
    if (node.previousSibling != nil) {
      (node.previousSibling as! Node).mNextSibling = node.nextSibling;
    }
    if (node.nextSibling != nil) {
      (node.nextSibling as! Node).mPreviousSibling = node.previousSibling;
    }
    if nil != parent.firstChild &&
       parent.firstChild as! Node === node {
      parent.mFirstChild = node.nextSibling;
    }
    if nil != parent.lastChild &&
       parent.lastChild as! Node === node {
      parent.mLastChild = nil;
    }
  }

  static func insertBefore(node: Node, _ parent: Node, _ child: Node?) -> Void {
    if nil == child {
      // append
      node.mPreviousSibling = parent.mLastChild
      node.mNextSibling = nil
      node.mParentNode = parent
      parent.mLastChild = node
      if nil == parent.firstChild {
        parent.mFirstChild = node
      }
    }
    else {
      node.mParentNode = parent
      node.mNextSibling = child
      node.mPreviousSibling = child!.previousSibling
      if nil != child!.previousSibling {
        (child!.mPreviousSibling as! Node).mNextSibling = node
      }
      else {
        parent.mFirstChild = node
      }
      child!.mPreviousSibling = node
    }
  }

  static func append(node: Node, _ parent: Node) -> Void {
    insertBefore(node, parent, nil)
  }

  static func getRootOf(var node: Node) -> Node {
    while nil != node.parentNode {
      node = node.parentNode as! Node
    }
    return node
  }

  static func isDescendantOf(var node: Node, _ candidate: Node) -> Bool {
    while nil != node.parentNode {
      if node.parentNode as! Node === candidate {
        return true
      }
      node = node.parentNode as! Node
    }
    return false
  }

  static func isInclusiveDescendantOf(node: Node, _ candidate: Node) -> Bool {
    return node === candidate ||
           Trees.isDescendantOf(node, candidate)
  }

  static func isAncestorOf(node: Node, _ candidate: Node) -> Bool {
    return Trees.isDescendantOf(candidate, node)
  }

  static func isInclusiveAncestorOf(node: Node, _ candidate: Node) -> Bool {
    return Trees.isInclusiveDescendantOf(candidate, node)
  }

  static func isSiblingOf(node: Node, _ candidate: Node) -> Bool {
    return nil != node.parentNode &&
           nil != candidate.parentNode &&
           node.parentNode as! Node === candidate.parentNode as! Node
  }

  static func isInclusiveSiblingOf(node: Node, _ candidate: Node) -> Bool {
    return node === candidate ||
           Trees.isSiblingOf(node, candidate)
  }

  static func isPreceding(node: Node, _ candidate: Node) -> Bool {
    return Trees.getRootOf(node) === Trees.getRootOf(candidate) &&
           node.compareDocumentPosition(candidate) == Node.DOCUMENT_POSITION_PRECEDING
  }

  static func isFollowing(node: Node, _ candidate: Node) -> Bool {
    return Trees.getRootOf(node) === Trees.getRootOf(candidate) &&
           node.compareDocumentPosition(candidate) == Node.DOCUMENT_POSITION_FOLLOWING
  }

  static func indexOf(node: Node) -> ulong {
    var rv: ulong = 0
    var child: pNode? = node
    while nil != child && nil != child!.previousSibling {
      rv++
      child = child!.previousSibling
    }
    return rv
  }

  static func _listElementsWithQualifiedName(root: pNode?, _ qualifiedName: DOMString, var _ elementArray: Array<Element>) -> Void {
    var child = root
    while nil != child {
      if Node.ELEMENT_NODE == child!.nodeType {
        if "*" == qualifiedName {
          elementArray.append(child as! Element)
        }
        else if nil != child!.ownerDocument &&
                "html" == child!.ownerDocument!.type {
          if (child as! Element).namespaceURI == Namespaces.HTML_NAMESPACE &&
             (child as! Element).qualifiedName.lowercaseString == qualifiedName.lowercaseString {
            elementArray.append(child as! Element)
          }
          if (child as! Element).namespaceURI != Namespaces.HTML_NAMESPACE &&
             (child as! Element).qualifiedName == qualifiedName {
            elementArray.append(child as! Element)
          }
        }
        else if (child as! Element).qualifiedName == qualifiedName {
          elementArray.append(child as! Element)
        }
      }

      if nil != child!.firstChild {
        Trees._listElementsWithQualifiedName(child!.firstChild, qualifiedName, elementArray)
      }

      child = child!.nextSibling
    }
  }

  static func listElementsWithQualifiedName(root: Node, _ qualifiedName: DOMString) -> HTMLCollection {
    let elementArray: Array<Element> = []
    Trees._listElementsWithQualifiedName(root.firstChild, qualifiedName, elementArray)
    return HTMLCollection(elementArray)
  }

  static func _listElementsWithQualifiedNameAndNamespace(root: pNode?, _ namespace: DOMString?, _ localName: DOMString, var _ elementArray: Array<Element>) -> Void {
    var child = root
    while nil != child {
      if Node.ELEMENT_NODE == child!.nodeType {
        if "*" == namespace && "*" == localName {
          elementArray.append(child as! Element)
        }
        else if "*" == namespace {
          if (child as! Element).localName == localName {
            elementArray.append(child as! Element)
          }
        }
        else if "*" == localName {
          if (child as! Element).namespaceURI == namespace {
            elementArray.append(child as! Element)
          }
        }
        else {
          if (child as! Element).localName == localName &&
             (child as! Element).namespaceURI == namespace {
            elementArray.append(child as! Element)
          }
        }
      }

      if nil != child!.firstChild {
        Trees._listElementsWithQualifiedNameAndNamespace(child!.firstChild, namespace, localName, elementArray)
      }

      child = child!.nextSibling
    }
  }

  static func listElementsWithQualifiedNameAndNamespace(root: Node, var _ namespace: DOMString?, _ localName: DOMString) -> HTMLCollection {
    let elementArray: Array<Element> = []
    if "" == namespace {
      namespace = nil
    }
    Trees._listElementsWithQualifiedNameAndNamespace(root.firstChild, namespace, localName, elementArray)
    return HTMLCollection(elementArray)
  }

  static func _listElementsWithClassNames(root: pNode?, _ classes: Set<String>, var _ elementArray: Array<Element>) -> Void {
    var child = root
    while nil != child {
      if Node.ELEMENT_NODE == child!.nodeType {
        let elementClasses = OrderedSets.parse((child as! Element).className)
        if elementClasses.isSubsetOf(classes) {
          elementArray.append(child as! Element)
        }
      }

      if nil != child!.firstChild {
        Trees._listElementsWithClassNames(child!.firstChild, classes, elementArray)
      }

      child = child!.nextSibling
    }
  }

  static func listElementsWithClassNames(root: Node, _ classNames: DOMString) -> HTMLCollection {
    let classes = OrderedSets.parse(classNames)
    if classes.isEmpty {
      return HTMLCollection()
    }

    let elementArray: Array<Element> = []
    Trees._listElementsWithClassNames(root.firstChild, classes, elementArray)
    return HTMLCollection(elementArray)
  }
}
