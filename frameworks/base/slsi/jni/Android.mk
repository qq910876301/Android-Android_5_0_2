LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
    com_slsi_sec_android_HdmiService.cpp \
    onload.cpp

LOCAL_C_INCLUDES += \
	$(JNI_H_INCLUDE)

LOCAL_SHARED_LIBRARIES := \
						  libcutils \
						  libandroid_runtime \
						  libnativehelper \
						  libbinder \
						  libutils 

ifeq ($(TARGET_HAL_PATH),)
	TARGET_HAL_PATH := device/friendly-arm/$(TARGET_BOARD_PLATFORM)
endif

LOCAL_C_INCLUDES += \
	$(TARGET_HAL_PATH)/libhdmi/libhdmiservice.next \
	$(TARGET_HAL_PATH)/include

LOCAL_SHARED_LIBRARIES += libhdmiclient
LOCAL_CFLAGS     += -DBOARD_USES_HDMI

LOCAL_PRELINK_MODULE := false

ifeq ($(TARGET_SIMULATOR),true)
ifeq ($(TARGET_OS),linux)
ifeq ($(TARGET_ARCH),x86)
LOCAL_LDLIBS += -lpthread -ldl -lrt
endif
endif
endif

ifeq ($(WITH_MALLOC_LEAK_CHECK),true)
	LOCAL_CFLAGS += -DMALLOC_LEAK_CHECK
endif

ifeq ($(TARGET_SOC),exynos4210)
LOCAL_CFLAGS += -DSAMSUNG_EXYNOS4210
endif

ifeq ($(TARGET_SOC),exynos4x12)
LOCAL_CFLAGS += -DSAMSUNG_EXYNOS4x12
endif

LOCAL_CFLAGS += -DBOARD_USES_HDMI
LOCAL_CFLAGS += -DBOARD_HDMI_STD=$(BOARD_HDMI_STD)
LOCAL_CFLAGS += -DVIDEO_DUAL_DISPLAY

LOCAL_MODULE_TAGS := optional eng
LOCAL_MODULE:= libhdmiservice_jni

include $(BUILD_SHARED_LIBRARY)

