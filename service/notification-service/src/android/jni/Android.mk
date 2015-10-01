LOCAL_PATH := $(call my-dir)

ifeq ($(strip $(ANDROID_NDK)),)
$(error ANDROID_NDK is not set!)
endif

$(warning "Current path" $(LOCAL_PATH))
$(info TC_PREFIX=$(TOOLCHAIN_PREFIX))
$(info CFLAGS=$(TARGET_CFLAGS))
$(info CXXFLAGS=$(TARGET_CXXFLAGS) $(TARGET_NO_EXECUTE_CFLAGS))
$(info CPPFLAGS=$(TARGET_CPPFLAGS))
$(info CPPPATH=$(TARGET_C_INCLUDES) $(__ndk_modules.$(APP_STL).EXPORT_C_INCLUDES))
$(info SYSROOT=$(SYSROOT_LINK))
$(info LDFLAGS=$(TARGET_LDFLAGS) $(TARGET_NO_EXECUTE_LDFLAGS) $(TARGET_NO_UNDEFINED_LDFLAGS) $(TARGET_RELRO_LDFLAGS))
$(info TC_VER=$(TOOLCHAIN_VERSION))
$(info PLATFORM=$(APP_PLATFORM))

include $(CLEAR_VARS)
OIC_LIB_PATH := ../../../../../out/android/$(TARGET_ARCH_ABI)/debug
LOCAL_MODULE := android-octbstack
LOCAL_SRC_FILES := $(OIC_LIB_PATH)/liboctbstack.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
OIC_LIB_PATH := ../../../../../out/android/$(TARGET_ARCH_ABI)/debug
LOCAL_MODULE := android-connectivity_abstraction
LOCAL_SRC_FILES := $(OIC_LIB_PATH)/libconnectivity_abstraction.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
OIC_LIB_PATH := ../../../../../out/android/$(TARGET_ARCH_ABI)/debug
LOCAL_MODULE := android-oc
LOCAL_SRC_FILES := $(OIC_LIB_PATH)/liboc.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
OIC_LIB_PATH := ../../../../../out/android/$(TARGET_ARCH_ABI)/debug
LOCAL_MODULE := rcs_client
LOCAL_SRC_FILES := $(OIC_LIB_PATH)/librcs_client.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
OIC_LIB_PATH := ../../../../../out/android/$(TARGET_ARCH_ABI)/debug
LOCAL_MODULE := rcs_server
LOCAL_SRC_FILES := $(OIC_LIB_PATH)/librcs_server.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
OIC_LIB_PATH := ../../../../../out/android/$(TARGET_ARCH_ABI)/debug
LOCAL_MODULE := rcs_common
LOCAL_SRC_FILES := $(OIC_LIB_PATH)/librcs_common.so
include $(PREBUILT_SHARED_LIBRARY)


include $(CLEAR_VARS)
OIC_LIB_PATH := ../../../../../out/android/$(TARGET_ARCH_ABI)/debug
LOCAL_MODULE := android-notification_service
LOCAL_SRC_FILES := $(OIC_LIB_PATH)/libnmservice.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE    := notification_service_jni

#Add Pre processor definitions
DEFINE_FLAG =  -DWITH_POSIX -D__ANDROID__

#Add Debug flags here
DEBUG_FLAG      = -DTB_LOG

BUILD_FLAG = $(DEFINE_FLAG) $(DEBUG_FLAG)

LOCAL_CPPFLAGS = $(BUILD_FLAG)
LOCAL_CPPFLAGS += -std=c++0x -frtti -fexceptions

$(info CPPFLAGSUPDATED=$(LOCAL_CPPFLAGS))

LOCAL_C_INCLUDES := $(LOCAL_PATH) \
					$(LOCAL_PATH)/jniutil/inc \
					$(LOCAL_PATH)/../../../../../service/notification-service/include \
					$(LOCAL_PATH)/../../../../../service/notification-service/src \
					$(LOCAL_PATH)/../../../../../service/resource-encapsulation/include \
					$(LOCAL_PATH)/../../../../../resource/csdk/logger/include \
					$(LOCAL_PATH)/../../../../../resource/csdk/connectivity/common/inc \
					$(LOCAL_PATH)/../../../../../resource/include \
					$(LOCAL_PATH)/../../../../../resource/c_common \
					$(LOCAL_PATH)/../../../../../resource/oc_logger/include \
					$(LOCAL_PATH)/../../../../../resource/csdk/ocmalloc/include \
					$(LOCAL_PATH)/../../../../../resource/csdk/connectivity/api \
					$(LOCAL_PATH)/../../../../../resource/csdk/stack/include \
					$(LOCAL_PATH)/../../../../../resource/csdk/logger/include \
					$(LOCAL_PATH)/../../../../../resource/csdk/security/include \
					$(LOCAL_PATH)/../../../../../extlibs/cjson \
					$(LOCAL_PATH)/../../../../../extlibs/boost/boost_1_58_0 \
                    $(LOCAL_PATH)/../../../../../extlibs/timer \
					$(LOCAL_PATH)/../../../../../android/android_api/base/jni \
					$(NDK_ROOT)/sources/cxx-stl/gnu-libstdc++/$(TOOLCHAIN_VERSION)/include \
                    $(NDK_ROOT)/sources/cxx-stl/gnu-libstdc++/$(TOOLCHAIN_VERSION)/libs/$(TARGET_ARCH_ABI)/include \
					
LOCAL_SRC_FILES += $(patsubst $(LOCAL_PATH)/%, %, $(wildcard $(LOCAL_PATH)/jni_notification_service_consumer.cpp))
LOCAL_SRC_FILES += $(patsubst $(LOCAL_PATH)/%, %, $(wildcard $(LOCAL_PATH)/jni_notification_service_producer.cpp))
LOCAL_SRC_FILES += $(patsubst $(LOCAL_PATH)/%, %, $(wildcard $(LOCAL_PATH)/jniutil/src/*.cpp))

LOCAL_LDLIBS := -llog 
LOCAL_LDLIBS += -L$(NDK_ROOT)/sources/cxx-stl/gnu-libstdc++/$(TOOLCHAIN_VERSION)/libs/$(TARGET_ARCH_ABI)
LOCAL_SHARED_LIBRARIES := android-notification_service
LOCAL_SHARED_LIBRARIES += android-octbstack
LOCAL_SHARED_LIBRARIES += android-oc
LOCAL_SHARED_LIBRARIES += android-connectivity_abstraction
LOCAL_SHARED_LIBRARIES += rcs_common
LOCAL_SHARED_LIBRARIES += rcs_client
LOCAL_SHARED_LIBRARIES += rcs_server

include $(BUILD_SHARED_LIBRARY)