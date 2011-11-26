#
# Copyright (C) 2011 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_small.mk)

# The gps config appropriate for this device
#$(call inherit-product, device/common/gps/gps_us_supl.mk)

#$(call inherit-product-if-exists, vendor/huawei/m835/m835-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/huawei/m835/overlay


ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := device/huawei/m835/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

PRODUCT_PACKAGES += \
    copybit.M835 \
    gps.M835 \
    libRS \
    hwprops \
    rzscontrol \
    libOmxCore \
    libmm-omxcore \
    libOmxVidEnc \
    Gallery

# Live Wallpapers
PRODUCT_PACKAGES += \
    librs_jni \
    LiveWallpapersPicker

# Live Wallpapers support
PRODUCT_COPY_FILES += \
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:/system/etc/permissions/android.software.live_wallpaper.xml

# vold
PRODUCT_COPY_FILES += \
    device/huawei/m835/include/etc/vold.fstab:system/etc/vold.fstab

# Compcache module
#PRODUCT_COPY_FILES += \
#   device/huawei/m835/modules/ramzswap.ko:system/lib/modules/2.6.29-perf/kernel/drivers/staging/ramzswap/ramzswap.ko

# Board-specific init
PRODUCT_COPY_FILES += \
    device/huawei/m835/include/initlogo.rle:root/initlogo.rle

# DHCP config for wifi
PRODUCT_COPY_FILES += \
    device/huawei/m835/include/etc/dhcpcd/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \
    device/huawei/m835/modules/wifi/dhd.ko:system/wifi/dhd.ko

PRODUCT_COPY_FILES += \
    device/huawei/m835/ueventd.qcom.rc:root/ueventd.qcom.rc \
    device/huawei/m835/init.huawei.rc:root/init.huawei.rc

# Keylayouts
PRODUCT_COPY_FILES += \
    device/huawei/m835/keychars/surf_keypad.kcm.bin:system/usr/keychars/surf_keypad.kcm.bin \
    device/huawei/m835/keylayout/surf_keypad.kl:system/usr/keylayout/surf_keypad.kl

# Install the features available on this device.
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/base/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
    frameworks/base/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/base/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/base/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.xml:system/etc/permissions/android.hardware.touchscreen.xml

PRODUCT_PROPERTY_OVERRIDES := \
    wifi.interface=eth0 \
    wifi.supplicant_scan_interval=120 \
    ro.sf.lcd_density=120 \
    ro.com.android.dataroaming=false

# Default network type
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.default_network=4

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=65537

# Perfomance tweaks
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.execution-mode=int:jit \
    dalvik.vm.heapsize=24m \
    persist.sys.use_dithering=1 \
    persist.sys.purgeable_assets=1 \
    ro.compcache.default=18

# Don't put dexfiles in /cache on m835
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dexopt-data-only=1

# Media configuration xml file
PRODUCT_COPY_FILES += \
    device/huawei/m835/include/etc/media_profiles.xml:system/etc/media_profiles.xml

# wpa_supplicant configuration file
PRODUCT_COPY_FILES += \
    device/huawei/m835/include/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf

# Proprietary hardware related
PRODUCT_COPY_FILES += \
    vendor/huawei/m835/proprietary/lib/libcamera.so:obj/lib/libcamera.so \
    vendor/huawei/m835/proprietary/lib/libcamera.so:system/lib/libcamera.so \
    vendor/huawei/m835/proprietary/lib/libqcamera.so:system/lib/libqcamera.so \
    vendor/huawei/m835/proprietary/lib/libmmjpeg.so:system/lib/libmmjpeg.so \
    vendor/huawei/m835/proprietary/lib/libmmipl.so:system/lib/libmmipl.so \
    vendor/huawei/m835/proprietary/lib/libmmprocess.so:system/lib/libmmprocess.so \
    vendor/huawei/m835/proprietary/etc/init.qcom.bt.sh:system/etc/init.qcom.bt.sh

# Sound and OMX
PRODUCT_COPY_FILES += \
    device/huawei/m835/include/etc/AudioFilter.csv:system/etc/AudioFilter.csv \
    device/huawei/m835/include/etc/AutoVolumeControl.txt:system/etc/AutoVolumeControl.txt \
    vendor/huawei/m835/proprietary/lib/libaudioeq.so:system/lib/libaudioeq.so \
    vendor/huawei/m835/proprietary/lib/libmm-adspsvc.so:system/lib/libmm-adspsvc.so \
    vendor/huawei/m835/proprietary/lib/libOmxH264Dec.so:system/lib/libOmxH264Dec.so \
    vendor/huawei/m835/proprietary/lib/libOmxMpeg4Dec.so:system/lib/libOmxMpeg4Dec.so \
    vendor/huawei/m835/proprietary/lib/libOmxVidEnc.so:system/lib/libOmxVidEnc.so

# Lights and graphics
PRODUCT_COPY_FILES += \
    vendor/huawei/m835/proprietary/lib/hw/gralloc.msm7k.so:system/lib/hw/gralloc.msm7k.so \
    vendor/huawei/m835/proprietary/lib/hw/lights.msm7k.so:system/lib/hw/lights.msm7k.so

# Sensors
PRODUCT_COPY_FILES += \
    vendor/huawei/m835/proprietary/bin/akmd2:system/bin/akmd2 \
    vendor/huawei/m835/proprietary/lib/hw/sensors.default.so:system/lib/hw/sensors.default.so

# GPS
PRODUCT_COPY_FILES += \
    device/huawei/m835/include/etc/gps.conf:system/etc/gps.conf

# Proprietary RIL related
PRODUCT_COPY_FILES += \
    device/huawei/m835/include/etc/apns-conf.xml:system/etc/apns-conf.xml \
    vendor/huawei/m835/proprietary/lib/libauth.so:system/lib/libauth.so \
    vendor/huawei/m835/proprietary/lib/libril-qc-1.so:system/lib/libril-qc-1.so \
    vendor/huawei/m835/proprietary/lib/libril.so:system/lib/libril.so \
    vendor/huawei/m835/proprietary/lib/liboncrpc.so:system/lib/liboncrpc.so \
    vendor/huawei/m835/proprietary/lib/libdsm.so:system/lib/libdsm.so \
    vendor/huawei/m835/proprietary/lib/libqueue.so:system/lib/libqueue.so \
    vendor/huawei/m835/proprietary/lib/libcm.so:system/lib/libcm.so \
    vendor/huawei/m835/proprietary/lib/libdiag.so:system/lib/libdiag.so \
    vendor/huawei/m835/proprietary/lib/libmmgsdilib.so:system/lib/libmmgsdilib.so \
    vendor/huawei/m835/proprietary/lib/libgsdi_exp.so:system/lib/libgsdi_exp.so \
    vendor/huawei/m835/proprietary/lib/libgstk_exp.so:system/lib/libgstk_exp.so \
    vendor/huawei/m835/proprietary/lib/libwms.so:system/lib/libwms.so \
    vendor/huawei/m835/proprietary/lib/libnv.so:system/lib/libnv.so \
    vendor/huawei/m835/proprietary/lib/libwmsts.so:system/lib/libwmsts.so \
    vendor/huawei/m835/proprietary/lib/libril-qcril-hook-oem.so:system/lib/libril-qcril-hook-oem.so \
    vendor/huawei/m835/proprietary/lib/libdss.so:system/lib/libdss.so \
    vendor/huawei/m835/proprietary/lib/libdll.so:system/lib/libdll.so \
    vendor/huawei/m835/proprietary/lib/libqmi.so:system/lib/libqmi.so \
    vendor/huawei/m835/proprietary/lib/libpbmlib.so:system/lib/libpbmlib.so \
    vendor/huawei/m835/proprietary/lib/libwpa_client.so:system/lib/libwpa_client.so \
    vendor/huawei/m835/proprietary/bin/qmuxd:system/bin/qmuxd \
    vendor/huawei/m835/proprietary/bin/hci_qcomm_init:system/bin/hci_qcomm_init

# OEM RPC
PRODUCT_COPY_FILES += \
    vendor/huawei/m835/proprietary/bin/modempre:system/bin/modempre \
    vendor/huawei/m835/proprietary/bin/oem_rpc_svc:system/bin/oem_rpc_svc \
    vendor/huawei/m835/proprietary/lib/libhwrpc.so:system/lib/libhwrpc.so \
    vendor/huawei/m835/proprietary/lib/liboem_rapi.so:system/lib/liboem_rapi.so

## Wifi related
PRODUCT_COPY_FILES += \
    vendor/huawei/m835/proprietary/wifi/ar6000.ko:system/wifi/ar6000.ko \
    vendor/huawei/m835/proprietary/wifi/firmware_apsta.bin:system/wifi/firmware_apsta.bin \
    vendor/huawei/m835/proprietary/wifi/nvram.txt:system/wifi/nvram.txt

$(call inherit-product, build/target/product/small_base.mk)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := generic_m835
PRODUCT_DEVICE := m835
PRODUCT_MODEL := HUAWEI-M835
PRODUCT_BOARD := M835
PRODUCT_LOCALES := zh_CN zh_TW en_US
PRODUCT_DEFAULT_REGION := CN

PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-ChinaTelecom \
    ro.com.google.locationfeatures=1 \
    ro.cdma.home.operator.numeric=46003 \
    ro.config.cdma_subscription=1 \
    ro.cdma.voicemail.number=mine \
    ro.setupwizard.enable_bypass=1 \
    ro.config.play.bootsound=0

##Added Files for bootsound and themes
PRODUCT_COPY_FILES += \
    device/huawei/m835/include/bin/bootsound:system/bin/bootsound \
    device/huawei/m835/include/media/audio/ui/android_audio.mp3:system/media/audio/ui/android_audio.mp3 \
    device/huawei/m835/include/media/bootanimation.zip:system/media/bootanimation.zip \
    device/huawei/m835/include/etc/init.local.rc:system/etc/init.local.rc 

## Dark Tremors apps2sd
PRODUCT_COPY_FILES += \
    device/huawei/m835/include/apps2sd_files/data/dtinstall.launch:data/dtinstall.launch \
    device/huawei/m835/include/apps2sd_files/data/jit/bin/dalvikvm:data/jit/bin/dalvikvm \
    device/huawei/m835/include/apps2sd_files/data/jit/lib/libdvm.so:data/jit/lib/libdvm.so \
    device/huawei/m835/include/apps2sd_files/data/jit/lib/libnativehelper.so:data/jit/lib/libnativehelper.so \
    device/huawei/m835/include/apps2sd_files/system/bin/a2sd:system/bin/a2sd \
    device/huawei/m835/include/apps2sd_files/system/bin/apps2sd.hlp:system/bin/apps2sd.hlp \
    device/huawei/m835/include/apps2sd_files/system/bin/bash:system/bin/bash \
    device/huawei/m835/include/apps2sd_files/system/bin/busybox.a2sd:system/bin/busybox.a2sd \
    device/huawei/m835/include/apps2sd_files/system/bin/chka2sd:system/bin/chka2sd \
    device/huawei/m835/include/apps2sd_files/system/bin/dtinstall:system/bin/dtinstall \
    device/huawei/m835/include/apps2sd_files/system/bin/jita2sd:system/bin/jita2sd \
    device/huawei/m835/include/apps2sd_files/system/bin/launcha2sd:system/bin/launcha2sd \
    device/huawei/m835/include/apps2sd_files/system/bin/starta2sd:system/bin/starta2sd \
    device/huawei/m835/include/apps2sd_files/system/bin/sysinit:system/bin/sysinit \
    device/huawei/m835/include/apps2sd_files/system/bin/zipalign:system/bin/zipalign \
    device/huawei/m835/include/apps2sd_files/system/etc/init.d/00banner:system/etc/init.d/00banner \
    device/huawei/m835/include/apps2sd_files/system/etc/init.d/01sysctl:system/etc/init.d/01sysctl \
    device/huawei/m835/include/apps2sd_files/system/etc/init.d/02firstboot:system/etc/init.d/02firstboot \
    device/huawei/m835/include/apps2sd_files/system/etc/init.d/04apps2sd:system/etc/init.d/01apps2sd \
    device/huawei/m835/include/apps2sd_files/system/etc/init.d/99complete:system/etc/init.d/99complete \
    device/huawei/m835/include/apps2sd_files/system/sd/placeholder:system/sd/placeholder \
    device/huawei/m835/include/apps2sd_files/system/xbin/a2sd:system/xbin/a2sd \
    device/huawei/m835/include/apps2sd_files/system/xbin/apps2sd:system/xbin/apps2sd \
    device/huawei/m835/include/apps2sd_files/move_cache_sd:root/move_cache_sd \
    device/huawei/m835/include/apps2sd_files/apps2sd_run_program:root/apps2sd_run_program \
    device/huawei/m835/include/apps2sd_files/apps2sd_system:root/apps2sd_system

##Screen Rotation Fix
#    device/huawei/m835/include/lib/libui.so:system/lib/libui.so

##No Ads Host file
PRODUCT_COPY_FILES += \
    device/huawei/m835/include/etc/hosts:system/etc/hosts
