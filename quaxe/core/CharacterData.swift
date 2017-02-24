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

/**
 * https://dom.spec.whatwg.org/#interface-characterdata
 * 
 * status: done
 */
public class CharacterData: Node, pCharacterData {

  /**
   * https://dom.spec.whatwg.org/#dom-characterdata-data
   * 
   * Cannot TreatNullAsEmptyString here because it would imply
   * unwrapping the string every time <CharacterData>.data is accessed...
   */
  public var data: DOMString = ""

  /**
   * https://dom.spec.whatwg.org/#dom-characterdata-length
   */
  public var length: ulong {
    return ulong(data.unicodeScalars.count)
  }

  /**
   * https://dom.spec.whatwg.org/#concept-cd-substring
   */
  static internal func _substringData(_ node: pCharacterData, _ offset: ulong, _ count: ulong) throws -> DOMString {
    // Step 1
    let length = node.length

    // Step 2
    if offset > length {
      throw Exception.IndexSizeError
    }

    let index1 = node.data.unicodeScalars.index(node.data.unicodeScalars.startIndex, offsetBy: Int(offset))
    let index2 = node.data.unicodeScalars.index(node.data.unicodeScalars.startIndex, offsetBy: Int(offset + count))
    // Step 3
    if offset + count > length {
      return  String(node.data.unicodeScalars[index1..<node.data.unicodeScalars.endIndex])
    }

    // Step 4
    return String(node.data.unicodeScalars[index1..<index2])
  }

  /**
   * https://dom.spec.whatwg.org/#concept-cd-replace
   */
  static internal func _replaceData(_ node: pCharacterData, _ offset: ulong, _ c: ulong, _ str: DOMString) throws -> Void {
    var count = c
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
    let index1 = node.data.unicodeScalars.index(node.data.unicodeScalars.startIndex, offsetBy: Int(offset))
    let index2 = node.data.unicodeScalars.index(node.data.unicodeScalars.startIndex, offsetBy: Int(offset + count))
    let preData = String(node.data.unicodeScalars[node.data.unicodeScalars.startIndex..<index1])
    let postData = String(node.data.unicodeScalars[index2..<node.data.unicodeScalars.endIndex])
    (node as! CharacterData).data = preData + str + postData

    let rangeCollection = ((node as! Node).ownerDocument as! Document).rangeCollection
    // Step 8
    rangeCollection.forEach( {
      if ($0.value != nil &&
          $0.value!.startContainer as! Node === node as! Node &&
          $0.value!.startOffset > offset &&
          $0.value!.startOffset <= offset + count) {
        $0.value!.setStart($0.value!.startContainer, offset);
      }
    })

    // Step 9
    rangeCollection.forEach( {
      if ($0.value != nil &&
          $0.value!.endContainer as! Node === node as! Node &&
          $0.value!.endOffset > offset &&
          $0.value!.endOffset <= offset + count) {
        $0.value!.setEnd($0.value!.endContainer, offset);
      }
    })

    // Step 10
    rangeCollection.forEach( {
      if ($0.value != nil &&
          $0.value!.startContainer as! Node === node as! Node &&
          $0.value!.startOffset > offset + count) {
        $0.value!.setStart($0.value!.startContainer, $0.value!.startOffset + ulong(str.unicodeScalars.count) - count);
      }
    })

    // Step 11
    rangeCollection.forEach( {
      if ($0.value != nil &&
          $0.value!.endContainer as! Node === node as! Node &&
          $0.value!.endOffset > offset + count) {
        $0.value!.setEnd($0.value!.endContainer, $0.value!.endOffset + ulong(str.unicodeScalars.count) - count);
      }
    })
  }

  /**
   * https://dom.spec.whatwg.org/#dom-characterdata-substringdata
   */
  public func substringData(_ offset: ulong, _ count: ulong) throws -> DOMString {
    return try CharacterData._substringData(self, offset, count)
  }

  /**
   * https://dom.spec.whatwg.org/#dom-characterdata-appenddata
   */
  public func appendData(_ data: DOMString) throws -> Void {
    try CharacterData._replaceData(self, self.length, 0, data)
  }

  /**
   * https://dom.spec.whatwg.org/#dom-characterdata-insertdata
   */
  public func insertData(_ offset: ulong, _ data: DOMString) throws -> Void {
    try CharacterData._replaceData(self, offset, 0, data)
  }

  /**
   * https://dom.spec.whatwg.org/#dom-characterdata-deletedata
   */
  public func deleteData(_ offset: ulong, _ count: ulong) throws -> Void {
    try CharacterData._replaceData(self, offset, count, "")
  }

  /**
   * https://dom.spec.whatwg.org/#dom-characterdata-replacedata
   */
  public func replaceData(_ offset: ulong, _ count: ulong, _ str: DOMString) throws -> Void {
    try CharacterData._replaceData(self, offset, count, str)
  }

  override init() {
    super.init()
  }
}
