TARGET=:clang
include theos/makefiles/common.mk

TWEAK_NAME = QuickCarrot
QuickCarrot_OBJC_FILES = QuickCarrot.xm
QuickCarrot_FRAMEWORKS = Foundation UIKit
QuickCarrot_LDFLAGS = -lactivator -Ltheos/lib

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
