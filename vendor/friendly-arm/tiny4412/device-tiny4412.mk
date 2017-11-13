# Copyright (C) 2010 The Android Open Source Project
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

VENDOR_PATH := vendor/friendly-arm/tiny4412

# Mali
PRODUCT_PACKAGES += \
	libEGL_mali \
	libGLESv1_CM_mali \
	libGLESv2_mali \
	libMali \
	libUMP

# gralloc, ion
PRODUCT_PACKAGES += \
	libsecion \
	gralloc.tiny4412

# hwcomposer
PRODUCT_PACKAGES += \
	hwcomposer.exynos4

# HDMI
PRODUCT_PACKAGES += \
	libTVOut \
	libhdmiclient \
	sechdmiservice

# Misc other modules
PRODUCT_PACKAGES += \
	libnetcmdiface

# Prebuilts
PRODUCT_PACKAGES += \
	prebuilt.firmware \
	prebuilt.kmodules \
	prebuilt.busybox \
	prebuilt.gapps \
	prebuilt.faapps

# FriendlyARM Support
PRODUCT_COPY_FILES += \
	$(VENDOR_PATH)/proprietary/fa_codec_ctrl:system/vendor/bin/fa_codec_ctrl \
	$(VENDOR_PATH)/proprietary/sensors.tiny4412.so:system/lib/hw/sensors.tiny4412.so

ifeq ($(BOARD_USES_PWMLIGHTS),false)
PRODUCT_COPY_FILES += \
	$(VENDOR_PATH)/proprietary/lights.tiny4412.so:system/lib/hw/lights.tiny4412.so
endif

PRODUCT_PROPERTY_OVERRIDES += \
	net.eth0.startonboot=1

-include $(VENDOR_PATH)/wifi/config/config.mk

