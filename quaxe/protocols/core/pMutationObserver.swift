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

public protocol pMutationObserver {
  func observer(_ target: pNode, _ options: Dictionary<String, Bool>) -> Void
  func disconnect() -> Void
  func takeRecords() -> Array<pMutationRecord>
}
