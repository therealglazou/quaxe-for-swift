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

protocol MutationObserver {
  func observer(target: Node, _ options: Dictionary<String, Bool>) -> Void
  func disconnect() -> Void
  func takeRecords() -> Array<MutationRecord>
}
