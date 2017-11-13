LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),tiny4412)

include $(CLEAR_VARS)
LOCAL_MODULE := libfriendlyarm-hardware
LOCAL_MODULE_OWNER := samsung
LOCAL_SRC_FILES := libfriendlyarm-hardware.so
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT)/lib/
include $(BUILD_PREBUILT)

endif
