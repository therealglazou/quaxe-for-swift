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

import QuaxeUtils

public protocol pChildNode {
  func before(nodes: Array<Either<pNode, DOMString>>) throws -> Void

  func after(nodes: Array<Either<pNode, DOMString>>) throws -> Void

  func replaceWith(nodes: Array<Either<pNode, DOMString>>) throws -> Void

  func remove() -> Void
}
