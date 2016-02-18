OBJDIR              = $(TOPSRCDIR)/bin
SWIFT               = $(shell xcrun -f swiftc)
PLATFORM            = macosx
SDK_PATH            = $(shell xcrun --show-sdk-path -sdk $(PLATFORM))

CFLAGS       = -g -Onone
LD           = $(shell xcrun -f ld)
LDFLAGS      = -syslibroot $(SDK_PATH) -lSystem -arch $(ARCH) \
							 -macosx_version_min 10.10.0 \
							 -no_objc_category_merging -L $(TOOLCHAIN_PATH) \
							 -rpath $(TOOLCHAIN_PATH)

build: $(SOURCES) $(DIRS)
ifdef DIRS
		@for d in $(DIRS); do (cd $$d; $(MAKE) build ); done
endif
		$(shell mkdir -p $(OBJDIR)/modules)
ifdef MODULE_NAME
ifdef SOURCES
		$(SWIFT) $(SOURCES) -emit-module -module-name $(MODULE_NAME) -emit-module-path $(OBJDIR)/modules/$(MODULE_NAME).swiftmodule -I $(OBJDIR)/modules -sdk $(SDK_PATH)
else
		$(SWIFT) *.swift -emit-module -module-name $(MODULE_NAME) -emit-module-path $(OBJDIR)/modules/$(MODULE_NAME).swiftmodule -sdk $(SDK_PATH)
endif
endif

clean:
		$(shell rm -fr $(OBJDIR)/modules/$(MODULE_NAME).*)
ifdef DIRS
		@for d in $(DIRS); do (cd $$d; $(MAKE) clean ); done
endif


clobber:
		$(shell rm -fr $(OBJDIR))

