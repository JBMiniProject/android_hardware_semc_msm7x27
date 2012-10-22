# Copyright 2008 The Android Open-Source Project
# Copyright 2012 The Jelly Bean Mini Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ifeq ($(BUILD_JBMP_TEST_AUDIO),true)

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
    LOCAL_CFLAGS += -DQCOM_HARDWARE
endif

LOCAL_SRC_FILES := AudioHardware.cpp

ifeq ($(BOARD_HAVE_BLUETOOTH),true)
  LOCAL_CFLAGS += -DWITH_A2DP
endif

LOCAL_SHARED_LIBRARIES := \
    libcutils       \
    libutils        \
    libmedia

LOCAL_STATIC_LIBRARIES := \
    libmedia_helper  \
    libaudiohw_legacy

LOCAL_MODULE := audio.primary.$(TARGET_BOARD_PLATFORM)
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE_TAGS := optional

LOCAL_CFLAGS += -fno-short-enums

LOCAL_C_INCLUDES += hardware/libhardware/include
LOCAL_C_INCLUDES += hardware/libhardware_legacy/include
LOCAL_C_INCLUDES += frameworks/base/include
LOCAL_C_INCLUDES += system/core/include

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := AudioPolicyManager.cpp

LOCAL_SHARED_LIBRARIES := \
    libcutils \
    libutils \
    libmedia

LOCAL_STATIC_LIBRARIES := \
    libaudiopolicy_legacy \
    libmedia_helper \
    libaudiohw_legacy

LOCAL_MODULE := audio_policy.$(TARGET_BOARD_PLATFORM)
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE_TAGS := optional

ifeq ($(BOARD_HAVE_BLUETOOTH),true)
  LOCAL_CFLAGS += -DWITH_A2DP
endif

LOCAL_C_INCLUDES := hardware/libhardware_legacy/audio

include $(BUILD_SHARED_LIBRARY)

endif
