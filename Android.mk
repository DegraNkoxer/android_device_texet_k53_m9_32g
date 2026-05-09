LOCAL_PATH := $(call my-dir)
ifeq ($(TARGET_DEVICE),k53_m9_32g)
include $(call all-makefiles-under,$(LOCAL_PATH))
endif
