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

LOCAL_PATH := $(call my-dir)

TARGET_OUT_FIRMWARE = $(TARGET_OUT_ETC)/firmware
TARGET_OUT_KMODULES = $(TARGET_OUT)/lib/modules
TARGET_OUT_BUSYBOX = $(TARGET_OUT)/busybox
TARGET_OUT_GAPPS = $(TARGET_OUT)


#############################################
# Install driver firmware from tarred file

include $(CLEAR_VARS)
LOCAL_MODULE := prebuilt.firmware
LOCAL_MODULE_CLASS := FAKE
LOCAL_MODULE_TAGS := optional

include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE) : $(LOCAL_PATH)/firmware.tgz
	@echo "Unzip $(TARGET_OUT_FIRMWARE) <- $<"
	$(hide) rm -rf $(TARGET_OUT_FIRMWARE) && mkdir -p $(dir $(TARGET_OUT_FIRMWARE))
	$(hide) tar -C $(dir $(TARGET_OUT_FIRMWARE)) -zxf $<
	$(hide) mkdir -p $(dir $@) && touch $@


#############################################
# Install kernel module from tarred file

include $(CLEAR_VARS)
LOCAL_MODULE := prebuilt.kmodules
LOCAL_MODULE_CLASS := FAKE
LOCAL_MODULE_TAGS := optional

include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE) : $(LOCAL_PATH)/kernel-modules.tgz
	@echo "Unzip $(TARGET_OUT_KMODULES) <- $<"
	$(hide) rm -rf $(TARGET_OUT_KMODULES) && mkdir -p $(dir $(TARGET_OUT_KMODULES))
	$(hide) tar -C $(dir $(TARGET_OUT_KMODULES)) -zxf $<
	$(hide) mkdir -p $(dir $@) && touch $@


#############################################
# Install busybox from tarred file

include $(CLEAR_VARS)
LOCAL_MODULE := prebuilt.busybox
LOCAL_MODULE_CLASS := FAKE
LOCAL_MODULE_TAGS := optional

include $(BUILD_SYSTEM)/base_rules.mk
built_module := $(LOCAL_BUILT_MODULE)

$(LOCAL_BUILT_MODULE) : $(LOCAL_PATH)/busybox-bin.tgz
	@echo "Unzip $(TARGET_OUT_BUSYBOX) <- $<"
	$(hide) rm -rf $(TARGET_OUT_BUSYBOX) && mkdir -p $(dir $(TARGET_OUT_BUSYBOX))
	$(hide) tar -C $(dir $(TARGET_OUT_BUSYBOX)) -zxf $<
	$(hide) mkdir -p $(dir $@) && touch $@

#############################################
# Install gapps 

include $(CLEAR_VARS)
LOCAL_MODULE := prebuilt.gapps
LOCAL_MODULE_CLASS := FAKE
LOCAL_MODULE_TAGS := optional

include $(BUILD_SYSTEM)/base_rules.mk
built_module := $(LOCAL_BUILT_MODULE)

$(LOCAL_BUILT_MODULE) : $(LOCAL_PATH)/gapps-system.tgz
	@echo "Install gapps  <- $<"
	$(hide) tar -C $(TARGET_OUT_GAPPS) -zxf $<
	$(hide) mkdir -p $(dir $@) && touch $@

#############################################
# Install FriendlyARM apps 

include $(CLEAR_VARS)
LOCAL_MODULE := prebuilt.faapps
LOCAL_MODULE_CLASS := FAKE
LOCAL_MODULE_TAGS := optional

include $(BUILD_SYSTEM)/base_rules.mk
built_module := $(LOCAL_BUILT_MODULE)

$(LOCAL_BUILT_MODULE) : $(LOCAL_PATH)/faapps-system.tgz
	@echo "Install fa apps  <- $<"
	$(hide) tar -C $(TARGET_OUT_GAPPS) -zxf $<
	$(hide) mkdir -p $(dir $@) && touch $@


#############################################
# Install prebuilt libraries

define add-friendlyarm-file
    $(eval $(include-friendlyarm-file))
endef

define include-friendlyarm-file
	include $$(CLEAR_VARS)
	LOCAL_SRC_FILES := $(1)
	LOCAL_BUILT_MODULE_STEM := $(1)
	LOCAL_MODULE_SUFFIX := $$(suffix $(1))
	LOCAL_MODULE := $$(basename $(1))
	LOCAL_MODULE_CLASS := $(2)
	LOCAL_MODULE_TAGS := optional
	include $$(BUILD_PREBUILT)
endef

ifeq ($(WPA_SUPPLICANT_VERSION),VER_0_8_X)
ifeq (,$(wildcard vendor/friendly-arm/tiny4412/wifi/wpa_supplicant_8_lib))
$(call add-friendlyarm-file,$(BOARD_WPA_SUPPLICANT_PRIVATE_LIB).a,STATIC_LIBRARIES)
endif
endif


#############################################
include $(CLEAR_VARS)

include $(call all-makefiles-under,$(LOCAL_PATH))

