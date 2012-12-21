# Inherit common Liquid stuff
$(call inherit-product, vendor/twisted/config/common.mk)

# Bring in all audio files
include frameworks/base/data/sounds/NewAudio.mk

# Default ringtone
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=Hydra.ogg \
    ro.config.notification_sound=Proxima.ogg \
    ro.config.alarm_alert=Cesium.ogg
