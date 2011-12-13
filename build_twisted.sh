if [ "$1" == "mecha" ]; then
echo "Build Notes: "
read changes
echo "" > /Volumes/frontrow/TwistedZero/TimeStamp
echo "New Compile Started:" >> /Volumes/frontrow/TwistedZero/TimeStamp
date >> /Volumes/frontrow/TwistedZero/TimeStamp
echo "Compile Information:" >> /Volumes/frontrow/TwistedZero/TimeStamp
echo $changes >> /Volumes/frontrow/TwistedZero/TimeStamp
cat /Volumes/frontrow/TwistedZero/BackStamp /Volumes/frontrow/TwistedZero/TimeStamp > /Volumes/frontrow/TwistedZero/TempStamp
mv -f /Volumes/frontrow/TwistedZero/TempStamp /Volumes/frontrow/TwistedZero/TimeStamp
if [ "$2" == "Y" ]; then
echo "Config Name? ";
cd /Volumes/android/android-tzb_ics4.0.1/kernel/leanKernel-tbolt-ics
ls config
read config
./buildlean.sh 1 $config
if [ -e arch/arm/boot/zImage ]; then
echo "" >> /Volumes/frontrow/TwistedZero/TimeStamp
echo "Kernel Compile Success." >> /Volumes/frontrow/TwistedZero/TimeStamp
echo "" >> /Volumes/frontrow/TwistedZero/TimeStamp
else
echo "" >> /Volumes/frontrow/TwistedZero/TimeStamp
echo "-Kernel Compile Failed." >> /Volumes/frontrow/TwistedZero/TimeStamp
echo "" >> /Volumes/frontrow/TwistedZero/TimeStamp
fi
fi
fi
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
echo "Please Allow 30-45 Min." >> /Volumes/frontrow/TwistedZero/TimeStamp
cp -R /Volumes/frontrow/TwistedZero/TimeStamp /Volumes/frontrow/TwistedZero/BackStamp
else
echo "Compile Process Failed." > /Volumes/frontrow/TwistedZero/TimeStamp
echo "" >> /Volumes/frontrow/TwistedZero/TimeStamp
cat /Volumes/frontrow/TwistedZero/TimeStamp /Volumes/frontrow/TwistedZero/BackStamp > /Volumes/frontrow/TwistedZero/TempStamp
mv -f /Volumes/frontrow/TwistedZero/TempStamp /Volumes/frontrow/TwistedZero/TimeStamp
fi
elif ["$1" == "ace" ]; then
if [ -e /Volumes/android/android-tzb_ics4.0.1/out/target/product/ace/htc_mecha-ota-eng.TwistedZero.zip ]; then
cp -R /Volumes/android/android-tzb_ics4.0.1/out/target/product/ace/htc_ace-ota-eng.TwistedZero.zip /Users/TwistedZero/Dropbox/IceCreamSammy/htc_ace-ota-eng.TwistedZero.zip
fi
fi