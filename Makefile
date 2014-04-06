THEOS_PACKAGE_DIR_NAME = debs
TARGET = :clang
ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk

TWEAK_NAME = QuickCarrot
QuickCarrot_FILES = QuickCarrot.xm
QuickCarrot_FRAMEWORKS = Foundation UIKit
QuickCarrot_LDFLAGS = -lactivator -Ltheos/lib

include $(THEOS_MAKE_PATH)/tweak.mk

internal-after-install::
	install.exec "killall -9 backboardd"
