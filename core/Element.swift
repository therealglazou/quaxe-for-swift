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
import Foundation
public class Element: Node, pElement {

  static let HTML_NAMESPACE: DOMString = "http://www.w3.org/1999/xhtml"

  internal var mNamespaceURI: DOMString?
  internal var mPrefix: DOMString?
  internal var mLocalName: DOMString

  internal var qualifiedName: DOMString {
    var rv = ""
    if nil != mPrefix {
     rv += mPrefix! + ":"
    }
    return rv + mLocalName
  }

  public var namespaceURI: DOMString? { return mNamespaceURI }

  public var tagName: DOMString {
    var qname = qualifiedName
    if let ns = mNamespaceURI {
      if Element.HTML_NAMESPACE == ns {
        if let d = ownerDocument {
          if d.type == "html"
            qname = qname.uppercaseString
        }
      }
    }
  }
}