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

public class DocumentFragment: Node, pDocumentFragment {

  internal var mTearoffs: Dictionary<String, AnyObject> = [:]

  override init() {
    super.init()
  }
}