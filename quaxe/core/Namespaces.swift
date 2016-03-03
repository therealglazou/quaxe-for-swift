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

import QuaxeCoreProtocols

internal class Namespaces {

  static let HTML_NAMESPACE  = "http://www.w3.org/1999/xhtml"
  static let XML_NAMESPACE   = "http://www.w3.org/XML/1998/namespace"
  static let XMLNS_NAMESPACE = "http://www.w3.org/2000/xmlns/"

  static let NAME_START_CHAR = "A-Z_a-z\u{00C0}-\u{00D6}\u{00D8}-\u{00F6}\u{00F8}-\u{02FF}\u{0370}-\u{037D}\u{037F}-\u{1FFF}\u{200C}-\u{200D}\u{2070}-\u{218F}\u{2C00}-\u{2FEF}\u{3001}-\u{D7FF}\u{F900}-\u{FDCF}\u{FDF0}-\u{FFFD}"
  static let NAME_CHAR = NAME_START_CHAR + "\\-\\.0-9\u{00B7}\u{0300}-\u{036F}\u{203F}-\u{2040}"
  static let NAME = "[:" + NAME_START_CHAR + "][:" + NAME_CHAR + "]*"
  static let NCNAME = "[" + NAME_START_CHAR + "][" + NAME_CHAR + "]*"
  static let NAME_EREG  = "^(" + NAME + ")$"
  static let PREFIXED_NAME_EREG = "^(" + NCNAME + ")(:(" + NCNAME + "))?$"

  /*
   * https://dom.spec.whatwg.org/#validate
   */
  static func validateAsXMLName(name: DOMString) throws -> Void
  {
    if nil == name.rangeOfString(Namespaces.NAME_EREG, options: .RegularExpressionSearch) {
      throw Exception.InvalidCharacterError
    }
  }

  static func validateAsXMLQName(name: DOMString) throws -> Void {
    if nil == name.rangeOfString(Namespaces.PREFIXED_NAME_EREG, options: .RegularExpressionSearch) {
      throw Exception.NamespaceError
    }
  }

  static func validateQualifiedName(name: DOMString) throws -> Void {
    try Namespaces.validateAsXMLName(name);
    try Namespaces.validateAsXMLQName(name);
  }

  /*
   * https://dom.spec.whatwg.org/#validate-and-extract
   */
  static func validateAndExtract(var namespaceURI: DOMString?, _ qualifiedName: DOMString) throws -> Dictionary<DOMString, DOMString?> {
    if nil != namespaceURI && "" == namespaceURI {
      namespaceURI = nil
    }

    try Namespaces.validateQualifiedName(qualifiedName);

    var prefix: DOMString? = nil
    var localName = qualifiedName

    if let colonPosition = qualifiedName.rangeOfString(":") {
      prefix = qualifiedName.substringToIndex(colonPosition.startIndex)
      localName = qualifiedName.substringFromIndex(colonPosition.endIndex)
    }

    if nil != prefix && nil == namespaceURI {
      throw Exception.NamespaceError
    }

    if nil != prefix &&
       "xml" == prefix! &&
       Namespaces.XML_NAMESPACE != namespaceURI {
      throw Exception.NamespaceError
    }

    if Namespaces.XMLNS_NAMESPACE != namespaceURI &&
       (qualifiedName == "xmlns" || prefix == "xmlns") {
      throw Exception.NamespaceError
    }

    if Namespaces.XMLNS_NAMESPACE == namespaceURI &&
       qualifiedName != "xmlns" &&
       prefix != "xmlns" {
      throw Exception.NamespaceError
    }

    return [
             "namespace": namespaceURI,
             "localName": localName,
             "prefix": prefix
           ]
  }
}
