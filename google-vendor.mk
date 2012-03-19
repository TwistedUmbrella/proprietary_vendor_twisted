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

# Minimal Installation
$(call inherit-product-if-exists, vendor/twisted/google-minimal.mk)

# Applications
PRODUCT_PACKAGES += \
    AppWidgetPicker \
    Development \
    FileManager \
    Stk \
    VoiceDialer \
    SpareParts \
    Torch \
    ZeroXBenchmark

# CyanogenMod Packages
PRODUCT_PACKAGES += \
    DSPManager \
    libcyanogen-dsp \
    audio_effects.conf

# Live Wallpapers
PRODUCT_PACKAGES += \
    Basic \
    HoloSpiralWallpaper \
    MagicSmokeWallpapers \
    NoiseField \
    Galaxy4 \
    PhaseBeam \
    LiveWallpapers \
    VisualizationWallpapers

# Google Applications
PRODUCT_COPY_FILES += \
    vendor/twisted/google/app/GenieWidget.apk:system/app/GenieWidget.apk \
    vendor/twisted/google/app/Gmail.apk:system/app/Gmail.apk \
    vendor/twisted/google/app/GoogleTTS.apk:system/app/GoogleTTS.apk \
    vendor/twisted/google/app/Maps.apk:system/app/Maps.apk \
    vendor/twisted/google/app/PicasaSyncAdapter.apk:system/app/PicasaSyncAdapter.apk \
    vendor/twisted/google/app/PlusOne.apk:system/app/PlusOne.apk \
    vendor/twisted/google/app/Street.apk:system/app/Street.apk \
    vendor/twisted/google/app/Thinkfree.apk:system/app/Thinkfree.apk \
    vendor/twisted/google/app/Videos.apk:system/app/Videos.apk \
    vendor/twisted/google/app/VoiceSearch.apk:system/app/VoiceSearch.apk \
    vendor/twisted/google/app/YouTube.apk:system/app/YouTube.apk