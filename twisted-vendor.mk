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

# Common Customization
PRODUCT_COPY_FILES += \
    vendor/twisted/prebuilt/sbin/speedtweak.sh:root/sbin/speedtweak.sh \
    vendor/twisted/prebuilt/sbin/zram:root/sbin/zram \
    vendor/twisted/prebuilt/xbin/wget:system/xbin/wget

# Kernel Customization
PRODUCT_COPY_FILES += \
    vendor/twisted/prebuilt/lib/modules/cifs.ko:system/lib/modules/cifs.ko \
    vendor/twisted/prebuilt/lib/modules/lzo_compress.ko:system/lib/modules/lzo_compress.ko \
    vendor/twisted/prebuilt/lib/modules/lzo_decompress.ko:system/lib/modules/lzo_decompress.ko \
    vendor/twisted/prebuilt/lib/modules/tun.ko:system/lib/modules/tun.ko \
    vendor/twisted/prebuilt/lib/modules/zram.ko:system/lib/modules/zram.ko \
    vendor/twisted/prebuilt/etc/init.d:system/etc/init.d
