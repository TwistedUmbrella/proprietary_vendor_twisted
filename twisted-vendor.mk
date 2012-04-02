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
    ro.com.android.dataroaming=false

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
UTC_DATE := $(shell date +%s)
DATE := $(shell date +%Y%m%d)

# Applications
PRODUCT_PACKAGES += \
      Camera \
      Mms

# Twisted Packages
PRODUCT_COPY_FILES += \
    vendor/twisted/twisted/app/NovaLauncher.apk:system/app/NovaLauncher.apk

# Twisted Customization
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.statusbar=true

# Build Versioning
PRODUCT_PROPERTY_OVERRIDES += \
    ro.modversion=Flashy_Update_6 \
    ro.rommanager.developerid=Twisted