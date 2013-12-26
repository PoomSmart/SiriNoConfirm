GO_EASY_ON_ME = 1
export ARCHS = armv7 armv7s arm64
include theos/makefiles/common.mk

TWEAK_NAME = SiriNoConfirm
SiriNoConfirm_FILES = SiriNoConfirm.xm
SiriNoConfirm_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
