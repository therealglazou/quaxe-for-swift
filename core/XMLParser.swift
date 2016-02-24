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
  case ESCAPE
}

public class XMLParser {

  private let NOT_WHITESPACE_ONLY_EREG = "[^\\t\\r\\n]"

  var document: Document? = nil

  var elementPrefix = ""
  var elementName: DOMString?
  var attributesArray: Array<Array<DOMString>> = []

  var escapes: Dictionary<String, String> = [
    "lt": "<",
    "gt": ">",
    "amp": "&",
    "quot": "\"",
    "apos": "'",
    "nbsp": "\u{a0}"
  ]

  public func parse(str: String) -> Document {
    self.document = Document()
    doParse(str, 0, self.document as! Node)
    return self.document!
  }

  public func doCreateElement(parent: Node?) -> Node? {
    if nil == parent ||
       self.elementName == nil ||
       self.elementName == "" {
      return parent
    }

  }
}
