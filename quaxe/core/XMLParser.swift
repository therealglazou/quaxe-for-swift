/*
 * Copyright (C)2005-2012 Haxe Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

import Foundation
import QuaxeUtils

enum S: UInt {
  case IGNORE_SPACES = 1
  case BEGIN
  case BEGIN_NODE
  case TAG_NAME
  case BODY
  case ATTRIB_NAME
  case EQUALS
  case ATTVAL_BEGIN
  case ATTRIB_VAL
  case CHILDREN
  case CLOSE
  case WAIT_END
  case WAIT_END_RET
  case PCDATA
  case PI_TARGET
  case PI_DATA
  case COMMENT
  case DOCTYPE
  case CDATA
  case ENTITY
}

public class XMLParser {

  private let NOT_WHITESPACE_ONLY_EREG = "[^\\t\\r\\n]"

  var document: Document? = nil

  var elementPrefix = ""
  var elementName: DOMString? = nil
  var attributesArray: Array<Array<DOMString>> = []

  var escapes: Dictionary<String, String> = [
    "lt": "<",
    "gt": ">",
    "amp": "&",
    "quot": "\"",
    "apos": "'",
    "nbsp": "\u{a0}"
  ]

  public func parse(str: String) throws -> Document {
    self.document = Document()
    try doParse(str, 0, self.document!)
    return self.document!
  }

  public func doCreateElement(parent: Node?) throws -> Node? {
    if nil == parent ||
       self.elementName == nil ||
       self.elementName == "" {
      return parent
    }

    var namespace: DOMString? = nil
    // first, validate the element prefix if we have to
    if self.elementPrefix.isEmpty {
      var namespaceDef = self.attributesArray.filter() {
        return $0[0] == "xmlns" && $0[1] == self.elementPrefix
      }
      if namespaceDef.count == 1 {
        namespace = namespaceDef[0][2]
      }
      else  { // no luck, look for the prefix on the ancestors
        namespace = parent!.lookupNamespaceURI(self.elementPrefix)
      }
      if namespace == nil ||
         namespace!.isEmpty {
        // unresolved prefix, this is an error
        throw Exception.NamespaceError
      }
    }
    else {
      if parent!.nodeType == Node.ELEMENT_NODE {
        namespace = (parent as! Element).namespaceURI
      }
      else {
        // case of the root element if the context document is known as a HTML document
        if self.document != nil &&
           self.document!.doctype != nil &&
           self.document!.doctype!.name == "html" {
          namespace = Namespaces.HTML_NAMESPACE
        }
      }
    }

    // TODO, switch on attributesArray
    let xml = try self.document!.createElementNS(namespace, (namespace != nil && namespace! == Namespaces.HTML_NAMESPACE)
                                                          ? self.elementName!.lowercaseString
                                                          : self.elementName!)
    parent!.appendChild(xml)
    if !self.elementPrefix.isEmpty {
      (xml as! Element).mPrefix = self.elementPrefix
    }

    // don't forget the attributes
    for attribute in self.attributesArray {
      let prefix = attribute[0]
      let name   = attribute[1]
      let value  = attribute[2]
      if prefix.isEmpty {
        xml.setAttribute(name, value)
        if name == "xmlns" {
          if !self.elementPrefix.isEmpty {
            throw Exception.NamespaceError
          }
          (xml as! Element).mNamespaceURI = value
        }
      }
      else {
        let n = (xml as! Node).lookupNamespaceURI(prefix)
        xml.setAttributeNS(n, (prefix != "" ? prefix + ":" : "") + name, value);
      }
    }

    self.elementName = nil
    return xml as? Node
  }

  internal func doParse(str: DOMString, var _ p: Int = 0, _ parent: Node) throws -> Int {
    var xml: Node? = nil
    var state = S.BEGIN
    var next = S.BEGIN
    var aname: DOMString? = nil
    var start = 0
    var nsubs = 0
    var nbrackets = 0
    var c = str[p]
    var buf = ""

    while c != "\n" {
      switch state {
        case S.IGNORE_SPACES:
          switch c {
            case "\n": break;
            default:
              state = next
              continue
          }
        case S.BEGIN:
          switch c {
            case "<":
              state = S.IGNORE_SPACES
              next = S.BEGIN_NODE
            default:
              start = p
              state = S.PCDATA
              continue
          }
        case S.PCDATA:
          if c == "<" {
            let toStore = buf + str.substr(start,p - start)
            if parent.nodeType == Node.ELEMENT_NODE {
              let child = self.document!.createTextNode(toStore)
              parent.appendChild(child)
            }
            else if nil != toStore.rangeOfString(self.NOT_WHITESPACE_ONLY_EREG, options: .RegularExpressionSearch) {
              throw Exception.HierarchyRequestError
            }
            buf = ""
            nsubs++
            state = S.IGNORE_SPACES
            next = S.BEGIN_NODE
          }
          else if c == "&" {
            buf += str.substr(start, p - start)
            state = S.ENTITY
            next = S.PCDATA
            start = p + 1
          }
        case S.CDATA:
          if c == "]" &&
             str[p+1] == "]" &&
             str[p+2] == ">" {
            let child = document!.createTextNode(str.substr(start, p - start))
            parent.appendChild(child)
            nsubs++
            p += 2
            state = S.BEGIN
          }
        case S.BEGIN_NODE:
          switch c {
            case "!":
              if str[p+1] == "[" {
                p += 2
                if str.substr(p, 6).uppercaseString != "CDATA[" {
                  throw Exception.CDATADeclarationExpected
                }
                p += 5
                state = S.CDATA
                start = p + 1
              }
              else if str[p+1] == "D" ||
                      str[p+1] == "d" {
                if str.substr(p+2, 6).uppercaseString != "OCTYPE" {
                  throw Exception.DOCTYPEDeclarationExpected
                }
                p += 8
                state = S.DOCTYPE
                start = p + 1
              }
              else if str[p+1] != "-" ||
                      str[p+2] != "-" {
                throw Exception.COMMENTDeclarationExpected
              }
              else {
                p += 2
                state = S.COMMENT
                start = p + 1
              }
            case "?":
              state = S.PI_TARGET
              start = p
            case "/":
              start = p + 1
              state = S.IGNORE_SPACES
              next = S.CLOSE
            default:
              state = S.TAG_NAME
              start = p
              continue
          }
        case S.TAG_NAME:
          if !self.isValidChar(c) {
            self.elementName = ""
            self.elementPrefix = ""
            if p == start {
              throw Exception.NODE_NAMEDeclarationExpected
            }
            let name = str.substr(start, p - start)
            let match = try Regex(Namespaces.PREFIXED_NAME_EREG).match(name)
            if match != nil && match!.count > 0 {
              self.attributesArray = []
              if match![3] == nil {
                self.elementName = name
              }
              else {
                self.elementName   = match![3]!
                self.elementPrefix = match![1]!
              }
            }
            else {
              throw Exception.InvalidCharacterError
            }
            state = S.IGNORE_SPACES
            next = S.BODY
            continue
          }
        case S.BODY:
          switch c {
            case "/":
              state = S.WAIT_END
              nsubs++
            case ">":
              xml = try doCreateElement(parent)
              state = S.CHILDREN
              nsubs++
            default:
              state = S.ATTRIB_NAME
              start = p
              continue
          }
        case S.ATTRIB_NAME:
          if !self.isValidChar(c) {
            if start == p {
              throw Exception.ATTRIBUTE_NAMEDeclarationExpected
            }
            aname = str.substr(start, p - start)
            state = S.IGNORE_SPACES
            next = S.EQUALS
            continue
          }
        case S.EQUALS:
          switch c {
            case "=":
              state = S.IGNORE_SPACES
              next = S.ATTVAL_BEGIN
            default:
              throw Exception.SyntaxError
          }
        case S.ATTVAL_BEGIN:
          switch c {
            case "\"", "'":
              state = S.ATTRIB_VAL
              start = p
            default:
              throw Exception.SyntaxError
          }
        case S.ATTRIB_VAL:
          if c == str[start] {
            let val = str.substr(start + 1, p - start - 1)
            let match = try Regex(Namespaces.PREFIXED_NAME_EREG).match(aname!)
            if match != nil && match!.count > 0 {
              if match![3] == nil {
                self.attributesArray.append(["", aname!, val])
              }
              else {
                self.attributesArray.append([match![1]!, match![3]!, val])
              }
            }
          }
          else {
            throw Exception.InvalidCharacterError
          }
          state = S.IGNORE_SPACES
          next = S.BODY
        case S.CHILDREN:
          p = try doParse(str, p, xml!)
          start = p
          state = S.BEGIN
        case S.WAIT_END:
          switch c {
            case ">":
              xml = try doCreateElement(parent)
              // doFinalizeElement(xml as! Element)
              state = S.BEGIN
            default:
              throw Exception.SyntaxError
          }
        case S.WAIT_END_RET:
          switch c {
            case ">":
              xml = try doCreateElement(parent)
              if self.elementName == nil ||
                 self.elementName! == "" {
                // doFinalizeElement(parent as! Element)
              }
              if nsubs == 0 &&
                 parent.nodeType == Node.ELEMENT_NODE {
                parent.appendChild(document!.createTextNode(""))
              }
            default:
              throw Exception.SyntaxError
          }
        case S.CLOSE:
          if !isValidChar(c) {
            if start == p {
              throw Exception.NODE_NAMEDeclarationExpected
            }

            let v = str.substr(start, p - start)
            var match = try Regex(Namespaces.PREFIXED_NAME_EREG).match(v)
            if match != nil && match!.count > 0 {
              if nil == match![3] {
                // no prefix found
                if v != (parent as! Element).localName {
                  throw Exception.SyntaxError
                }
              }
              else {
                let prefix = match![1]!
                let nmsp = parent.lookupNamespaceURI(prefix)
                if nmsp != (parent as! Element).namespaceURI {
                  throw Exception.SyntaxError
                }
              }
            }
            else {
              throw Exception.SyntaxError
            }

            state = S.IGNORE_SPACES
            next = S.WAIT_END_RET
            continue
          }
        case S.COMMENT:
          if c == "-" && str[p+1] == "-" && str[p+2] == ">" {
            parent.appendChild(document!.createComment(str.substr(start, p - start)))
            p += 2
            state = S.BEGIN
          }
        case S.DOCTYPE:
          if c == "[" {
            nbrackets++
          }
          else if c == "]" {
            nbrackets--
          }
          else if c == "<" && nbrackets == 0 {
            parent.appendChild(try document!.implementation.createDocumentType(str.substr(start, p - start), "", ""))
            state = S.BEGIN
          }
        case S.PI_TARGET:
          if !isValidChar(c) {
            p++
            aname = str.substr(start + 1, p - start - 2)
            start = p - 1
            state = S.IGNORE_SPACES
            next = S.PI_DATA
          }
        case S.PI_DATA:
          if c == "?" && str[p+1] == ">" {
            p++
            let s = str.substr(start + 1, p - start - 2)
            parent.appendChild(try document!.createProcessingInstruction(aname!, s))
            state = S.BEGIN
          }
        case S.ENTITY:
          if c == ";" {
            let s = str.substr(start, p - start)
            if s[0] == "#" {
              var i: UInt
              if s[1] == "x" {
                i = strtoul(s.substr(1, s.length() - 1), nil, 16)
              }
              else {
                let tmp = UInt(s.substr(1, s.length() - 1))
                if tmp == nil {
                  throw Exception.SyntaxError
                }
                i = tmp!
              }
              buf.append(UnicodeScalar(Int(i)))
            }
            else if self.escapes[s] == nil {
              throw Exception.SyntaxError
            }
            else {
              buf += self.escapes[s]!
            }
          }
      }
      p++
      c = str[p]
    }

    if state == S.BEGIN {
      start = p
      state = S.PCDATA
    }

    if state == S.PCDATA {
      if p != start || nsubs == 0 {
        parent.appendChild(document!.createTextNode(buf + str.substr(start, p - start)))
      }
      return p
    }

    throw Exception.SyntaxError
  }

  internal func isValidChar(scalar: UnicodeScalar) -> Bool {
    let value = scalar.value
    if (value >= 65 && value <= 90) || (value >= 97 && value <= 122) {return true}
    if (value >= 48 && value <= 57) {return true}
    if scalar == ":" || scalar == "." || scalar == "_" || scalar == "-" { return true }
    return false
  }
}
