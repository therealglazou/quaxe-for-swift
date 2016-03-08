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

enum Exception: ErrorType {
  case IndexSizeError
  case HierarchyRequestError
  case NotFoundError
  case InvalidCharacterError
  case InvalidStateError
  case NamespaceError
  case NotSupportedError

  case CDATADeclarationExpected
  case DOCTYPEDeclarationExpected
  case COMMENTDeclarationExpected
  case NODE_NAMEDeclarationExpected
  case ATTRIBUTE_NAMEDeclarationExpected
  case SyntaxError
}
