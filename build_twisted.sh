# Copyright (C) 2011 Twisted Playground

# This script is designed to compliment .bash_profile code to automate the build process by adding a typical shell command such as:
# function buildTwist { echo "Ace, Mecha, Shared?"; read device; cd /Volumes/android/github-aosp_source/proprietary_vendor_twisted; ./build_twisted.sh $device; }
# This script is designed by Twisted Playground for use on MacOSX 10.7 but can be modified for other distributions of Mac and Linux

HANDLE=TwistedZero
ANDROIDREPO=/Volumes/android/github-aosp_source/android
DROIDGITHUB=TwistedUmbrella/android.git
BUILDDIR=/Volumes/android/android-tzb_ics4.0.1
CCACHEBIN=prebuilt/darwin-x86/ccache/ccache
KERNELSPEC=leanKernel-tbolt-ics
USERLOCAL=/Users/$HANDLE
DROPBOX=/Users/$HANDLE/Dropbox/IceCreamSammy

cd $ANDROIDREPO
git checkout gh-pages
cd $BUILDDIR

specKernel() {
    echo "Kernel (Y/n)? "
    read kernel
    if [ "$kernel" == "Y" ]; then
        cd $BUILDDIR/kernel/$KERNELSPEC
        ./buildlean.sh 1 $1
        if [ -e arch/arm/boot/zImage ]; then
            echo '<p></p>' >> $TIMESTAMP
            echo '<center>' >> $TIMESTAMP
            echo "Kernel Compile Success." >> $TIMESTAMP
            echo '</center>' >> $TIMESTAMP
            echo '<p></p>' >> $TIMESTAMP
        fi
        cd $BUILDDIR
    fi
}

specDevice() {

    HANDLE=TwistedZero
    PROPER=`echo $DEVICE | sed 's/\([a-z]\)\([a-zA-Z0-9]*\)/\u\1\2/g'`
    TIMESTAMP=$ANDROIDREPO/$PROPER/TimeStamp.html
    TEMPSTAMP=$ANDROIDREPO/$PROPER/TempStamp
    BACKSTAMP=$ANDROIDREPO/$PROPER/BackStamp

    source build/envsetup.sh
    export USE_CCACHE=1
    export CCACHE_DIR=$USERLOCAL/.ccache
    $CCACHEBIN -M 40G
    make otapackage -j4 TARGET_PRODUCT=htc_$DEVICE TARGET_BUILD_VARIANT=userdebug
    rm -R $CCACHE_DIR/*

    if [ -e $BUILDDIR/out/target/product/$DEVICE/htc_$DEVICE-ota-eng.$HANDLE.zip ]; then
        MD5STRING=`md5 /Volumes/android/android-tzb_ics4.0.1/out/target/product/$DEVICE/htc_$DEVICE-ota-eng.$HANDLE.zip | awk {'print $4'}`
        cp -R $BUILDDIR/out/target/product/$DEVICE/htc_$DEVICE-ota-eng.$HANDLE.zip $DROPBOX/htc_$DEVICE-ota-eng.$HANDLE.zip
        rm -R $TIMESTAMP
        echo '<center>' > $TIMESTAMP
        echo "Latest Build Completed:" >> $TIMESTAMP
        echo '<br>' >> $TIMESTAMP
        date >> $TIMESTAMP
        echo '<br>' >> $TIMESTAMP
        echo "Please Allow 30-45 Min." >> $TIMESTAMP
        echo '<br>' >> $TIMESTAMP
        echo '<br>' >> $TIMESTAMP
        echo "Notes About The Compile" >> $TIMESTAMP
        echo '<br>' >> $TIMESTAMP
        echo $changes >> $TIMESTAMP
        echo '<p></p>' >> $TIMESTAMP
        if [ "$DEVICE" == "mecha" ]; then
            MD5STRINGM=`md5 $DROPBOX/htc_$DEVICE-ota-eng.$HANDLE-Milestone.zip | awk {'print $4'}`
            echo '<a href="http://db.tt/7svQgn6F">Download Milestone</a>' >> $TIMESTAMP
            echo '<br>' >> $TIMESTAMP
            echo 'MD5: '$MD5STRINGM >> $TIMESTAMP
            echo '<br><br>' >> $TIMESTAMP
            echo '<a href="http://db.tt/RICx4uEI">Download Experimental</a>' >> $TIMESTAMP
        elif [ "$DEVICE" == "ace" ]; then
            echo '<a href="http://db.tt/dAJtkNlG">Download Experimental</a>' >> $TIMESTAMP
        fi
        echo '<br>' >> $TIMESTAMP
        echo 'MD5: '$MD5STRING >> $TIMESTAMP
        echo '</center>' >> $TIMESTAMP
        if [ "$kernel" == "Y" ]; then
            if [ -e arch/arm/boot/zImage ]; then
                echo '<p></p>' >> $TIMESTAMP
                echo '<center>' >> $TIMESTAMP
                echo "Kernel Compile Success." >> $TIMESTAMP
                echo '</center>' >> $TIMESTAMP
                echo '<p></p>' >> $TIMESTAMP
            fi
        fi
        cd $ANDROIDREPO
        git commit -a -m 'Automated TimeStamp Update - '${PROPER}''
        git push git@github.com:$DROIDGITHUB HEAD:gh-pages
        cd $BUILDDIR
    fi
}


echo "Build Notes: "
read changes

SELECTION=`echo $1 | awk '{print tolower($0)}'`
if [ "$SELECTION" == "mecha" ]; then
    specKernel
elif [ "$SELECTION" == "ace" ]; then
    specKernel
elif [ "$SELECTION" == "shared" ]; then
    echo "Kernel Compiling Unavailable!"
else
    echo "Available Device NOT Selected"
    echo "Sync Only Procedure Initiated"
    repo sync
    exit 1
fi

repo sync

export USE_CCACHE=1
export CCACHE_DIR=$USERLOCAL/.ccache
$CCACHEBIN -M 40G
make clean -j8
rm -R $CCACHE_DIR/*

if [ "$SELECTION" != "shared" ]; then
    DEVICE=$1
    specDevice    
else
    DEVICE="mecha"
    specDevice
    DEVICE="ace"
    specDevice
fi