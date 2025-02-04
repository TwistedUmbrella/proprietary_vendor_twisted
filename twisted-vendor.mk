# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# CyanogenMod Customization
PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false \
    ro.media.enc.jpeg.quality=100 \
    ro.kernel.android.checkjni=0 \
    persist.sys.camera-sound=1 \
    drm.service.enabled=true

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
UTC_DATE := $(shell date +%s)
DATE := $(shell date +%Y%m%d)

# Applications
PRODUCT_PACKAGES += \
      Camera \
      Mms

# Twisted Packages
PRODUCT_COPY_FILES += \
    vendor/twisted/twisted/sbin/speedtweak.sh:root/sbin/speedtweak.sh \
    vendor/twisted/twisted/app/NovaLauncher.apk:system/app/NovaLauncher.apk

# Twisted Customization
PRODUCT_PROPERTY_OVERRIDES += \
    persist.service.adb.enable=1 \
    persist.sys.root_access=3

# Playground Customization
PRODUCT_PROPERTY_OVERRIDES += \
    debug.enabletr=false \
    gsm.proximity.enable=true \
    ro.config.play.bootsound=1

# Build Versioning
PRODUCT_PROPERTY_OVERRIDES += \
    ro.modversion=PROJECT.D \
    ro.rommanager.developerid=Twisted