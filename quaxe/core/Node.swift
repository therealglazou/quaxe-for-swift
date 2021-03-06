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
 * https://dom.spec.whatwg.org/#interface-node
 * 
 * status: done
 */
public class Node: EventTarget, pNode {

  static let ELEMENT_NODE: ushort                 = 1;
  static let ATTRIBUTE_NODE: ushort               = 2; // historical
  static let TEXT_NODE: ushort                    = 3;
  static let CDATA_SECTION_NODE: ushort           = 4; // historical
  static let ENTITY_REFERENCE_NODE: ushort        = 5; // historical
  static let ENTITY_NODE: ushort                  = 6; // historical
  static let PROCESSING_INSTRUCTION_NODE: ushort  = 7;
  static let COMMENT_NODE: ushort                 = 8;
  static let DOCUMENT_NODE: ushort                = 9;
  static let DOCUMENT_TYPE_NODE: ushort           = 10;
  static let DOCUMENT_FRAGMENT_NODE: ushort       = 11;
  static let NOTATION_NODE: ushort                = 12; // historical

  internal var mNodeType: ushort = 1
  internal var mOwnerDocument: pDocument?
  internal var mParentNode: pNode?
  internal var mFirstChild: pNode?
  internal var mLastChild: pNode?
  internal var mPreviousSibling: pNode?
  internal var mNextSibling: pNode?

  internal func _getTextContent(_ n: pNode?) -> DOMString {
    var node = n
    var rv = ""
    while nil != node {
      switch nodeType {
        case Node.DOCUMENT_FRAGMENT_NODE,
             Node.ELEMENT_NODE:
          rv += _getTextContent(self.firstChild)
        case Node.TEXT_NODE,
             Node.PROCESSING_INSTRUCTION_NODE,
             Node.COMMENT_NODE:
          rv += (self as! pCharacterData).data
        default: break;
      }
      node = node!.nextSibling
    }
    return rv
  }

  internal func getCounts(_ elementCount: inout UInt, _ textCount: inout UInt) -> Void {
    var child = firstChild
    elementCount = 0
    textCount = 0
    while nil != child {
      switch child!.nodeType {
        case Node.ELEMENT_NODE: elementCount += 1
        case Node.TEXT_NODE:    textCount += 1
        default: break;
      }
      child = child!.nextSibling
    }
  }

  internal func getChildCount() -> UInt {
    var child = firstChild
    var count: UInt = 0
    while nil != child {
      count += 1
      child = child!.nextSibling
    }
    return count
  }

  internal func hasFollowingDoctype() -> Bool {
    var child = self.nextSibling
    while nil != child {
      switch child!.nodeType {
        case Node.DOCUMENT_TYPE_NODE: return true
        default: break;
      }
      child = child!.nextSibling
    }
    return false
  }

  internal func hasPrecedingElement() -> Bool {
    var child = self.previousSibling
    while nil != child {
      switch child!.nodeType {
        case Node.ELEMENT_NODE: return true
        default: break;
      }
      child = child!.previousSibling
    }
    return false
  }

  internal func hasDoctypeChild() -> Bool {
    var child = self.firstChild
    while nil != child {
      switch child!.nodeType {
        case Node.DOCUMENT_TYPE_NODE: return true
        default: break;
      }
      child = child!.nextSibling
    }
    return false
  }

  override internal func getParent(_ event: Event) -> EventTarget? {
    return self.parentNode as? EventTarget
  }

  /**
   * https://dom.spec.whatwg.org/#dom-node-nodetype
   */
  public var nodeType: ushort { return mNodeType }

  /**
   * https://dom.spec.whatwg.org/#dom-node-nodename
   */
  public var nodeName: DOMString {
    switch nodeType {
      case Node.ELEMENT_NODE:
        return (self as! pElement).tagName
      case Node.TEXT_NODE:
        return "#text"
      case Node.PROCESSING_INSTRUCTION_NODE:
        return (self as! pProcessingInstruction).target
      case Node.COMMENT_NODE:
        return "#comment"
      case Node.DOCUMENT_NODE:
        return "#document"
      case Node.DOCUMENT_TYPE_NODE:
        return (self as! pDocumentType).name
      case Node.DOCUMENT_FRAGMENT_NODE:
        return "#document-fragment"
      default: return "" // should never happen in DOM 4
    }
  }

  /**
   * https://dom.spec.whatwg.org/#dom-node-baseuri
   */
  public var baseURI: DOMString { return "about:blank" }

  /**
   * https://dom.spec.whatwg.org/#dom-node-ownerdocument
   */
  public var ownerDocument: pDocument? {
    if Node.DOCUMENT_NODE == nodeType {
      return nil
    }
    return mOwnerDocument
  }

  /**
   * https://dom.spec.whatwg.org/#dom-node-parentnode
   */
  public var parentNode: pNode? { return mParentNode }

  /**
   * https://dom.spec.whatwg.org/#dom-node-parentelement
   */
  public var parentElement: pElement? {
    if let pe = mParentNode as? pElement {
      return pe
    }
    return nil
  }

  /**
   * https://dom.spec.whatwg.org/#dom-node-haschildnodes
   */
  public func hasChildNodes() -> Bool {
    return nil != self.firstChild
  }

  /**
   * https://dom.spec.whatwg.org/#dom-node-childnodes
   */
  public var childNodes: pNodeList {
    let list = NodeList()
    var child = self.firstChild
    while nil != child {
      list.mNodeArray.append(child!)
      child = child!.nextSibling
    }
    return list
  }

  /**
   * https://dom.spec.whatwg.org/#dom-node-firstchild
   * https://dom.spec.whatwg.org/#dom-node-lastchild
   * https://dom.spec.whatwg.org/#dom-node-previoussibling
   * https://dom.spec.whatwg.org/#dom-node-nextsibling
   */
  public var firstChild: pNode? { return mFirstChild }
  public var lastChild: pNode? { return mLastChild }
  public var previousSibling: pNode? { return mPreviousSibling }
  public var nextSibling: pNode? { return mNextSibling }

  /**
   * https://dom.spec.whatwg.org/#dom-node-nodevalue
   */
  public var nodeValue: DOMString? {
    get {
      switch nodeType {
        case Node.TEXT_NODE,
             Node.PROCESSING_INSTRUCTION_NODE,
             Node.COMMENT_NODE:
          return (self as! pCharacterData).data
        default: return nil
      }
    }
    set {
      let n: DOMString = (nil == newValue) ? "" : newValue!
      switch nodeType {
        case Node.TEXT_NODE,
             Node.PROCESSING_INSTRUCTION_NODE,
             Node.COMMENT_NODE:
          var characterData = (self as! pCharacterData)
          characterData.data = n
        default: break;
      }
    }
  }

  /**
   * https://dom.spec.whatwg.org/#dom-node-textcontent
   */
  public var textContent: DOMString? {
    get {
      switch nodeType {
        case Node.DOCUMENT_FRAGMENT_NODE,
             Node.ELEMENT_NODE:
          return _getTextContent(self.firstChild)
        case Node.TEXT_NODE,
             Node.PROCESSING_INSTRUCTION_NODE,
             Node.COMMENT_NODE:
          return (self as! pCharacterData).data
        default: return nil
      }
    }
    set {
      let n: DOMString = (nil == newValue) ? "" : newValue!
      switch nodeType {
        case Node.DOCUMENT_FRAGMENT_NODE,
             Node.ELEMENT_NODE:
          var node: pNode? = nil
          if !n.isEmpty {
            node = Text(n)
          }
          // XXX we are force to ignore if replaceAll() throws because
          // Swift computed properties don't allow to throw yet...
          let _ = try? MutationAlgorithms.replaceAll(node as? Node, self)
        case Node.TEXT_NODE,
             Node.PROCESSING_INSTRUCTION_NODE,
             Node.COMMENT_NODE:
          let characterData = (self as! CharacterData)
          // XXX we are force to ignore if replaceAll() throws because
          // Swift computed properties don't allow to throw yet...
          let _ = try? CharacterData._replaceData(characterData, 0, characterData.length, n)
        default: break;
      }
      // TODO
    }
  }

  /*
   * https://dom.spec.whatwg.org/#dom-node-normalize
   */
  public func normalize() throws -> Void {
    var node = self.firstChild
    while node != nil {
      switch (node!.nodeType) {
        case Node.TEXT_NODE:
          // Step 2
          var length = (node as! Text).length
          if 0 == length {
            // Step 3
            MutationAlgorithms.remove(node as! Node, node!.parentNode as! Node)
          }
          else {
            // Step 4
            var data: DOMString = (node as! Text).data
            var child = node!.nextSibling
            while nil != child && child!.nodeType == Node.TEXT_NODE {
              data += (child as! Text).data
              child = child!.nextSibling
            }

            // Step 5
            try CharacterData._replaceData(node as! CharacterData, length, 0, data)

            // Step 6
            var currentNode = node!.nextSibling

            // Step 7
            let rangeCollection = ((node as! Node).ownerDocument as! Document).rangeCollection
            while nil != currentNode && currentNode!.nodeType == Node.TEXT_NODE {
              // Step 7.1
              rangeCollection.forEach( {
                if $0.value!.startContainer as! Node === currentNode as! Node {
                  $0.value!.setStart(node!, $0.value!.startOffset + length);
                }
              })

              // Step 7.2
              rangeCollection.forEach( {
                if $0.value!.endContainer as! Node === currentNode as! Node {
                  $0.value!.setEnd(node!, $0.value!.endOffset + length);
                }
              })

              // Step 7.3
              rangeCollection.forEach( {
                if $0.value!.startContainer as! Node === currentNode!.parentNode as! Node &&
                   $0.value!.startOffset == Trees.indexOf(currentNode as! Node) {
                  $0.value!.setStart(node!, length);
                }
              })

              // Step 7.4
              rangeCollection.forEach( {
                if $0.value!.endContainer as! Node === currentNode!.parentNode as! Node &&
                   $0.value!.endOffset == Trees.indexOf(currentNode as! Node) {
                  $0.value!.setStart(node!, length);
                }
              })

              // Step 7.5
              length += (currentNode as! Text).length

              // Step 7.6
              currentNode = currentNode!.nextSibling
            }

            // Step 8
            var textNode = node!.nextSibling
            while nil != textNode && textNode!.nodeType == Node.TEXT_NODE {
              let tmp = textNode!.nextSibling
              MutationAlgorithms.remove(textNode as! Node, textNode!.parentNode as! Node)
              textNode = tmp
            }
          }
        case Node.ELEMENT_NODE:
          try node!.normalize()
        default: break
      }
      node = node!.nextSibling as? Node
    }
  }

  /**
   * https://dom.spec.whatwg.org/#concept-node-clone
   */
  internal func _clone(_ d: pDocument? = nil, _ cloneChildrenFlag: Bool = false) -> Node {
    var document = d
    // Step 1
    if nil == document {
      document = self.ownerDocument
    }

    // Step 2
    var copy: Node?
    switch self.nodeType {
      case Node.DOCUMENT_NODE:
        let d = Document()
        d.mInputEncoding = (self as! Document).inputEncoding
        d.mContentType = (self as! Document).contentType
        d.mURL = (self as! Document).URL
        d.type = (self as! Document).type
        d.mMode = (self as! Document).mMode
        copy = d
      case Node.DOCUMENT_TYPE_NODE:
        let dt = DocumentType((self as! DocumentType).name,
                              (self as! DocumentType).publicId,
                              (self as! DocumentType).systemId)
        copy = dt
      case Node.ELEMENT_NODE:
        let e = Element()
        e.mNamespaceURI = (self as! Element).namespaceURI
        e.mPrefix = (self as! Element).prefix
        e.mLocalName = (self as! Element).localName

        let attributes = (self as! Element).attributes
        for attributeIndex in 0...attributes.length-1 {
          var a = attributes.item(attributeIndex)
          do {
            try e.setAttributeNS(a!.namespaceURI, a!.localName, a!.value)
          }
          catch _ {}
        }
        copy = e
      case Node.TEXT_NODE:
        copy = Text((self as! Text).data)
      case Node.COMMENT_NODE:
        copy = Comment((self as! Comment).data)
      case Node.PROCESSING_INSTRUCTION_NODE:
        copy = ProcessingInstruction((self as! ProcessingInstruction).target,
                                     (self as! ProcessingInstruction).data)
      default: break
    }

    // Step 3
    if Node.DOCUMENT_NODE == copy!.nodeType {
      copy!.mOwnerDocument = copy as? pDocument
      document = copy as? pDocument
    }
    else {
      copy!.mOwnerDocument = document
    }

    // Step 4, clonig steps
    // TODO

    // Step 5
    if cloneChildrenFlag {
      var child = self.firstChild
      while nil != child {
        Trees.append((child as! Node)._clone(document, cloneChildrenFlag), copy!)
        child = child!.nextSibling
      }
    }

    // Step 6
    return copy!
  }

  /**
   * https://dom.spec.whatwg.org/#dom-node-clonenode
   */
  public func cloneNode(_ deep: Bool = false) -> pNode {
    // Step 1
    // IGNORED, we don't implement Shadow DOM

    // Step 2
    return self._clone(nil, true)
  }

  /**
   * https://dom.spec.whatwg.org/#dom-node-isequalnode
   */
  public func isEqualNode(_ otherNode: pNode?) -> Bool {
    if nil != otherNode &&
       self === otherNode as! Node {
      return true
    }
    return false
  }

  static let DOCUMENT_POSITION_DISCONNECTED: ushort = 0x01
  static let DOCUMENT_POSITION_PRECEDING: ushort = 0x02
  static let DOCUMENT_POSITION_FOLLOWING: ushort = 0x04
  static let DOCUMENT_POSITION_CONTAINS: ushort = 0x08
  static let DOCUMENT_POSITION_CONTAINED_BY: ushort = 0x10
  static let DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC: ushort = 0x20

  /**
   * https://dom.spec.whatwg.org/#dom-node-comparedocumentposition
   */
  public func compareDocumentPosition(_ other: pNode) -> ushort {
    // Step 1
    let reference = self

    // Step 2
    if other as! Node === reference {
      return 0
    }

    // Step 3
    if self.ownerDocument as? Document !== other.ownerDocument as? Document {
      return  Node.DOCUMENT_POSITION_DISCONNECTED
              | Node.DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC
              | Node.DOCUMENT_POSITION_PRECEDING
    }

    // Step 4
    if Trees.isAncestorOf(other as! Node, reference) {
      return  Node.DOCUMENT_POSITION_CONTAINS
              | Node.DOCUMENT_POSITION_PRECEDING
    }

    // Step 5
    if Trees.isDescendantOf(other as! Node, reference) {
      return  Node.DOCUMENT_POSITION_CONTAINED_BY
              | Node.DOCUMENT_POSITION_FOLLOWING
    }

    // Step 6
    var referenceAncestors: Array<Node> = []
    var parent = reference.parentNode
    while nil != parent {
      referenceAncestors.append(parent as! Node)
      parent = parent!.parentNode
    }

    var otherAncestors: Array<Node> = []
    parent = other.parentNode
    while nil != parent {
      otherAncestors.append(parent as! Node)
      parent = parent!.parentNode
    }

    var index = 1;
    while referenceAncestors[referenceAncestors.count - index] === otherAncestors[otherAncestors.count - index] {
      index += 1
    }
    if Trees.isPreceding(otherAncestors[otherAncestors.count - index], referenceAncestors[referenceAncestors.count - index]) {
      return Node.DOCUMENT_POSITION_PRECEDING
    }

    return Node.DOCUMENT_POSITION_FOLLOWING
  }

  /**
   * https://dom.spec.whatwg.org/#dom-node-contains
   */
  public func contains(_ other: pNode?) -> Bool {
    return (nil != other && Trees.isInclusiveDescendantOf(other as! Node, self))
  }

  /*
   * https://dom.spec.whatwg.org/#locate-a-namespace-prefix
   */
  static func locateNamespacePrefix(_ elt: Element, _ ns: DOMString) -> DOMString? {
    // Step 1
    if elt.namespaceURI == ns && elt.prefix != nil {
      return elt.prefix!
    }

    // Step 2
    for attr in (elt.attributes as! NamedNodeMap).mAttributes {
      if attr.prefix == "xmlns" &&
         attr.value == ns {
        return attr.localName
      }
    }

    // Step 3
    if elt.parentNode != nil {
      return locateNamespacePrefix(elt.parentNode as! Element, ns)
    }

    // Step 4
    return nil
  }

  /*
   * https://dom.spec.whatwg.org/#dom-node-lookupprefix
   */
  public func lookupPrefix(_ ns: DOMString?) -> DOMString? {
    // step 1
    if nil == ns || "" == ns {
      return nil
    }

    // step 2
    switch self.nodeType {
      case Node.ELEMENT_NODE:
        return Node.locateNamespacePrefix(self as! Element, ns!)
      case Node.DOCUMENT_NODE:
        let docElt = (self as! Document).documentElement
        if nil != docElt {
          return Node.locateNamespacePrefix(docElt as! Element, ns!)
        }
        return nil
      case Node.DOCUMENT_TYPE_NODE,
           Node.DOCUMENT_FRAGMENT_NODE:
        return nil
      case Node.ATTRIBUTE_NODE:
        let elt = (self as! Attr).mOwnerElement
        if nil != elt {
          return Node.locateNamespacePrefix(elt!, ns!)
        }
        return nil
      default:
        let parent = self.parentNode
        if nil != parent {
          return Node.locateNamespacePrefix(parent as! Element, ns!)
        }
        return nil
    }
  }

  /*
   * https://dom.spec.whatwg.org/#locate-a-namespace
   */
  static func locateNamespace(_ node: Node, _ prefix: DOMString?) -> DOMString? {
    switch node.nodeType {
      case Node.ELEMENT_NODE:
        let elt = node as! Element
        // Step 1.1
        if nil != elt.namespaceURI && prefix == elt.prefix {
          return elt.namespaceURI
        }

        // Step 1.2
        var value: DOMString? = ""
        if nil != prefix &&
           elt.hasAttributeNS(Namespaces.XMLNS_NAMESPACE, prefix!) {
          value = elt.getAttributeNS(Namespaces.XMLNS_NAMESPACE, prefix!)
        }
        else if nil == prefix &&
                elt.hasAttributeNS(Namespaces.XMLNS_NAMESPACE, "xmlns") {
          value = elt.getAttributeNS(Namespaces.XMLNS_NAMESPACE, "xmlns")
        }
        if "" != value {
          return value
        }

        // Step 1.3
        if nil == node.parentNode {
          return nil
        }

        // Step 1.4
        return locateNamespace(node.parentNode as! Node, prefix)

      case Node.DOCUMENT_NODE:
        // Step 2.1
        let elt = (node as! Document).documentElement
        if nil == elt {
          return nil
        }
        // Step 2.2
        return locateNamespace(elt as! Node, prefix)

      case Node.DOCUMENT_TYPE_NODE,
           Node.DOCUMENT_FRAGMENT_NODE:
        return nil

      case Node.ATTRIBUTE_NODE:
        // Step 3.1
        let elt = (node as! Attr).ownerElement
        if nil == elt {
          return nil
        }
        // Step 3.2
        return locateNamespace(elt as! Node, prefix)

      default:
        // Step 4.3
        if nil == node.parentNode {
          return nil
        }

        // Step 4.4
        return locateNamespace(node.parentNode as! Node, prefix)
        
    }
  }

  /*
   * https://dom.spec.whatwg.org/#dom-node-lookupnamespaceuri
   */
  public func lookupNamespaceURI(_ prefix: DOMString?) -> DOMString? {
    // Step 1
    if nil == prefix || "" == prefix {
      return nil
    }

    // Step 2
    return Node.locateNamespace(self, prefix)
  }

  /*
   * https://dom.spec.whatwg.org/#dom-node-isdefaultnamespace
   */
  public func isDefaultNamespace(_ ns: DOMString?) -> Bool {
    // Step 1
    var namespace = ns;
    if "" == namespace {
      namespace = nil
    }

    // Step 2
    let defaultNamespace = Node.locateNamespace(self, nil)

    // Step 3
    return defaultNamespace == namespace
  }

  /*
   * https://dom.spec.whatwg.org/#dom-node-insertbefore
   */
  public func insertBefore(_ node: pNode, _ child: pNode?) throws -> pNode {
    return try MutationAlgorithms.preInsert(node as! Node, self, child as? Node)
  }

  /*
   * https://dom.spec.whatwg.org/#dom-node-appendchild
   */
  @discardableResult public func appendChild(_ node: pNode) throws -> pNode {
    return try MutationAlgorithms.append(node as! Node, self)
  }

  /*
   * https://dom.spec.whatwg.org/#dom-node-replacechild
   */
  public func replaceChild(_ node: pNode, _ child: pNode) throws -> pNode {
    return try MutationAlgorithms.replace(node as! Node, child as! Node, self)
  }

  /*
   * https://dom.spec.whatwg.org/#dom-node-removechild
   */
  public func removeChild(_ child: pNode) throws -> pNode {
    return try MutationAlgorithms.preRemove(child as! Node, self)
  }


  override init() {
  }
}
