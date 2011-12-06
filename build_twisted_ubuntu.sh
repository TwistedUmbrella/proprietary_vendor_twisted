cd /media/psf/android/android-tzb_ics4.0.1
export USE_CCACHE=1
export CCACHE_DIR=/media/psf/Home/.ccache
prebuilt/linux-x86/ccache/ccache -M 40G
make clean -j4
source build/envsetup.sh
lunch 6
export USE_CCACHE=1
export CCACHE_DIR=/media/psf/Home/.ccache
prebuilt/linux-x86/ccache/ccache -M 40G
make otapackage -j4
