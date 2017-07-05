#
# Copyright (C) 2013 The Unofficial CyanogenMod Project For Sony Xperia P [Percy Gahlot]
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

$(call inherit-product, device/sony/nypon/full_nypon.mk)


# Inherit CM common Phone stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Screen
TARGET_SCREEN_HEIGHT := 960
TARGET_SCREEN_WIDTH := 540

# Build fingerprints
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=LT22i_1262-1172 \
    PRIVATE_BUILD_DESC="LT22i-user 4.1.2 6.1.1.B.1.100 m7t3zw test-keys" \
    BUILD_FINGERPRINT="SEMC/LT22i_1262-1172/LT22i:4.1.2/6.1.1.B.1.100/m7t3zw:user/release-keys"

PRODUCT_NAME := LineageOS_nypon
PRODUCT_DEVICE := nypon
