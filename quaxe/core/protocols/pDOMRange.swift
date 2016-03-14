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
  var endOffset: ulong { get }
  var collapsed: Bool { get }
  var commonAncestorContainer: pNode { get }

  func setStart(node: pNode, _ offset: ulong);
  func setEnd(node: pNode, _ offset: ulong);
  func setStartBefore(node: pNode) throws -> Void
  func setStartAfter(node: pNode) throws -> Void
  func setEndBefore(node: pNode) throws -> Void
  func setEndAfter(node: pNode) throws -> Void
  func collapse(toStart: Bool) -> Void
  func selectNode(node: pNode) throws -> Void
  func selectNodeContents(node: pNode) throws -> Void

  func compareBoundaryPoints(how: ushort, _ sourceRange: pDOMRange) throws -> short

  func deleteContents() throws -> Void
  func extractContents() throws -> pDocumentFragment
  func cloneContents() throws -> pDocumentFragment
  func insertNode(node: pNode) throws -> Void
  func surroundContents(newParent: pNode) throws -> Void

  func cloneRange() -> pDOMRange
  func detach() -> Void

  func isPointInRange(node: pNode, offset: ulong) throws -> Bool
  func comparePoint(node: pNode, offset: ulong) -> short

  func intersectsNode(node: pNode) -> Bool

  func toString() -> DOMString
}
