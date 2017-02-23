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
 * status: TODO
 */
enum Exception: ErrorType {
  case IndexSizeError
  case HierarchyRequestError
  case NotFoundError
  case InvalidCharacterError
  case InvalidNodeTypeError
  case InvalidStateError
  case NamespaceError
  case NotSupportedError
  case TypeError
  case WrongDocumentError

  case CDATADeclarationExpected
  case DOCTYPEDeclarationExpected
  case COMMENTDeclarationExpected
  case NODE_NAMEDeclarationExpected
  case ATTRIBUTE_NAMEDeclarationExpected
  case SyntaxError

  case NoModificationAllowed
}
