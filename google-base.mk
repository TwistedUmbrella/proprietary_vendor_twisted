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

# Google Libraries
PRODUCT_COPY_FILES += \
    vendor/twisted/google/lib/base/libfacelock_jni.so:system/lib/libfacelock_jni.so \
    vendor/twisted/google/lib/base/libfilterpack_facedetect.so:system/lib/libfilterpack_facedetect.so \
    vendor/twisted/google/lib/base/libflint_engine_jni_api.so:system/lib/libflint_engine_jni_api.so \
    vendor/twisted/google/lib/base/libfrsdk.so:system/lib/libfrsdk.so \
    vendor/twisted/google/lib/base/libgcomm_jni.so:system/lib/libgcomm_jni.so \
    vendor/twisted/google/lib/base/libpicowrapper.so:system/lib/libpicowrapper.so \
    vendor/twisted/google/lib/base/libspeexwrapper.so:system/lib/libspeexwrapper.so \
    vendor/twisted/google/lib/base/libvideochat_jni.so:system/lib/libvideochat_jni.so \
    vendor/twisted/google/lib/base/libvideochat_stabilize.so:system/lib/libvideochat_stabilize.so \
    vendor/twisted/google/lib/base/libvoicesearch.so:system/lib/libvoicesearch.so