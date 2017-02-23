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
 * https://dom.spec.whatwg.org/#interface-documenttype
 * 
 * status: done
 */
public class DocumentType: Node, pDocumentType {

  internal var mName: DOMString = ""
  internal var mPublicId: DOMString = ""
  internal var mSystemId: DOMString = ""

  /**
   * https://dom.spec.whatwg.org/#dom-documenttype-name
   */
  public var name: DOMString { return mName }

  /**
   * https://dom.spec.whatwg.org/#dom-documenttype-publicid
   */
  public var publicId: DOMString { return mPublicId }

  /**
   * https://dom.spec.whatwg.org/#dom-documenttype-systemid
   */
  public var systemId: DOMString { return mSystemId }

  /**
   * https://dom.spec.whatwg.org/#interface-documenttype
   */
  init(_ name: DOMString, _ publicId: DOMString = "", _ systemId: DOMString = "") {
    self.mName = name
    self.mPublicId = publicId
    self.mSystemId = systemId
    super.init()
  }
}
