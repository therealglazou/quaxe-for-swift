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



public class CharacterData: Node, pCharacterData {

  internal var mTearoffs: Dictionary<String, AnyObject> = [:]

  public var data: DOMString = ""
  public var length: ulong = 0
  public func substringData(offset: ulong, _ count: ulong) -> DOMString { return ""}
  public func appendData(data: DOMString) -> Void {}
  public func insertData(offset: ulong, _ data: DOMString) -> Void {}
  public func deleteData(offset: ulong, _ count: ulong) -> Void {}
  public func replaceData(offset: ulong, _ count: ulong, _ data: DOMString) -> Void {}

  override init() {
    super.init()
  }
}
