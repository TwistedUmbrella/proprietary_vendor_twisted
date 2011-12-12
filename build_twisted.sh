cd /Volumes/android/android-tzb_ics4.0.1
export USE_CCACHE=1
export CCACHE_DIR=/Users/TwistedZero/.ccache
prebuilt/darwin-x86/ccache/ccache -M 40G
make clean -j8
source build/envsetup.sh
if [ "$1" == "mecha" ]; then
lunch 6
elif [ "$1" == "ace" ]; then
lunch 4
fi
export USE_CCACHE=1
export CCACHE_DIR=/Users/TwistedZero/.ccache
prebuilt/darwin-x86/ccache/ccache -M 40G
make otapackage -j4
if [ "$1" == "mecha" ]; then
if [ -e /Volumes/android/android-tzb_ics4.0.1/out/target/product/mecha/htc_mecha-ota-eng.TwistedZero.zip ]; then
cp -R /Volumes/android/android-tzb_ics4.0.1/out/target/product/mecha/htc_mecha-ota-eng.TwistedZero.zip /Users/TwistedZero/Dropbox/IceCreamSammy/htc_mecha-ota-eng.TwistedZero.zip
echo "Latest Build Completed:" > /Volumes/frontrow/TwistedZero/TimeStamp
date >> /Volumes/frontrow/TwistedZero/TimeStamp
echo "Please Allow 30-45 Min" >> /Volumes/frontrow/TwistedZero/TimeStamp
fi
elif ["$1" == "ace" ]; then
if [ -e /Volumes/android/android-tzb_ics4.0.1/out/target/product/ace/htc_mecha-ota-eng.TwistedZero.zip ]; then
cp -R /Volumes/android/android-tzb_ics4.0.1/out/target/product/ace/htc_ace-ota-eng.TwistedZero.zip /Users/TwistedZero/Dropbox/IceCreamSammy/htc_ace-ota-eng.TwistedZero.zip
fi
fi