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
  public var length: ulong {
    return ulong(data.characters.count)
  }

  static internal func _substringData(node: pCharacterData, _ offset: ulong, _ count: ulong) throws -> DOMString {
    // Step 1
    let length = node.length

    // Step 2
    if offset > length {
      throw Exception.IndexSizeError
    }

    let index1 = node.data.startIndex.advancedBy(Int(offset))
    let index2 = node.data.startIndex.advancedBy(Int(offset + count))
    // Step 3
    if offset + count > length {
      return  node.data.substringFromIndex(index1)
    }

    // Step 4
    return node.data.substringWithRange(index1...index2)
  }

  public func substringData(offset: ulong, _ count: ulong) throws -> DOMString {
    return try CharacterData._substringData(self, offset, count)
  }

  public func appendData(str: DOMString) -> Void {
    self.data += str
  }

  public func insertData(offset: ulong, _ str: DOMString) -> Void {
    let index1 = self.data.startIndex.advancedBy(Int(offset))
    let preData = self.data.substringToIndex(index1)
    let postData = self.data.substringFromIndex(index1)
    self.data = preData + str + postData
  }

  public func deleteData(offset: ulong, _ count: ulong) -> Void {
    let index1 = self.data.startIndex.advancedBy(Int(offset))
    let index2 = self.data.startIndex.advancedBy(Int(offset + count))
    let preData = self.data.substringToIndex(index1)
    let postData = self.data.substringFromIndex(index2)
    self.data = preData + postData
  }

  public func replaceData(offset: ulong, _ count: ulong, _ str: DOMString) -> Void {
    let index1 = self.data.startIndex.advancedBy(Int(offset))
    let index2 = self.data.startIndex.advancedBy(Int(offset + count))
    let preData = self.data.substringToIndex(index1)
    let postData = self.data.substringFromIndex(index2)
    self.data = preData + str + postData
  }

  override init() {
    super.init()
  }
}
