# This script is designed to compliment .bash_profile code to automate the build process by adding a typical shell command such as:
# function buildTwist { echo "Ace or Mecha? "; read device; cd /Volumes/android/android-tzb_ics4.0.1/vendor/twisted; ./build_twisted.sh $device; }
# This script is designed by Twisted Playground for use on MacOSX 10.7 but can be modified for other distributions of Mac and Linux

HANDLE=TwistedZero
TIMESTAMP=/Volumes/frontrow/$HANDLE/TimeStamp
TEMPSTAMP=/Volumes/frontrow/$HANDLE/TempStamp
BACKSTAMP=/Volumes/frontrow/$HANDLE/BackStamp
BUILDDIR=/Volumes/android/android-tzb_ics4.0.1
CCACHEBIN=prebuilt/darwin-x86/ccache/ccache
KERNELSPEC=leanKernel-tbolt-ics
USERLOCAL=/Users/$HANDLE
DROPBOX=/Users/$HANDLE/Dropbox/IceCreamSammy

if [ "$1" == "mecha" ]; then
echo "Kernel (Y/n)? "
read kernel
echo "Build Notes: "
read changes
echo "" > $TIMESTAMP
echo "New Compile Started:" >> $TIMESTAMP
date >> $TIMESTAMP
echo "Compile Information:" >> $TIMESTAMP
echo $changes >> $TIMESTAMP
cat $BACKSTAMP $TIMESTAMP > $TEMPSTAMP
mv -f $TEMPSTAMP $TIMESTAMP

if [ "$kernel" == "Y" ]; then
echo "Config Name? ";
cd $BUILDDIR/kernel/$KERNELSPEC
ls config
read config
./buildlean.sh 1 $config

if [ -e arch/arm/boot/zImage ]; then
echo "" >> $TIMESTAMP
echo "Kernel Compile Success." >> $TIMESTAMP
echo "" >> $TIMESTAMP
else
echo "" >> $TIMESTAMP
echo "-Kernel Compile Failed." >> $TIMESTAMP
echo "" >> $TIMESTAMP
fi

fi

fi

repo sync

cd $BUILDDIR
export USE_CCACHE=1
export CCACHE_DIR=$USERLOCAL/.ccache
$CCACHEBIN -M 40G
make clean -j8
rm -R $CCACHE_DIR/*
source build/envsetup.sh
if [ "$1" == "mecha" ]; then
lunch 6
elif [ "$1" == "ace" ]; then
lunch 4
fi
export USE_CCACHE=1
export CCACHE_DIR=$USERLOCAL/.ccache
$CCACHEBIN -M 40G
make otapackage -j4
rm -R $CCACHE_DIR/*
if [ "$1" == "mecha" ]; then
if [ -e $BUILDDIR/out/target/product/mecha/htc_mecha-ota-eng.$HANDLE.zip ]; then
cp -R $BUILDDIR/out/target/product/mecha/htc_mecha-ota-eng.$HANDLE.zip $DROPBOX/htc_mecha-ota-eng.$HANDLE.zip
echo "Latest Build Completed:" > $TIMESTAMP
date >> $TIMESTAMP
echo "Please Allow 30-45 Min." >> $TIMESTAMP
cp -R $TIMESTAMP $BACKSTAMP
else
echo "Compile Process Failed." > $TIMESTAMP
echo "" >> $TIMESTAMP
cat $TIMESTAMP $BACKSTAMP > $TEMPSTAMP
mv -f $TEMPSTAMP $TIMESTAMP
fi
elif ["$1" == "ace" ]; then
if [ -e $BUILDDIR/out/target/product/ace/htc_ace-ota-eng.$HANDLE.zip ]; then
cp -R $BUILDDIR/out/target/product/ace/htc_ace-ota-eng.$HANDLE.zip $DROPBOX/htc_ace-ota-eng.$HANDLE.zip
fi
fi