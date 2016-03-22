# quaxe-for-swift 2.2
Quaxe for Swift 2.2

Uses swift-makefiles from https://github.com/therealglazou/swift-makefiles as build system

    Attr.swift:                     * status: done
    CharacterData.swift:            * status: done
    ChildNode.swift:                * status: done
    Comment.swift:                  * status: done
    CustomEvent.swift:              * status: done
    DOMImplementation.swift:        * status: done
    DOMRange.swift:                 * status: done
    DOMTokenList.swift:             * status: TODO 1%
    Document.swift:                 * status: done
    DocumentFragment.swift:         * status: done
    DocumentType.swift:             * status: done
    Element.swift:                  * status: TODO 80%
    Elements.swift:                 * status: TODO 100%
    Event.swift:                    * status: done
    EventTarget.swift:              * status: done
    Exception.swift:                * status: TODO
    HTMLCollection.swift:           * status: done
    MutationAlgorithms.swift:       * status: done
    MutationUtils.swift:            * status: TODO 100%
    NamedNodeMap.swift:             * status: TODO 100%
    Namespaces.swift:               * status: done
    Node.swift:                     * status: TODO 15%
    NodeIterator.swift:             * status: TODO 100%
    NodeList.swift:                 * status: done
    NonDocumentTypeChildNode.swift: * status: done
    NonElementParentNode.swift:     * status: done
    OrderedSets.swift:              * status: done, optimize with Foundation?
    ParentNode.swift:               * status: TODO 50%, querySelector and friends
    ProcessingInstruction.swift:    * status: done
    Text.swift:                     * status: TODO 100%
    TreeWalker.swift:               * status: TODO 100%
    Trees.swift:                    * status: done

###Download and Build instructions

tested on OS X 10.11.3 and Xcode 7.2.1 (7C1002)

Quaxe now uses Swift 2.2 (XCode 7.3)

    git clone https://github.com/therealglazou/quaxe-for-swift.git
    cd quaxe-for-swift
    git clone https://github.com/therealglazou/swift-makefiles.git
    make

**warning** this is a work in progress and not ready yet; expect build horkage at any time...

`utils/Either.swift` and `utils/Combinators.swift` are (c) 2014 Maxwell Swadling and used user the BSD License (Cf. https://github.com/typelift/Swiftx)

`quaxe/core/XMLParser.swift` is (c) 2005-2012 Haxe Foundation and used under the [Haxe libraries license](http://old.haxe.org/doc/license#the-haxe-libraries-license)

###License

MPL 2.0
