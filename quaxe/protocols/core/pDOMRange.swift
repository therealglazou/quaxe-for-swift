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

public protocol pDOMRange {
  var startContainer: pNode { get }
  var startOffset: ulong { get }
  var endContainer: pNode { get }
  var endOffset: ulong { get }
  var collapsed: Bool { get }
  var commonAncestorContainer: pNode { get }

  func setStart(_ node: pNode, _ offset: ulong);
  func setEnd(_ node: pNode, _ offset: ulong);
  func setStartBefore(_ node: pNode) throws -> Void
  func setStartAfter(_ node: pNode) throws -> Void
  func setEndBefore(_ node: pNode) throws -> Void
  func setEndAfter(_ node: pNode) throws -> Void
  func collapse(_ toStart: Bool) -> Void
  func selectNode(_ node: pNode) throws -> Void
  func selectNodeContents(_ node: pNode) throws -> Void

  func compareBoundaryPoints(_ how: ushort, _ sourceRange: pDOMRange) throws -> short

  func deleteContents() throws -> Void
  func extractContents() throws -> pDocumentFragment
  func cloneContents() throws -> pDocumentFragment
  func insertNode(_ node: pNode) throws -> Void
  func surroundContents(_ newParent: pNode) throws -> Void

  func cloneRange() -> pDOMRange
  func detach() -> Void

  func isPointInRange(_ node: pNode, offset: ulong) throws -> Bool
  func comparePoint(_ node: pNode, offset: ulong) throws -> short

  func intersectsNode(_ node: pNode) -> Bool

  func toString() -> DOMString
}
