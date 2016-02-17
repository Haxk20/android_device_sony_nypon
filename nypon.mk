#
# Copyright (C) 2014 Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit the proprietary counterpart
$(call inherit-product-if-exists, vendor/sony/nypon/nypon-vendor.mk)

# Overlays
DEVICE_PACKAGE_OVERLAYS += device/sony/nypon/overlay

# Target device Specific headers
TARGET_SPECIFIC_HEADER_PATH += device/sony/nypon/include

# Inherit the montblanc-common definitions
$(call inherit-product, device/sony/montblanc-common/montblanc.mk)

# Inhert vendor proprietary files
$(call inherit-product-if-exists, vendor/sony/nypon/nypon-vendor.mk)

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.google.android.nfc_extras.xml

# This device is xhdpi.  However the platform doesn't
# currently contain all of the bitmaps at xhdpi density so
# we do this little trick to fall back to the hdpi version
# if the xhdpi doesn't exist.
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xhdpi
PRODUCT_AAPT_PREBUILT_DPI := xhdpi

# Configuration scripts
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/config/fstab.st-ericsson:root/fstab.st-ericsson \
   $(LOCAL_PATH)/config/init.st-ericsson.device.rc:root/init.st-ericsson.device.rc \
   $(LOCAL_PATH)/prebuilt/logo-540x960.rle:root/logo.rle

# Configuration scripts
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/prebuilt/hw_config.sh:system/etc/hw_config.sh

# USB function switching
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/config/init.st-ericsson.usb.rc:root/init.st-ericsson.usb.rc

#TWRP
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/config/twrp.fstab:recovery/root/etc/twrp.fstab \
   $(LOCAL_PATH)/config/init.recovery.st-ericsson.rc:root/init.recovery.st-ericsson.rc

# Media Profiles
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/config/media_profiles.xml:system/etc/media_profiles.xml

# Key layouts and touchscreen
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/config/AB8500_Hs_Button.kl:system/usr/keylayout/AB8500_Hs_Button.kl \
   $(LOCAL_PATH)/config/simple_remote.kl:system/usr/keylayout/simple_remote.kl \
   $(LOCAL_PATH)/config/so34-buttons.kl:system/usr/keylayout/so34-buttons.kl \
   $(LOCAL_PATH)/config/STMPE-keypad.kl:system/usr/keylayout/STMPE-keypad.kl \
   $(LOCAL_PATH)/config/tc3589x-keypad.kl:system/usr/keylayout/tc3589x-keypad.kl \
   $(LOCAL_PATH)/config/ux500-ske-keypad.kl:system/usr/keylayout/ux500-ske-keypad.kl \
   $(LOCAL_PATH)/config/ux500-ske-keypad-qwertz.kl:system/usr/keylayout/ux500-ske-keypad-qwertz.kl \
   $(LOCAL_PATH)/config/sensor00_f11_sensor0.idc:system/usr/idc/sensor00_f11_sensor0.idc \
   $(LOCAL_PATH)/config/synaptics_rmi4_i2c.idc:system/usr/idc/synaptics_rmi4_i2c.idc

# Misc configuration files
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/config/button_light_curve.cfg:system/etc/button_light_curve.cfg \
   $(LOCAL_PATH)/config/cflashlib.cfg:system/etc/cflashlib.cfg \
   $(LOCAL_PATH)/config/flashled_param_config.cfg:system/etc/flashled_param_config.cfg \
   $(LOCAL_PATH)/config/dash.conf:system/etc/dash.conf

# patched JB cn_binary
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/config/cn_server:system/bin/cn_server

# Android kind of memory
PRODUCT_CHARACTERISTICS := nosdcard

# PC Companion kind of memory
PRODUCT_PROPERTY_OVERRIDES += ro.semc.product.user_storage=emmc_only

# Hardware video codecs configurations
PRODUCT_PROPERTY_OVERRIDES += \
	ste.video.decoder.max.hwmem=0x2600000 \
	ste.video.decoder.max.res=720p \
	ste.video.decoder.h264.max.lev=3.2

# Device density
PRODUCT_PROPERTY_OVERRIDES += \
	ro.sf.lcd_density=240

# Dalvik
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapstartsize=5m \
    dalvik.vm.heapgrowthlimit=48m \
    dalvik.vm.heapsize=128m \
    dalvik.vm.heaptargetutilization=0.75 \
    dalvik.vm.heapminfree=1m \
    dalvik.vm.heapmaxfree=2m

# Low-RAM optimizations
PRODUCT_PROPERTY_OVERRIDES += \
	ro.config.low_ram=true \
	persist.sys.force_highendgfx=true \
	dalvik.vm.jit.codecachesize=0 \
	ro.config.max_starting_bg=8 \
	ro.sys.fw.bg_apps_limit=16 \
	config.disable_atlas=true

#Trim properties
ro.sys.fw.trim_enable_memory=805306368
ro.sys.fw.bservice_enable=true
ro.sys.fw.trim_empty_percent=50
ro.sys.fw.trim_cache_percent=50
ro.sys.fw.bservice_limit=3
ro.sys.fw.bservice_age=3000
ro.sys.fw.empty_app_percent=25
