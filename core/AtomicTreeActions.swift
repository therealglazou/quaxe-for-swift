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

internal class AtomicTreeActions {

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
}
