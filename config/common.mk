# build
PRODUCT_BUILD_PROP_OVERRIDES += \
    BUILD_DISPLAY_ID="ICS v1.5 MR3"

# overrides
PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.media.enc.jpeg.quality=100 \
    ro.kernel.android.checkjni=0 \
    persist.sys.camera-sound=1 \
    drm.service.enabled=true

# packages
PRODUCT_PACKAGES += \
    LiveWallpapers \
    HoloSpiralWallpaper \
    LiveWallpapersPicker \
    Galaxy4 \
    PhaseBeam \
    NoiseField \
    Torch

# tmobile
PRODUCT_PACKAGES += \
    ThemeManager \
    ThemeChooser \
    com.tmobile.themes

# overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/twisted/overlay/common

# binary
PRODUCT_COPY_FILES += \
    vendor/twisted/prebuilt/common/bin/sysinit:system/bin/sysinit

# etc
PRODUCT_COPY_FILES += \
    vendor/twisted/prebuilt/common/etc/gps.conf:system/etc/gps.conf

# permissions
PRODUCT_COPY_FILES += \
    vendor/twisted/prebuilt/common/etc/permissions/features.xml:system/etc/permissions/features.xml \
    vendor/twisted/prebuilt/common/etc/permissions/com.google.android.maps.xml:system/etc/permissions/com.google.android.maps.xml \
    vendor/twisted/prebuilt/common/etc/permissions/com.tmobile.software.themes.xml:system/etc/permissions/com.tmobile.software.themes.xml \
    vendor/twisted/prebuilt/common/etc/permissions/com.google.widevine.software.drm.xml:system/etc/permissions/com.google.widevine.software.drm.xml \
    vendor/twisted/prebuilt/common/etc/permissions/com.google.android.media.effects.xml:system/etc/permissions/com.google.android.media.effects.xml

# framework
PRODUCT_COPY_FILES += \
    vendor/twisted/prebuilt/common/framework/com.google.android.maps.jar:system/framework/com.google.android.maps.jar \
    vendor/twisted/prebuilt/common/framework/com.google.android.media.effects.jar:system/framework/com.google.android.media.effects.jar \
    vendor/twisted/prebuilt/common/framework/com.google.widevine.software.drm.jar:system/framework/com.google.widevine.software.drm.jar

# google
PRODUCT_COPY_FILES += \
    vendor/twisted/prebuilt/common/app/ChromeBookmarksSyncAdapter.apk:system/app/ChromeBookmarksSyncAdapter.apk \
    vendor/twisted/prebuilt/common/app/FaceLock.apk:system/app/FaceLock.apk \
    vendor/twisted/prebuilt/common/app/flash_plugin.apk:system/app/flash_plugin.apk \
    vendor/twisted/prebuilt/common/app/GalleryGoogle.apk:system/app/GalleryGoogle.apk \
    vendor/twisted/prebuilt/common/app/GenieWidget.apk:system/app/GenieWidget.apk \
    vendor/twisted/prebuilt/common/app/Gmail.apk:system/app/Gmail.apk \
    vendor/twisted/prebuilt/common/app/GoogleBackupTransport.apk:system/app/GoogleBackupTransport.apk \
    vendor/twisted/prebuilt/common/app/GoogleCalendarSyncAdapter.apk:system/app/GoogleCalendarSyncAdapter.apk \
    vendor/twisted/prebuilt/common/app/GoogleContactsSyncAdapter.apk:system/app/GoogleContactsSyncAdapter.apk \
    vendor/twisted/prebuilt/common/app/GoogleFeedback.apk:system/app/GoogleFeedback.apk \
    vendor/twisted/prebuilt/common/app/GoogleLoginService.apk:system/app/GoogleLoginService.apk \
    vendor/twisted/prebuilt/common/app/GooglePartnerSetup.apk:system/app/GooglePartnerSetup.apk \
    vendor/twisted/prebuilt/common/app/GoogleQuickSearchBox.apk:system/app/GoogleQuickSearchBox.apk \
    vendor/twisted/prebuilt/common/app/GoogleServicesFramework.apk:system/app/GoogleServicesFramework.apk \
    vendor/twisted/prebuilt/common/app/GoogleTTS.apk:system/app/GoogleTTS.apk \
    vendor/twisted/prebuilt/common/app/MarketUpdater.apk:system/app/MarketUpdater.apk \
    vendor/twisted/prebuilt/common/app/MediaUploader.apk:system/app/MediaUploader.apk \
    vendor/twisted/prebuilt/common/app/NetworkLocation.apk:system/app/NetworkLocation.apk \
    vendor/twisted/prebuilt/common/app/OneTimeInitializer.apk:system/app/OneTimeInitializer.apk \
    vendor/twisted/prebuilt/common/app/Phonesky.apk:system/app/Phonesky.apk \
    vendor/twisted/prebuilt/common/app/SetupWizard.apk:system/app/SetupWizard.apk \
    vendor/twisted/prebuilt/common/app/SuperSU.apk:system/app/SuperSU.apk \
    vendor/twisted/prebuilt/common/app/Talk.apk:system/app/Talk.apk \
    vendor/twisted/prebuilt/common/app/VoiceSearch.apk:system/app/VoiceSearch.apk

# library
PRODUCT_COPY_FILES += \
    vendor/twisted/prebuilt/common/lib/libfacelock_jni.so:system/lib/libfacelock_jni.so \
    vendor/twisted/prebuilt/common/lib/libfilterpack_facedetect.so:system/lib/libfilterpack_facedetect.so \
    vendor/twisted/prebuilt/common/lib/libflint_engine_jni_api.so:system/lib/libflint_engine_jni_api.so \
    vendor/twisted/prebuilt/common/lib/libfrsdk.so:system/lib/libfrsdk.so \
    vendor/twisted/prebuilt/common/lib/libgcomm_jni.so:system/lib/libgcomm_jni.so \
    vendor/twisted/prebuilt/common/lib/libgoogle_recognizer_jni.so:system/lib/libgoogle_recognizer_jni.so \
    vendor/twisted/prebuilt/common/lib/libpatts_engine_jni_api.so:system/lib/libpatts_engine_jni_api.so \
    vendor/twisted/prebuilt/common/lib/libpicowrapper.so:system/lib/libpicowrapper.so \
    vendor/twisted/prebuilt/common/lib/libspeexwrapper.so:system/lib/libspeexwrapper.so \
    vendor/twisted/prebuilt/common/lib/libvideochat_jni.so:system/lib/libvideochat_jni.so \
    vendor/twisted/prebuilt/common/lib/libvideochat_stabilize.so:system/lib/libvideochat_stabilize.so \
    vendor/twisted/prebuilt/common/lib/libvoicesearch.so:system/lib/libvoicesearch.so

# vendor
PRODUCT_COPY_FILES += \
    vendor/twisted/prebuilt/common/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/left_eye-y0-yi45-p0-pi45-r0-ri20.2d_n2/full_model.bin:system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/left_eye-y0-yi45-p0-pi45-r0-ri20.2d_n2/full_model.bin \
    vendor/twisted/prebuilt/common/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/left_eye-y0-yi45-p0-pi45-rn7-ri20.2d_n2/full_model.bin:system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/left_eye-y0-yi45-p0-pi45-rn7-ri20.2d_n2/full_model.bin \
    vendor/twisted/prebuilt/common/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/left_eye-y0-yi45-p0-pi45-rp7-ri20.2d_n2/full_model.bin:system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/left_eye-y0-yi45-p0-pi45-rp7-ri20.2d_n2/full_model.bin \
    vendor/twisted/prebuilt/common/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/nose_base-y0-yi45-p0-pi45-r0-ri20.2d_n2/full_model.bin:system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/nose_base-y0-yi45-p0-pi45-r0-ri20.2d_n2/full_model.bin \
    vendor/twisted/prebuilt/common/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/nose_base-y0-yi45-p0-pi45-rn7-ri20.2d_n2/full_model.bin:system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/nose_base-y0-yi45-p0-pi45-rn7-ri20.2d_n2/full_model.bin \
    vendor/twisted/prebuilt/common/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/nose_base-y0-yi45-p0-pi45-rp7-ri20.2d_n2/full_model.bin:system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/nose_base-y0-yi45-p0-pi45-rp7-ri20.2d_n2/full_model.bin \
    vendor/twisted/prebuilt/common/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/right_eye-y0-yi45-p0-pi45-r0-ri20.2d_n2/full_model.bin:system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/right_eye-y0-yi45-p0-pi45-r0-ri20.2d_n2/full_model.bin \
    vendor/twisted/prebuilt/common/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/right_eye-y0-yi45-p0-pi45-rn7-ri20.2d_n2/full_model.bin:system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/right_eye-y0-yi45-p0-pi45-rn7-ri20.2d_n2/full_model.bin \
    vendor/twisted/prebuilt/common/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/right_eye-y0-yi45-p0-pi45-rp7-ri20.2d_n2/full_model.bin:system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.3/right_eye-y0-yi45-p0-pi45-rp7-ri20.2d_n2/full_model.bin \
    vendor/twisted/prebuilt/common/vendor/pittpatt/models/detection/yaw_roll_face_detectors.3/head-y0-yi45-p0-pi45-r0-ri30.4a/full_model.bin:system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.3/head-y0-yi45-p0-pi45-r0-ri30.4a/full_model.bin \
    vendor/twisted/prebuilt/common/vendor/pittpatt/models/detection/yaw_roll_face_detectors.3/head-y0-yi45-p0-pi45-rn30-ri30.5/full_model.bin:system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.3/head-y0-yi45-p0-pi45-rn30-ri30.5/full_model.bin \
    vendor/twisted/prebuilt/common/vendor/pittpatt/models/detection/yaw_roll_face_detectors.3/head-y0-yi45-p0-pi45-rp30-ri30.5/full_model.bin:system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.3/head-y0-yi45-p0-pi45-rp30-ri30.5/full_model.bin \
    vendor/twisted/prebuilt/common/vendor/pittpatt/models/recognition/face.face.y0-y0-22-b-N/full_model.bin:system/vendor/pittpatt/models/recognition/face.face.y0-y0-22-b-N/full_model.bin

# tts
PRODUCT_COPY_FILES += $(shell \
    find vendor/twisted/prebuilt/common/tts/lang_pico -name '*.bin' \
    | sed -r 's/^\/?(.*\/)([^/ ]+)$$/\1\2:system\/tts\/lang_pico\/\2/' \
    | tr '\n' ' ')

# media
PRODUCT_COPY_FILES += \
    vendor/twisted/prebuilt/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/twisted/prebuilt/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# scripts
PRODUCT_COPY_FILES += \
    vendor/twisted/prebuilt/common/xbin/su:system/xbin/su \
    vendor/twisted/prebuilt/common/xbin/sysro:system/xbin/sysro \
    vendor/twisted/prebuilt/common/xbin/sysrw:system/xbin/sysrw

