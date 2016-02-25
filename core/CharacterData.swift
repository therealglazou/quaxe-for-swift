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

  static internal func _replaceData(node: pCharacterData, _ offset: ulong, var _ count: ulong, _ str: DOMString) throws -> Void {
    // Step 1
    let length = node.length

    // Step 2
    if offset > length {
      throw Exception.IndexSizeError
    }

    // Step 3
    if offset + count > length {
      count = length - offset
    }

    // Step 4
    MutationUtils.queueMutationRecord(node as! Node, "characterData", nil, nil, node.data, nil, nil, nil, nil)

    // Step 5, 6 and 7
    let index1 = node.data.startIndex.advancedBy(Int(offset))
    let index2 = node.data.startIndex.advancedBy(Int(offset + count))
    let preData = node.data.substringToIndex(index1)
    let postData = node.data.substringFromIndex(index2)
    (node as! CharacterData).data = preData + str + postData

    let rangeCollection = ((node as! Node).ownerDocument as! Document).rangeCollection
    // Step 8
    rangeCollection.forEach( {
      if ($0.startContainer as! Node === node as! Node && $0.startOffset > offset && $0.startOffset <= offset + count) {
        $0.setStart($0.startContainer!, offset);
      }
    })

    // Step 9
    rangeCollection.forEach( {
      if ($0.endContainer as! Node === node as! Node && $0.endOffset > offset && $0.endOffset <= offset + count) {
        $0.setEnd($0.endContainer!, offset);
      }
    })

    // Step 10
    rangeCollection.forEach( {
      if ($0.startContainer as! Node === node as! Node && $0.startOffset > offset + count) {
        $0.setStart($0.startContainer!, $0.startOffset + ulong(str.characters.count) - count);
      }
    })

    // Step 11
    rangeCollection.forEach( {
      if ($0.endContainer as! Node === node as! Node && $0.endOffset > offset + count) {
        $0.setEnd($0.endContainer!, $0.endOffset + ulong(str.characters.count) - count);
      }
    })
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
