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

# Bring in all audio files
include frameworks/base/data/sounds/AllAudio.mk

# Google Applications
PRODUCT_COPY_FILES += \
    vendor/twisted/google/app/ChromeBookmarksSyncAdapter.apk:system/app/ChromeBookmarksSyncAdapter.apk \
    vendor/twisted/google/app/Gmail.apk:system/app/Gmail.apk \
    vendor/twisted/google/app/GoogleBackupTransport.apk:system/app/GoogleBackupTransport.apk \
    vendor/twisted/google/app/GoogleContactsSyncAdapter.apk:system/app/GoogleContactsSyncAdapter.apk \
    vendor/twisted/google/app/GoogleFeedback.apk:system/app/GoogleFeedback.apk \
    vendor/twisted/google/app/GoogleLoginService.apk:system/app/GoogleLoginService.apk \
    vendor/twisted/google/app/GooglePartnerSetup.apk:system/app/GooglePartnerSetup.apk \
    vendor/twisted/google/app/GoogleServicesFramework.apk:system/app/GoogleServicesFramework.apk \
    vendor/twisted/google/app/GoogleTTS.apk:system/app/GoogleTTS.apk \
    vendor/twisted/google/app/Maps.apk:system/app/Maps.apk \
    vendor/twisted/google/app/MarketUpdater.apk:system/app/MarketUpdater.apk \
    vendor/twisted/google/app/MediaUploader.apk:system/app/MediaUploader.apk \
    vendor/twisted/google/app/NetworkLocation.apk:system/app/NetworkLocation.apk \
    vendor/twisted/google/app/OneTimeInitializer.apk:system/app/OneTimeInitializer.apk \
    vendor/twisted/google/app/SetupWizard.apk:system/app/SetupWizard.apk \
    vendor/twisted/google/app/Talk.apk:system/app/Talk.apk \
    vendor/twisted/google/app/Vending.apk:system/app/Vending.apk \
    vendor/twisted/google/app/YouTube.apk:system/app/YouTube.apk

# Google Permissions
PRODUCT_COPY_FILES += \
    vendor/twisted/google/etc/permissions/com.google.android.maps.xml:system/etc/permissions/com.google.android.maps.xml \
    vendor/twisted/google/etc/permissions/com.google.android.media.effects.xml:system/etc/permissions/com.google.android.media.effects.xml \
    vendor/twisted/google/etc/permissions/com.google.widevine.software.drm.xml:system/etc/permissions/com.google.widevine.software.drm.xml \
    vendor/twisted/google/etc/permissions/features.xml:system/etc/permissions/features.xml 

# Google Frameworks
PRODUCT_COPY_FILES += \
    vendor/twisted/google/framework/com.google.android.maps.jar:system/framework/com.google.android.maps.jar \
    vendor/twisted/google/framework/com.google.android.media.effects.jar:system/framework/com.google.android.media.effects.jar \
    vendor/twisted/google/framework/com.google.widevine.software.drm.jar:system/framework/com.google.widevine.software.drm.jar

# Google Libraries
PRODUCT_COPY_FILES += \
    vendor/twisted/google/lib/libflint_engine_jni_api.so:system/lib/libflint_engine_jni_api.so \
    vendor/twisted/google/lib/libfrsdk.so:system/lib/libfrsdk.so \
    vendor/twisted/google/lib/libgcomm_jni.so:system/lib/libgcomm_jni.so \
    vendor/twisted/google/lib/libmotricity.so:system/lib/libmotricity.so \
    vendor/twisted/google/lib/libpicowrapper.so:system/lib/libpicowrapper.so \
    vendor/twisted/google/lib/libspeexresampler.so:system/lib/libspeexresampler.so \
    vendor/twisted/google/lib/libspeexwrapper.so:system/lib/libspeexwrapper.so \
    vendor/twisted/google/lib/libvideochat_jni.so:system/lib/libvideochat_jni.so \
    vendor/twisted/google/lib/libvideochat_stabilize.so:system/lib/libvideochat_stabilize.so \
    vendor/twisted/google/lib/libvoicesearch.so:system/lib/libvoicesearch.so

# Twisted Packages
PRODUCT_COPY_FILES += \
    vendor/twisted/twisted/app/NovaLauncher.apk:system/app/NovaLauncher.apk

# Build Versioning
PRODUCT_PROPERTY_OVERRIDES += \
    ro.modversion=Multi-Device_Beta_3