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

import QuaxeUtils // Either

/*
 * https://dom.spec.whatwg.org/#childnode
 * 
 * status: done
 */
public class ChildNode {

  static func firstViableSibling(n: Node, _ nodes: Array<Either<pNode, DOMString>>, _ reverseDirection: Bool) -> Node? {
    var sibling = reverseDirection ? n.previousSibling : n.nextSibling
    while nil != sibling {
      var found = false
      for e in nodes where !found {
        switch e {
          case .Left(let node):
            if node as! Node === sibling as! Node {
              found = true
            }
          default: break
        }
      }
      if !found {
        return sibling as? Node
      }
      sibling = reverseDirection ? sibling!.previousSibling : sibling!.nextSibling
    }
    return nil
  }

  /**
   * https://dom.spec.whatwg.org/#dom-childnode-before
   */
  static func before(n: Node, _ nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    //Step 1
    let parent = n.parentNode

    //Step 2
    if nil == parent {
      return
    }

    // Step 3
    var viablePreviousSibling = ChildNode.firstViableSibling(n, nodes, true)

    // Step 4
    let node = try ParentNode._convertNodesIntoNode(nodes)

    // Step 5
    if nil != viablePreviousSibling {
      viablePreviousSibling = viablePreviousSibling!.nextSibling as? Node
    }
    else {
      viablePreviousSibling = parent!.firstChild as? Node
    }

    // Step 6
    try MutationAlgorithms.preInsert(node, parent as! Node, viablePreviousSibling)
  }

  static func after(n: Node, _ nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    //Step 1
    let parent = n.parentNode

    //Step 2
    if nil == parent {
      return
    }

    // Step 3
    let viableNextSibling = ChildNode.firstViableSibling(n, nodes, false)

    // Step 4
    let node = try ParentNode._convertNodesIntoNode(nodes)

    // Step 5
    try MutationAlgorithms.preInsert(node, parent as! Node, viableNextSibling)
  }

  static func replaceWith(n: Node, _ nodes: Array<Either<pNode, DOMString>>) throws -> Void {    //Step 1
    //Step 1
    let parent = n.parentNode

    //Step 2
    if nil == parent {
      return
    }

    // Step 3
    let viableNextSibling = ChildNode.firstViableSibling(n, nodes, false)

    // Step 4
    let node = try ParentNode._convertNodesIntoNode(nodes)

    // Step 5
    if nil != n.parentNode && parent as! Node === n.parentNode as! Node {
      try MutationAlgorithms.replace(n, node, parent as! Node)
      return
    }

    // Step 6
    try MutationAlgorithms.preInsert(node, parent as! Node, viableNextSibling)
}

  static func remove(n: Node) -> Void {
    // Step 1
    if nil == n.parentNode {
      return
    }

    // Step 2
    MutationAlgorithms.remove(n, n.parentNode as! Node)
  }
}

/*
 * extending DocumentType, Element, CharacterData
 */

extension DocumentType: pChildNode {
  public func before(nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    try ChildNode.before(self, nodes)
  }

  public func after(nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    try ChildNode.after(self, nodes)
  }

  public func replaceWith(nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    try ChildNode.replaceWith(self, nodes)
  }

  public func remove() -> Void {
    ChildNode.remove(self)
  }
}

extension Element: pChildNode {
  public func before(nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    try ChildNode.before(self, nodes)
  }

  public func after(nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    try ChildNode.after(self, nodes)
  }

  public func replaceWith(nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    try ChildNode.replaceWith(self, nodes)
  }

  public func remove() -> Void {
    ChildNode.remove(self)
  }
}

extension CharacterData: pChildNode {
  public func before(nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    try ChildNode.before(self, nodes)
  }

  public func after(nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    try ChildNode.after(self, nodes)
  }

  public func replaceWith(nodes: Array<Either<pNode, DOMString>>) throws -> Void {
    try ChildNode.replaceWith(self, nodes)
  }

  public func remove() -> Void {
    ChildNode.remove(self)
  }
}

