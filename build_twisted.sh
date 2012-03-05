# Copyright (C) 2011 Twisted Playground

# This script is designed to compliment .bash_profile code to automate the build process by adding a typical shell command such as:
# function buildTwist { echo "Shooter, Ace, Mecha, Sholes, Droid2, Shared?"; read device; cd /Volumes/android/github-aosp_source/proprietary_vendor_twisted; ./build_twisted.sh $device; }
# This script is designed by Twisted Playground for use on MacOSX 10.7 but can be modified for other distributions of Mac and Linux

HANDLE=TwistedZero
ANDROIDREPO=/Volumes/android/Twisted-Playground
DROIDGITHUB=TwistedUmbrella/Twisted-Playground.git
BUILDDIR=/Volumes/android/android-tzb_ics4.0.1
CCACHEBIN=prebuilt/darwin-x86/ccache/ccache
MECHASPEC=leanKernel-tbolt-ics
SPADESPEC=LorDmodUE-ace-ics
SHOLESPEC=android_kernel_omap
USERLOCAL=/Users/$HANDLE
DROPBOX=/Users/$HANDLE/Dropbox/IceCreamSammy
MECHAEXP=http://db.tt/4i4d3nVA
SPADEEXP=http://db.tt/yaLRYRgv
SHOLESEXP=http://db.tt/G4LdTxv2
DROID2EXP=http://db.tt/i0Rq1sZT
SHOOTREXP=http://builds.twistedplayground.info

cd $ANDROIDREPO
git checkout gh-pages
cd $BUILDDIR

specKernel() {
    echo "Kernel (Y/n)? "
    read kernel
    if [ "$kernel" == "Y" ]; then

    PROPER=`echo $SELECTION | sed 's/\([a-z]\)\([a-zA-Z0-9]*\)/\u\1\2/g'`
    TIMESTAMP=$ANDROIDREPO/$PROPER/TimeStamp.html

        if [ "$SELECTION" == "mecha" ]; then
            cd $BUILDDIR/kernel/$MECHASPEC
            ./buildlean.sh 1 $SELECTION
            if [ -e arch/arm/boot/zImage ]; then
                echo '<p></p>' >> $TIMESTAMP
                echo '<center>' >> $TIMESTAMP
                echo "Kernel Compile Success." >> $TIMESTAMP
                echo '</center>' >> $TIMESTAMP
                echo '<p></p>' >> $TIMESTAMP
            fi
        fi

        if [ "$SELECTION" == "ace" ]; then
            cd $BUILDDIR/kernel/$SPADESPEC
            ./buildKernel.sh 1 $SELECTION
            if [ -e arch/arm/boot/zImage ]; then
                echo '<p></p>' >> $TIMESTAMP
                echo '<center>' >> $TIMESTAMP
                echo "Kernel Compile Success." >> $TIMESTAMP
                echo '</center>' >> $TIMESTAMP
                echo '<p></p>' >> $TIMESTAMP
            fi
        fi

        if [ "$SELECTION" == "sholes" ]; then
            cd $BUILDDIR/kernel/$SHOLESPEC
            ./buildKernel.sh 1 $SELECTION
            if [ -e arch/arm/boot/zImage ]; then
                echo '<p></p>' >> $TIMESTAMP
                echo '<center>' >> $TIMESTAMP
                echo "Kernel Compile Success." >> $TIMESTAMP
                echo '</center>' >> $TIMESTAMP
                echo '<p></p>' >> $TIMESTAMP
            fi
        fi

        cd $BUILDDIR

    fi
}
specDevice() {
    HANDLE=TwistedZero
    if [ "$DEVICE" == "sholes" ]; then
        PRODUCT=moto_$DEVICE
    elif [ "$DEVICE" == "droid2" ]; then
        PRODUCT=moto_$DEVICE
    else
        PRODUCT=htc_$DEVICE
    fi
    PROPER=`echo $DEVICE | sed 's/\([a-z]\)\([a-zA-Z0-9]*\)/\u\1\2/g'`
    TIMESTAMP=$ANDROIDREPO/$PROPER/TimeStamp.html
    TEMPSTAMP=$ANDROIDREPO/$PROPER/TempStamp
    BACKSTAMP=$ANDROIDREPO/$PROPER/BackStamp
    source build/envsetup.sh
    export USE_CCACHE=1
    export CCACHE_DIR=$USERLOCAL/.ccache
    $CCACHEBIN -M 40G
    make otapackage -j4 TARGET_PRODUCT=$PRODUCT TARGET_BUILD_VARIANT=userdebug
    rm -R $CCACHE_DIR/*
    if [ -e $BUILDDIR/out/target/product/$DEVICE/$PRODUCT-ota-eng.$HANDLE.zip ]; then
        MD5STRING=`md5 /Volumes/android/android-tzb_ics4.0.1/out/target/product/$DEVICE/$PRODUCT-ota-eng.$HANDLE.zip | awk {'print $4'}`
        cp -R $BUILDDIR/out/target/product/$DEVICE/$PRODUCT-ota-eng.$HANDLE.zip $DROPBOX/$PRODUCT-ota-eng.$HANDLE.zip
        rm -R $TIMESTAMP
        echo '<html>'  > $TIMESTAMP
        echo '<head>' >> $TIMESTAMP
        echo '<!--  Mobile viewport optimized: j.mp/bplateviewport -->' >> $TIMESTAMP
        echo '<meta name="HandheldFriendly" content="True">' >> $TIMESTAMP
        echo '<meta name="MobileOptimized" content="320"/>' >> $TIMESTAMP
        echo '<meta name="viewport" content="width=device-width, initial-scale=1.0">' >> $TIMESTAMP
        echo '<!-- Mobile IE needs ClearType for smoothing fonts -->' >> $TIMESTAMP
        echo '<meta http-equiv="cleartype" content="on">' >> $TIMESTAMP
        echo '<title>'${PROPER}' TimeStamp - Playground ICS</title>' >> $TIMESTAMP
        echo '</head>'>> $TIMESTAMP
        echo '<body>' >> $TIMESTAMP
        echo '<center>' >> $TIMESTAMP
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
        if [ "$kernel" == "Y" ]; then
            if [ -e arch/arm/boot/zImage ]; then
                echo "Updated Prebuilt Device Kernel" >> $TIMESTAMP
                echo '<p></p>' >> $TIMESTAMP
            fi
        fi
        echo '<p></p>' >> $TIMESTAMP
        if [ "$DEVICE" == "mecha" ]; then
            echo '<br><br>' >> $TIMESTAMP
            echo '<a href="'$MECHAEXP'">Download Experimental</a>' >> $TIMESTAMP
        elif [ "$DEVICE" == "ace" ]; then
            echo '<a href="'$SPADEEXP'">Download Experimental</a>' >> $TIMESTAMP
        elif [ "$DEVICE" == "sholes" ]; then
            echo '<a href="'$SHOLESEXP'">Download Experimental</a>' >> $TIMESTAMP
            echo '<br>Google Apps Separate' >> $TIMESTAMP
        elif [ "$DEVICE" == "droid2" ]; then
            echo '<a href="'$DROID2EXP'">Download Experimental</a>' >> $TIMESTAMP
        elif [ "$DEVICE" == "shooter" ]; then
            echo '<a href="'$SHOOTREXP'">Download Experimental</a>' >> $TIMESTAMP
        fi
        echo '<br>' >> $TIMESTAMP
        echo 'MD5: '$MD5STRING >> $TIMESTAMP
        echo '</center>' >> $TIMESTAMP
        echo '</body>' >> $TIMESTAMP
        echo '</html>' >> $TIMESTAMP
        cd $ANDROIDREPO
        git commit -a -m 'Automated TimeStamp Update - '${PROPER}''
        git push git@github.com:$DROIDGITHUB HEAD:gh-pages -f
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
elif [ "$SELECTION" == "sholes" ]; then
    specKernel
elif [ "$SELECTION" == "droid2" ]; then
    echo "Kernel Compiling Unavailable!"
elif [ "$SELECTION" == "shooter" ]; then
    echo "Kernel Compiling Unavailable!"
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
make clobber -j8
rm -R $CCACHE_DIR/*
if [ "$SELECTION" != "shared" ]; then
    DEVICE=$SELECTION
    specDevice    
else
    DEVICE="mecha"
    specDevice
    DEVICE="ace"
    specDevice
fi
