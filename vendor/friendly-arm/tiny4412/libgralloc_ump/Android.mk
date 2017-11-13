LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),tiny4412)
ifeq (,$(wildcard vendor/friendly-arm/tiny4412/libgralloc_ump.dev))

include $(CLEAR_VARS)
LOCAL_MODULE := gralloc.tiny4412
LOCAL_MODULE_OWNER := friendly-arm
LOCAL_SRC_FILES := gralloc.tiny4412.so
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT)/lib/hw
include $(BUILD_PREBUILT)

endif
endif
