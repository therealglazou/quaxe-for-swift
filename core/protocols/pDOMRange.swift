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

public protocol pDOMRange {
  var startContainer: pNode { get }
  var startOffset: ulong { get }
  var endContainer: pNode { get }
  var endOffset: pNode { get }
  var collapsed: Bool { get }
  var commonAncestorContainer: pNode { get }

  func setStart(node: pNode, _ offset: ulong);
  func setEnd(node: pNode, _ offset: ulong);
  func setStartBefore(node: pNode) -> Void
  func setStartAfter(node: pNode) -> Void
  func setEndBefore(node: pNode) -> Void
  func setEndAfter(node: pNode) -> Void
  func collapse(toStart: Bool) -> Void
  func selectNode(nod: pNode) -> Void
  func selectNodeContents(node: pNode) -> Void

  func compareBoundaryPoints(how: ushort, _ sourceRange: pDOMRange) -> short

  func deleteContents() -> Void
  func extractContents() -> pDocumentFragment
  func cloneContents() -> pDocumentFragment
  func insertNode(node: pNode) -> Void
  func surroundContents(node: pNode) -> Void

  func cloneRange() -> pDOMRange
  func detach() -> Void

  func isPointInRange(node: pNode, offset: ulong) -> Bool
  func comparePoint(node: pNode, offset: ulong) -> short

  func intersectsNode(node: pNode) -> Bool

  func toString() -> DOMString
}
