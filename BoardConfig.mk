#
# BoardConfig.mk - Texet TM-5702 (k53_m9_32g)
# Chipset: MediaTek MT6753 | Android 8.1.0
#

DEVICE_PATH := device/texet/k53_m9_32g

# ─── Architecture ────────────────────────────────────────────
TARGET_ARCH         := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI      := arm64-v8a
TARGET_CPU_ABI2     :=
TARGET_CPU_VARIANT  := cortex-a53

TARGET_2ND_ARCH         := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI      := armeabi-v7a
TARGET_2ND_CPU_ABI2     := armeabi
TARGET_2ND_CPU_VARIANT  := cortex-a53

TARGET_BOARD_SUFFIX := _64
TARGET_USES_64_BIT_BINDER := true

# ─── Platform ─────────────────────────────────────────────────
TARGET_BOARD_PLATFORM    := mt6753
TARGET_BOOTLOADER_BOARD_NAME := k53_m9_32g

# ─── Kernel ───────────────────────────────────────────────────
# Usamos el kernel prebuilt extraído del boot.img original
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/zImage-dtb
BOARD_KERNEL_IMAGE_NAME := zImage-dtb

BOARD_KERNEL_BASE        := 0x40078000
BOARD_KERNEL_PAGESIZE    := 2048
BOARD_KERNEL_OFFSET      := 0x00008000
BOARD_RAMDISK_OFFSET     := 0x03f88000
BOARD_SECOND_OFFSET      := 0x00e88000
BOARD_TAGS_OFFSET        := 0x0df88000

BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 buildvariant=user

BOARD_MKBOOTIMG_ARGS := \
    --kernel_offset $(BOARD_KERNEL_OFFSET) \
    --ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
    --second_offset $(BOARD_SECOND_OFFSET) \
    --tags_offset $(BOARD_TAGS_OFFSET)

# ─── Particiones ──────────────────────────────────────────────
BOARD_BOOTIMAGE_PARTITION_SIZE     := 16777216   # 16 MB (mmcblk0p7)
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 25165824   # 24 MB (mmcblk0p8)
BOARD_SYSTEMIMAGE_PARTITION_TYPE   := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE  := ext4
BOARD_FLASH_BLOCK_SIZE             := 131072     # page_size * 64

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := false

# ─── Pantalla ─────────────────────────────────────────────────
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH  := 720

# ─── Treble ───────────────────────────────────────────────────
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# ─── Crypto / FDE ─────────────────────────────────────────────
# El userdata está cifrado con FDE (forceencrypt=/metadata)
# Deshabilitamos crypto en TWRP para facilitar el acceso
TW_INCLUDE_CRYPTO     := false
TW_INCLUDE_CRYPTO_FBE := false

# ─── TWRP ─────────────────────────────────────────────────────
TW_THEME                    := portrait_hdpi
RECOVERY_SDCARD_ON_DATA     := true
TW_BRIGHTNESS_PATH          := "/sys/class/leds/lcd-backlight/brightness"
TW_MAX_BRIGHTNESS           := 255
TW_DEFAULT_BRIGHTNESS       := 120
TW_EXCLUDE_SUPERSU          := true
TW_INCLUDE_NTFS_3G          := true
TW_INCLUDE_FUSE_EXFAT       := true
TW_INCLUDE_REPACKTOOLS       := true
TW_USE_TOOLBOX              := true
TW_EXTRA_LANGUAGES          := false
TWRP_INCLUDE_LOGCAT         := true
TW_INCLUDE_FB2PNG           := true
TW_NO_USB_STORAGE           := false
TW_INTERNAL_STORAGE_PATH    := "/data/media/0"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_EXTERNAL_STORAGE_PATH    := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sd"
TW_MTP_DEVICE               := /dev/mtp_usb
TW_DEFAULT_LANGUAGE         := en
BOARD_HAS_NO_SELECT_BUTTON  := true
BOARD_SUPPRESS_SECURE_ERASE := true
TW_NO_HAPTICS               := false

# ─── MTK específico ───────────────────────────────────────────
BOARD_USES_MTK_HARDWARE     := true
TW_NO_EXFAT_FUSE            := false
