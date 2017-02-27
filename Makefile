
TOPSRCDIR = .
APP_NAME = main
DIRS = utils quaxe parser

APP_BUNDLE_NAME = Main

include $(TOPSRCDIR)/swiftbuild/config.mk

LIBS = -lQuaxeParser -lQuaxe -lQuaxeUtils

include $(TOPSRCDIR)/swiftbuild/rules.mk

clobber: clean
		$(shell rm -fr $(OBJDIR))

