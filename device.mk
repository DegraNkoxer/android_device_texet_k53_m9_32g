
# device.mk - Texet TM-5702 (k53_m9_32g)
LOCAL_PATH := device/texet/k53_m9_32g

# fstab de TWRP
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/etc/twrp.fstab:recovery/root/etc/twrp.fstab

# Propiedades del sistema
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware=mt6753 \
    ro.board.platform=mt6753 \
    ro.sf.lcd_density=240
