# omni_k53_m9_32g.mk - Texet TM-5702
# Archivo principal del producto para compilación TWRP

$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# Hereda el device.mk de este dispositivo
$(call inherit-product, device/texet/k53_m9_32g/device.mk)

# Propiedades del producto
PRODUCT_DEVICE := k53_m9_32g
PRODUCT_NAME   := omni_k53_m9_32g
PRODUCT_BRAND  := Texet
PRODUCT_MODEL  := TM-5702
PRODUCT_MANUFACTURER := Texet

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE=k53_m9_32g \
    PRODUCT_NAME=k53_m9_32g \
    PRIVATE_BUILD_DESC="full_k53_m9_32g-user 8.1.0 O11019 1756899970 test-keys" \
    BUILD_FINGERPRINT="Texet/TM-5702/TM-5702:8.1.0/O11019/1570694410:user/release-keys"
