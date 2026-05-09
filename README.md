# TWRP Device Tree — Texet TM-5702
## Codename: k53_m9_32g | Chipset: MT6753 | Android 8.1.0

---

## Parámetros del kernel (extraídos de boot.img original)

| Parámetro       | Valor          |
|-----------------|----------------|
| BASE            | 0x40078000     |
| KERNEL_OFFSET   | 0x00008000     |
| RAMDISK_OFFSET  | 0x03f88000     |
| TAGS_OFFSET     | 0x0df88000     |
| PAGE_SIZE       | 2048           |
| CMDLINE         | bootopt=64S3,32N2,64N2 buildvariant=user |
| BOOT partition  | mmcblk0p7 (16 MB) |
| RECOVERY part.  | mmcblk0p8 (24 MB) |

---

## Estructura del Device Tree

```
device/texet/k53_m9_32g/
├── Android.mk
├── BoardConfig.mk          ← configuración principal de hardware
├── device.mk
├── omni_k53_m9_32g.mk      ← makefile del producto
├── vendorsetup.sh
├── prebuilt/
│   └── zImage-dtb          ← kernel extraído de tu boot.img
└── recovery/
    └── root/
        └── etc/
            └── twrp.fstab  ← tabla de particiones para TWRP
```

---

## Instrucciones de compilación

### 1. Preparar el sistema (Ubuntu 20.04 recomendado)

```bash
sudo apt-get install -y \
    git-core gnupg flex bison gperf build-essential \
    zip curl zlib1g-dev gcc-multilib g++-multilib \
    libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev \
    libx11-dev lib32z-dev libgl1-mesa-dev libxml2-utils \
    xsltproc unzip python3 python-is-python3 \
    openjdk-8-jdk bc libssl-dev
```

### 2. Instalar repo

```bash
mkdir -p ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### 3. Crear directorio de trabajo y sincronizar TWRP

```bash
mkdir -p ~/twrp && cd ~/twrp

repo init \
    -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git \
    -b twrp-12.1 \
    --depth=1

repo sync -j$(nproc) --force-sync --no-clone-bundle
```

> **Nota:** La branch `twrp-12.1` es la más activa. También puedes probar `twrp-9.0` si hay problemas con dispositivos más antiguos.

### 4. Copiar el Device Tree

```bash
# Copia la carpeta device_tree al workspace de TWRP
cp -r device/texet ~/twrp/device/
```

Coloca también el kernel prebuilt en:
```
~/twrp/device/texet/k53_m9_32g/prebuilt/zImage-dtb
```

### 5. Compilar

```bash
cd ~/twrp

# Cargar el entorno de compilación
source build/envsetup.sh

# Seleccionar el target
lunch omni_k53_m9_32g-eng

# Compilar (usa todos los núcleos disponibles)
mka recoveryimage -j$(nproc)
```

La imagen resultante estará en:
```
out/target/product/k53_m9_32g/recovery.img
```

### 6. Flashear

```bash
# Desde fastboot (bootloader desbloqueado ✓)
fastboot flash recovery out/target/product/k53_m9_32g/recovery.img
fastboot reboot recovery
```

---

## Posibles problemas y soluciones

### ❶ Pantalla en negro / touch no funciona
El MT6753 a veces necesita configuración específica de display.
Agrega en `BoardConfig.mk`:
```makefile
TW_SCREEN_BLANK_ON_BOOT := true
# y/o ajusta la ruta de brillo:
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
```

### ❷ No arranca (bootloop en recovery)
El kernel prebuilt puede tener incompatibilidades con el ramdisk de TWRP.
Intenta agregar en `BoardConfig.mk`:
```makefile
BOARD_SUPPRESS_SECURE_ERASE := true
TW_HAS_NO_RECOVERY_PARTITION := false
```

### ❸ Error de cifrado / no puede montar /data
El dispositivo usa FDE (Full Disk Encryption). Si TWRP no puede montar /data
pide la contraseña/PIN. Si no funciona:
```makefile
# En BoardConfig.mk ya está deshabilitado:
TW_INCLUDE_CRYPTO := false
```
En este caso /data/media no será accesible sin ingresar el PIN de desbloqueo.

### ❹ Error de compilación: `BOARD_KERNEL_IMAGE_NAME`
Si el sistema de compilación no acepta `zImage-dtb`, cambia a:
```makefile
BOARD_KERNEL_IMAGE_NAME := zImage
```
Y renombra el prebuilt a solo `zImage`.

### ❺ Nota sobre MT6753 vs MT6735
El `init.recovery.mt6735.rc` en el ramdisk original referencia `mt6735`
pero el dispositivo usa `mt6753`. MTK reutiliza el mismo rc para ambos.
En `BoardConfig.mk` está correctamente configurado como `mt6753`.

---

## Recursos adicionales

- TWRP minimal manifest: https://github.com/minimal-manifest-twrp
- TWRP source: https://github.com/TeamWin/android_bootable_recovery
- Device trees de referencia MT6753:
  - https://github.com/search?q=android_device+mt6753&type=repositories
