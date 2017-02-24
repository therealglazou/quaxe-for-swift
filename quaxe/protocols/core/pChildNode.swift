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
  func before(_ nodes: Array<Either<pNode, DOMString>>) throws -> Void

  func after(_ nodes: Array<Either<pNode, DOMString>>) throws -> Void

  func replaceWith(_ nodes: Array<Either<pNode, DOMString>>) throws -> Void

  func remove() -> Void
}
