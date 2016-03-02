
TOPSRCDIR = .
DIRS = utils core

include $(TOPSRCDIR)/swiftbuild/config.mk

include $(TOPSRCDIR)/swiftbuild/rules.mk

clobber: clean
		$(shell rm -fr $(OBJDIR))

