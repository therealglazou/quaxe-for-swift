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
 * https://dom.spec.whatwg.org/#trees
 * 
 * status: done
 */
internal class Trees {

  static func remove(_ node: Node, _ parent: Node) -> Void {
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

  static func insertBefore(_ node: Node, _ parent: Node, _ child: Node?) -> Void {
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

  static func append(_ node: Node, _ parent: Node) -> Void {
    insertBefore(node, parent, nil)
  }

  static func getRootOf(_ n: Node) -> Node {
    var node = n
    while nil != node.parentNode {
      node = node.parentNode as! Node
    }
    return node
  }

  static func isDescendantOf(_ n: Node, _ candidate: Node) -> Bool {
    var node = n
    while nil != node.parentNode {
      if node.parentNode as! Node === candidate {
        return true
      }
      node = node.parentNode as! Node
    }
    return false
  }

  static func isInclusiveDescendantOf(_ node: Node, _ candidate: Node) -> Bool {
    return node === candidate ||
           Trees.isDescendantOf(node, candidate)
  }

  static func isAncestorOf(_ node: Node, _ candidate: Node) -> Bool {
    return Trees.isDescendantOf(candidate, node)
  }

  static func isInclusiveAncestorOf(_ node: Node, _ candidate: Node) -> Bool {
    return Trees.isInclusiveDescendantOf(candidate, node)
  }

  static func isSiblingOf(_ node: Node, _ candidate: Node) -> Bool {
    return nil != node.parentNode &&
           nil != candidate.parentNode &&
           node.parentNode as! Node === candidate.parentNode as! Node
  }

  static func isInclusiveSiblingOf(_ node: Node, _ candidate: Node) -> Bool {
    return node === candidate ||
           Trees.isSiblingOf(node, candidate)
  }

  static func isPreceding(_ node: Node, _ candidate: Node) -> Bool {
    return Trees.getRootOf(node) === Trees.getRootOf(candidate) &&
           node.compareDocumentPosition(candidate) == Node.DOCUMENT_POSITION_PRECEDING
  }

  static func isFollowing(_ node: Node, _ candidate: Node) -> Bool {
    return Trees.getRootOf(node) === Trees.getRootOf(candidate) &&
           node.compareDocumentPosition(candidate) == Node.DOCUMENT_POSITION_FOLLOWING
  }

  static func indexOf(_ node: Node) -> ulong {
    var rv: ulong = 0
    var child: pNode? = node
    while nil != child && nil != child!.previousSibling {
      rv += 1
      child = child!.previousSibling
    }
    return rv
  }

  static func _listElementsWithQualifiedName(_ root: pNode?, _ qualifiedName: DOMString, _ ea: Array<Element>) -> Void {
    var elementArray = ea
    var child = root
    while nil != child {
      if Node.ELEMENT_NODE == child!.nodeType {
        if "*" == qualifiedName {
          elementArray.append(child as! Element)
        }
        else if nil != child!.ownerDocument &&
                "html" == child!.ownerDocument!.type {
          if (child as! Element).namespaceURI == Namespaces.HTML_NAMESPACE &&
             (child as! Element).qualifiedName.lowercased() == qualifiedName.lowercased() {
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

  static func listElementsWithQualifiedName(_ root: Node, _ qualifiedName: DOMString) -> HTMLCollection {
    let elementArray: Array<Element> = []
    Trees._listElementsWithQualifiedName(root.firstChild, qualifiedName, elementArray)
    return HTMLCollection(elementArray)
  }

  static func _listElementsWithQualifiedNameAndNamespace(_ root: pNode?, _ namespace: DOMString?, _ localName: DOMString, _ ea: Array<Element>) -> Void {
    var elementArray = ea
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

  static func listElementsWithQualifiedNameAndNamespace(_ root: Node, _ ns: DOMString?, _ localName: DOMString) -> HTMLCollection {
    var namespace = ns
    let elementArray: Array<Element> = []
    if "" == namespace {
      namespace = nil
    }
    Trees._listElementsWithQualifiedNameAndNamespace(root.firstChild, namespace, localName, elementArray)
    return HTMLCollection(elementArray)
  }

  static func _listElementsWithClassNames(_ root: pNode?, _ classes: Set<String>, _ ea: Array<Element>) -> Void {
    var elementArray = ea
    var child = root
    while nil != child {
      if Node.ELEMENT_NODE == child!.nodeType {
        let elementClasses = OrderedSets.parse((child as! Element).className)
        if elementClasses.isSubset(of: classes) {
          elementArray.append(child as! Element)
        }
      }

      if nil != child!.firstChild {
        Trees._listElementsWithClassNames(child!.firstChild, classes, elementArray)
      }

      child = child!.nextSibling
    }
  }

  static func listElementsWithClassNames(_ root: Node, _ classNames: DOMString) -> HTMLCollection {
    let classes = OrderedSets.parse(classNames)
    if classes.isEmpty {
      return HTMLCollection()
    }

    let elementArray: Array<Element> = []
    Trees._listElementsWithClassNames(root.firstChild, classes, elementArray)
    return HTMLCollection(elementArray)
  }

  static func length(_ node: Node) -> ulong {
    switch node.nodeType {
      case Node.DOCUMENT_TYPE_NODE: return 0
      case Node.TEXT_NODE,
           Node.COMMENT_NODE,
           Node.PROCESSING_INSTRUCTION_NODE: return (node as! CharacterData).length
      default: return node.childNodes.length
    }
  }

  static func nextInTraverseOrder(_ node: Node) -> pNode? {
    if nil != node.firstChild {
      return node.firstChild
    }
    if nil != node.nextSibling {
      return node.nextSibling
    }

    var parent = node.parentNode
    while nil != parent && nil == parent!.nextSibling {
      parent = parent!.parentNode
    }
    if nil != parent {
      return parent!.nextSibling
    }
    return nil
  }
}
