LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := harness.c server.c vm.c
LOCAL_C_INCLUDES := $(LOCAL_PATH)

LOCAL_MODULE := harness 
LOCAL_MODULE_TAGS := optional

# Allow execution on android-16
LOCAL_CFLAGS += -pie -fPIE
LOCAL_LDFLAGS += -pie -fPIE
LOCAL_LDFLAGS += -Wl,--export-dynamic

APP_ABI := armeabi armeabi-v7a x86

include $(BUILD_STATIC_EXECUTABLE)

include $(BUILD_EXECUTABLE)

include $(call all-makefiles-under,$(LOCAL_PATH))
