# This script is designed to compliment .bash_profile code to automate the build process by adding a typical shell command such as:
# function buildTwist { echo "Ace, Mecha, Shared?"; read device; cd /Volumes/android/android-tzb_ics4.0.1/vendor/twisted; ./build_twisted.sh $device; }
# This script is designed by Twisted Playground for use on MacOSX 10.7 but can be modified for other distributions of Mac and Linux

HANDLE=TwistedZero
ANDROIDREPO=/Volumes/android/github-aosp_source/android
MTIMESTAMP=$ANDROIDREPO/MechaTimeStamp.html
MTEMPSTAMP=$ANDROIDREPO/MechaTempStamp
MBACKSTAMP=$ANDROIDREPO/MechaBackStamp
ATIMESTAMP=$ANDROIDREPO/AceTimeStamp.html
ATEMPSTAMP=$ANDROIDREPO/AceTempStamp
ABACKSTAMP=$ANDROIDREPO/AceBackStamp
DROIDGITHUB=TwistedUmbrella/android.git
BUILDDIR=/Volumes/android/android-tzb_ics4.0.1
CCACHEBIN=prebuilt/darwin-x86/ccache/ccache
KERNELSPEC=leanKernel-tbolt-ics
USERLOCAL=/Users/$HANDLE
DROPBOX=/Users/$HANDLE/Dropbox/IceCreamSammy

cd $ANDROIDREPO
git checkout gh-pages
cd $BUILDDIR

echo "Build Notes: "
read changes

if [ "$1" == "mecha" ]; then
    echo "Kernel (Y/n)? "
    read kernel
    if [ "$kernel" == "Y" ]; then
        echo "Config Name? ";
        cd $BUILDDIR/kernel/$KERNELSPEC
        ls config
        read config
        ./buildlean.sh 1 $config $1
        if [ -e arch/arm/boot/zImage ]; then
            echo '<p></p>' >> $MTIMESTAMP
            echo '<center>' >> $MTIMESTAMP
            echo "Kernel Compile Success." >> $MTIMESTAMP
            echo '</center>' >> $MTIMESTAMP
            echo '<p></p>' >> $MTIMESTAMP
        fi
        cd $BUILDDIR
    fi
elif [ "$1" == "ace" ]; then
    echo "Kernel (Y/n)? "
    read kernel
    if [ "$kernel" == "Y" ]; then
        echo "Config Name? ";
        cd $BUILDDIR/kernel/$KERNELSPEC
        ls config
        read config
        ./buildlean.sh 1 $config $1
        cd $BUILDDIR
    fi
elif [ "$1" == "shared" ]; then
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

if [ "$1" != "shared" ]; then

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

    if [ -e $BUILDDIR/out/target/product/$1/htc_$1-ota-eng.$HANDLE.zip ]; then
        cp -R $BUILDDIR/out/target/product/$1/htc_$1-ota-eng.$HANDLE.zip $DROPBOX/htc_$1-ota-eng.$HANDLE.zip
        if [ "$1" == "mecha" ]; then
            rm -R $MTIMESTAMP
            echo '<center>' > $MTIMESTAMP
            echo "Latest Build Completed:" >> $MTIMESTAMP
            echo '<br>' >> $MTIMESTAMP
            date >> $MTIMESTAMP
            echo '<br>' >> $MTIMESTAMP
            echo "Please Allow 30-45 Min." >> $MTIMESTAMP
            echo '<br>' >> $MTIMESTAMP
            echo '<br>' >> $MTIMESTAMP
            echo "Notes About The Compile" >> $MTIMESTAMP
            echo '<br>' >> $MTIMESTAMP
            echo $changes >> $MTIMESTAMP
            echo '<p></p>' >> $MTIMESTAMP
            echo '<a href="http://db.tt/RICx4uEI">Download Experimental</a>' >> $MTIMESTAMP
            echo '<br>' >> $MTIMESTAMP
            echo '<a href="http://db.tt/7svQgn6F">Download Milestone</a>' >> $MTIMESTAMP
            echo '</center>' >> $MTIMESTAMP
            echo '<p></p>' >> $MTIMESTAMP
            if [ "$kernel" == "Y" ]; then
                if [ -e arch/arm/boot/zImage ]; then
                    echo '<p></p>' >> $MTIMESTAMP
                    echo '<center>' >> $MTIMESTAMP
                    echo "Kernel Compile Success." >> $MTIMESTAMP
                    echo '</center>' >> $MTIMESTAMP
                    echo '<p></p>' >> $MTIMESTAMP
                fi
            fi
            cp -R $MTIMESTAMP $MBACKSTAMP
        elif [ "$1" == "ace" ]; then
            rm -R $ATIMESTAMP
            echo '<center>' > $ATIMESTAMP
            echo "Latest Build Completed:" >> $ATIMESTAMP
            echo '<br>' >> $ATIMESTAMP
            date >> $ATIMESTAMP
            echo '<br>' >> $ATIMESTAMP
            echo "Please Allow 30-45 Min." >> $ATIMESTAMP
            echo '<br>' >> $ATIMESTAMP
            echo '<br>' >> $ATIMESTAMP
            echo "Notes About The Compile" >> $ATIMESTAMP
            echo '<br>' >> $ATIMESTAMP
            echo $changes >> $ATIMESTAMP
            echo '<p></p>' >> $ATIMESTAMP
            echo '<a href="http://db.tt/m2DXP3EZ">Download Experimental</a>' >> $ATIMESTAMP
            echo '</center>' >> $ATIMESTAMP
            echo '<p></p>' >> $ATIMESTAMP
            if [ "$kernel" == "Y" ]; then
                if [ -e arch/arm/boot/zImage ]; then
                    echo '<p></p>' >> $ATIMESTAMP
                    echo '<center>' >> $ATIMESTAMP
                    echo "Kernel Compile Success." >> $ATIMESTAMP
                    echo '</center>' >> $ATIMESTAMP
                    echo '<p></p>' >> $ATIMESTAMP
                fi
            fi
            cp -R $ATIMESTAMP $ABACKSTAMP
        fi
    git commit -a -m "Automated TimeStamp Update"
    git push git@github.com:$DROIDGITHUB HEAD:gh-pages
    fi

else

    source build/envsetup.sh
    lunch 6
    export USE_CCACHE=1
    export CCACHE_DIR=$USERLOCAL/.ccache
    $CCACHEBIN -M 40G
    make otapackage -j4
    rm -R $CCACHE_DIR/*
    if [ -e $BUILDDIR/out/target/product/mecha/htc_mecha-ota-eng.$HANDLE.zip ]; then
        cp -R $BUILDDIR/out/target/product/mecha/htc_mecha-ota-eng.$HANDLE.zip $DROPBOX/htc_mecha-ota-eng.$HANDLE.zip
        rm -R $MTIMESTAMP
        echo '<center>' > $MTIMESTAMP
        echo "Latest Build Completed:" >> $MTIMESTAMP
        echo '<br>' >> $MTIMESTAMP
        date >> $MTIMESTAMP
        echo '<br>' >> $MTIMESTAMP
        echo "Please Allow 30-45 Min." >> $MTIMESTAMP
        echo '<br>' >> $MTIMESTAMP
        echo '<br>' >> $MTIMESTAMP
        echo "Notes About The Compile" >> $MTIMESTAMP
        echo '<br>' >> $MTIMESTAMP
        echo $changes >> $MTIMESTAMP
        echo '<p></p>' >> $MTIMESTAMP
        echo '<a href="http://db.tt/RICx4uEI">Download Experimental</a>' >> $MTIMESTAMP
        echo '<br>' >> $MTIMESTAMP
        echo '<a href="http://db.tt/7svQgn6F">Download Milestone</a>' >> $ATIMESTAMP
        echo '</center>' >> $MTIMESTAMP
        echo '<p></p>' >> $MTIMESTAMP
        cp -R $MTIMESTAMP $MBACKSTAMP
        if [ "$kernel" == "Y" ]; then
            if [ -e arch/arm/boot/zImage ]; then
                echo '<p></p>' >> $MTIMESTAMP
                echo '<center>' >> $MTIMESTAMP
                echo "Kernel Compile Success." >> $MTIMESTAMP
                echo '</center>' >> $MTIMESTAMP
                echo '<p></p>' >> $MTIMESTAMP
            fi
        fi
    fi

    rm -R $CCACHE_DIR/*

    source build/envsetup.sh
    lunch 4
    export USE_CCACHE=1
    export CCACHE_DIR=$USERLOCAL/.ccache
    $CCACHEBIN -M 40G
    make otapackage -j4
    rm -R $CCACHE_DIR/*
    if [ -e $BUILDDIR/out/target/product/ace/htc_ace-ota-eng.$HANDLE.zip ]; then
        cp -R $BUILDDIR/out/target/product/ace/htc_ace-ota-eng.$HANDLE.zip $DROPBOX/htc_ace-ota-eng.$HANDLE.zip
        rm -R $ATIMESTAMP
        echo '<center>' > $ATIMESTAMP
        echo "Latest Build Completed:" >> $ATIMESTAMP
        echo '<br>' >> $ATIMESTAMP
        date >> $ATIMESTAMP
        echo '<br>' >> $ATIMESTAMP
        echo "Please Allow 30-45 Min." >> $ATIMESTAMP
        echo '<br>' >> $ATIMESTAMP
        echo '<br>' >> $ATIMESTAMP
        echo "Notes About The Compile" >> $ATIMESTAMP
        echo '<br>' >> $ATIMESTAMP
        echo $changes >> $ATIMESTAMP
        echo '<p></p>' >> $ATIMESTAMP
        echo '<a href="http://db.tt/m2DXP3EZ">Download Experimental</a>' >> $ATIMESTAMP
        echo '</center>' >> $ATIMESTAMP
        echo '<p></p>' >> $ATIMESTAMP
        cp -R $ATIMESTAMP $ABACKSTAMP
        if [ "$kernel" == "Y" ]; then
            if [ -e arch/arm/boot/zImage ]; then
                echo '<p></p>' >> $ATIMESTAMP
                echo '<center>' >> $ATIMESTAMP
                echo "Kernel Compile Success." >> $ATIMESTAMP
                echo '</center>' >> $ATIMESTAMP
                echo '<p></p>' >> $ATIMESTAMP
            fi
        fi
    fi
    git commit -a -m "Automated TimeStamp Update"
    git push git@github.com:$DROIDGITHUB HEAD:gh-pages

fi