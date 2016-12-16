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

import Foundation

/**
 * https://dom.spec.whatwg.org/#interface-domtokenlist
 * 
 * status: TODO 1%
 */
public class DOMTokenList: pDOMTokenList {

  internal var mTokens: Set<DOMString> = []
  internal weak var mOwnerElement: Element?
  internal var mOwnerAttribute: DOMString = ""

  static func containsASCIIWhitespace(str: DOMString) -> Bool {
    let whitespace = NSCharacterSet.whitespaceCharacterSet()
    let range = str.rangeOfCharacterFromSet(whitespace)
    if let _ = range {
      return true
    }
    return false
  }

  /*
   * https://dom.spec.whatwg.org/#concept-dtl-update
   */
  internal func updateSteps() -> Void {
    if  self.mOwnerElement != nil &&
        self.mOwnerAttribute != "" {
      let value = self.toString()
      Element.setAttributeByLocalNameAndValue(self.mOwnerElement!,
                                              self.mOwnerAttribute,
                                              value)
    }
  }

  /*
   * https://dom.spec.whatwg.org/#concept-dtl-serialize
   */
  internal func serializeSteps() -> DOMString {
    if  self.mOwnerElement != nil &&
        self.mOwnerAttribute != "" {
      let attr = Element.getAttributeByNamespaceAndLocalName(self.mOwnerElement!,
                                                             self.mOwnerAttribute)
      if attr != nil {
        return attr!.value
      }
    }
    return ""
  }

  /**
   * https://dom.spec.whatwg.org/#dom-domtokenlist-length
   */
  public var length: ulong {
    return ulong(self.mTokens.count)
  }

  /**
   * https://dom.spec.whatwg.org/#dom-domtokenlist-item
   */
  public func item(index: ulong) -> DOMString? {
    if index >= self.length {
      return nil
    }
    return self.mTokens[self.mTokens.startIndex.advancedBy(Int(index))]
  }

  /**
   * https://dom.spec.whatwg.org/#dom-domtokenlist-contains
   */
  public func contains(token: DOMString) throws -> Bool {
    if token.isEmpty {
      throw Exception.SyntaxError
    }

    if DOMTokenList.containsASCIIWhitespace(token) {
      throw Exception.InvalidCharacterError
    }

    return self.mTokens.contains(token)
  }

  /**
   * https://dom.spec.whatwg.org/#dom-domtokenlist-add
   */
  public func add(tokens: DOMString...) throws -> Void {
    for token in tokens {
      if token.isEmpty {
        throw Exception.SyntaxError
      }
      if DOMTokenList.containsASCIIWhitespace(token) {
        throw Exception.InvalidCharacterError
      }
      if !self.mTokens.contains(token) {
        self.mTokens.insert(token)
      }
    }

    self.updateSteps()
  }

  /**
   * https://dom.spec.whatwg.org/#dom-domtokenlist-remove
   */
  public func remove(tokens: DOMString...) throws -> Void {
    for token in tokens {
      if token.isEmpty {
        throw Exception.SyntaxError
      }
      if DOMTokenList.containsASCIIWhitespace(token) {
        throw Exception.InvalidCharacterError
      }
      if self.mTokens.contains(token) {
        self.mTokens.remove(token)
      }
    }

    self.updateSteps()
  }

  internal func _toggle(token: DOMString, _ force: Bool, _ passed: Bool) throws -> Bool {
    if token.isEmpty {
      throw Exception.SyntaxError
    }

    if DOMTokenList.containsASCIIWhitespace(token) {
      throw Exception.InvalidCharacterError
    }

    if self.mTokens.contains(token) {
      if !passed || !force {
        self.mTokens.remove(token)
        self.updateSteps()
        return false
      }
      return true
    }

    if passed && !force {
      return false
    }
    self.mTokens.insert(token)
    self.updateSteps()
    return true
  }

  /**
   * https://dom.spec.whatwg.org/#dom-domtokenlist-toggle
   */
  public func toggle(token: DOMString) throws -> Bool {
    return try self._toggle(token, false, false)
  }
  public func toggle(token: DOMString, _ force: Bool) throws -> Bool {
    return try self._toggle(token, force, true)
  }

  /**
   * https://dom.spec.whatwg.org/#dom-domtokenlist-replace
   */
  public func replace(token: DOMString, _ newToken: DOMString) throws -> Void {
    if token.isEmpty || newToken.isEmpty {
      throw Exception.SyntaxError
    }

    if DOMTokenList.containsASCIIWhitespace(token) || DOMTokenList.containsASCIIWhitespace(newToken) {
      throw Exception.InvalidCharacterError
    }

    if !self.mTokens.contains(token) {
      return
    }
    self.mTokens.remove(token)
    self.mTokens.insert(newToken)
    self.updateSteps()
  }

  /**
   * https://dom.spec.whatwg.org/#dom-domtokenlist-supports
   */
  public func supports(token: DOMString) throws -> Bool  {
    // XXX
    return true
  }

  /**
   * https://dom.spec.whatwg.org/#dom-domtokenlist-value
   */
  public var value: DOMString {
    get {
      var s = ""
      for token in self.mTokens {
        s += (s.isEmpty ? "" : " ") + token
      }
      return s
    }

    set(newValue) {
      self.mTokens = []
      let components = newValue.componentsSeparatedByString(" ")
      for component in components {
        self.mTokens.insert(component)
      }

      if  self.mOwnerElement != nil &&
          self.mOwnerAttribute != "" {
        Element.setAttributeByLocalNameAndValue(self.mOwnerElement!,
                                                self.mOwnerAttribute,
                                                newValue)
      }
    }
  }

  /**
   * https://dom.spec.whatwg.org/#dom-domtokenlist-stringifier
   */
  public func toString() -> DOMString { return self.value }

  public subscript(index: ulong) -> DOMString {
    if index >= self.length {
      return ""
    }
    return self.mTokens[self.mTokens.startIndex.advancedBy(Int(index))]
  }

  internal init(_ elt: Element, _ attributeName: DOMString) {
    mOwnerElement = elt
    mOwnerAttribute = attributeName
  }

  init() {}
}
