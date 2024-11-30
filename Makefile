THEOS_DEVICE_IP = 192.168.1.9 -p 22
#TARGET = iphone:clang:latest:13.0
ARCHS = arm64 
#THEOS_PACKAGE_SCHEME = rootless

GO_EASY_ON_ME = 1
FINALPACKAGE = 1
STRIP = :
DEBUG = 0
THEOS = /var/mobile/theos
IGNORE_WARNINGS = 0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AOV

$(TWEAK_NAME)_CCFLAGS = -std=c++11 -fno-rtti -fno-exceptions -DNDEBUG
$(TWEAK_NAME)_CFLAGS += -fobjc-arc
$(TWEAK_NAME)_FILES = Tweak.xm $(shell find SCLAlertView -name '*.m')
$(TWEAK_NAME)_LDFLAGS+= 
$(TWEAK_NAME)_FRAMEWORKS = UIKit Foundation Security QuartzCore CoreGraphics CoreText CoreData CoreLocation CoreMotion CoreBluetooth CoreImage CoreML ARKit Metal WebKit GameController AdSupport UserNotifications StoreKit GameKit AVFoundation MobileCoreServices CoreTelephony SystemConfiguration MediaPlayer AddressBook MessageUI ReplayKit AuthenticationServices LocalAuthentication Accounts MapKit AppTrackingTransparency MetricKit AudioToolbox CoreMedia IOKit GraphicsServices

LIBRARIES += substrate mobilesubstrate

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 kgvn || :"
	@rm -rf $(OBJDIR) $(THEOS_OBJ_DIR)
