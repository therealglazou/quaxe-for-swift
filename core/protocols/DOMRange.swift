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

public protocol DOMRange {
  var startContainer: Node { get }
  var startOffset: ulong { get }
  var endContainer: Node { get }
  var endOffset: Node { get }
  var collapsed: Bool { get }
  var commonAncestorContainer: Node { get }

  func setStart(node: Node, _ offset: ulong);
  func setEnd(node: Node, _ offset: ulong);
  func setStartBefore(node: Node) -> Void
  func setStartAfter(node: Node) -> Void
  func setEndBefore(node: Node) -> Void
  func setEndAfter(node: Node) -> Void
  func collapse(toStart: Bool) -> Void
  func selectNode(nod: Node) -> Void
  func selectNodeContents(node: Node) -> Void

  func compareBoundaryPoints(how: ushort, _ sourceRange: DOMRange) -> short

  func deleteContents() -> Void
  func extractContents() -> DocumentFragment
  func cloneContents() -> DocumentFragment
  func insertNode(node: Node) -> Void
  func surroundContents(node: Node) -> Void

  func cloneRange() -> DOMRange
  func detach() -> Void

  func isPointInRange(node: Node, offset: ulong) -> Bool
  func comparePoint(node: Node, offset: ulong) -> short

  func intersectsNode(node: Node) -> Bool

  func toString() -> DOMString
}
