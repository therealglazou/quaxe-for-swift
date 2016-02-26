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
}
