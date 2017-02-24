
enum HtmlError : ErrorType {
  case BadLocationBOM(line: UInt)
}

class HtmlParser {

  let mScanner: HtmlScanner

  func 

  func parse(aStr: String) throws -> HTMLDocument? {
    // get a scanner
    mScanner = HtmlScanner(aStr)

    // is there a BOM as first character?
    if let c = mScanner.peek() {
      if c == "\u{feff}" {
        // yes, that's ok, let's skip it
        mScanner.read()
      }
    }

    
  }
}