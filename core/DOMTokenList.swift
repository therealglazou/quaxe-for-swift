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

public class DOMTokenList: pDOMTokenList {
  public var length: ulong = 0
  public func item(index: ulong) -> DOMString? {return ""}
  public func contains(token: DOMString) -> Bool {return false}
  public func add(tokens: DOMString...) -> Void {}
  public func remove(tokens: DOMString...) -> Void {}
  public func toggle(token: DOMString, _ force: Bool) -> Bool {return false}
  public func replace(token: DOMString, _ newToken: DOMString) -> Void {}
  public func supports(token: DOMString) -> Bool  {return false}
  public var value: DOMString = ""
  public func ToString() -> DOMString {return ""}

  init() {}
}
