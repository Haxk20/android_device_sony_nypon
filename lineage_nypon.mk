# Copyright (C) 2014 The Android Open Source Project
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
#
# This file is the build configuration for a full Android
# build for maguro hardware. This cleanly combines a set of
# device-specific aspects (drivers) with a device-agnostic
# product configuration (apps). Except for a few implementation
# details, it only fundamentally contains two inherit-product
# lines, full and maguro, hence its name.
#
#
 
# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

#charging animation
$(call inherit-product, device/sony/nypon/prebuilt/resources-540x960.mk)

# Inherit CM common Phone stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from nypon device
$(call inherit-product, device/sony/nypon/nypon.mk)

# Screen
TARGET_SCREEN_HEIGHT := 960
TARGET_SCREEN_WIDTH := 540
TARGET_BOOTANIMATION_HALF_RES := true

# Set those variables here to overwrite the inherited values.
PRODUCT_NAME := lineage_nypon
PRODUCT_DEVICE := nypon
PRODUCT_BRAND := Sony
PRODUCT_MANUFACTURER := Sony
PRODUCT_MODEL := Xperia P

# Build fingerprints
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=LT22i_1262-1172 \
    PRIVATE_BUILD_DESC="LT22i-user 4.1.2 6.1.1.B.1.100 m7t3zw test-keys" \
    BUILD_FINGERPRINT="SEMC/LT22i_1262-1172/LT22i:4.1.2/6.1.1.B.1.100/m7t3zw:user/release-keys"
