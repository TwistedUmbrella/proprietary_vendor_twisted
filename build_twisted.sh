# This script is designed to compliment .bash_profile code to automate the build process by adding a typical shell command such as:
# function buildTwist { echo "Ace, Mecha, Shared?"; read device; cd /Volumes/android/android-tzb_ics4.0.1/vendor/twisted; ./build_twisted.sh $device; }
# This script is designed by Twisted Playground for use on MacOSX 10.7 but can be modified for other distributions of Mac and Linux

HANDLE=TwistedZero
MTIMESTAMP=/Volumes/frontrow/$HANDLE/SourceBuilt/MechaTimeStamp.html
MTEMPSTAMP=/Volumes/frontrow/$HANDLE/SourceBuilt/MechaTempStamp
MBACKSTAMP=/Volumes/frontrow/$HANDLE/SourceBuilt/MechaBackStamp
ATIMESTAMP=/Volumes/frontrow/$HANDLE/SourceBuilt/AceTimeStamp.html
ATEMPSTAMP=/Volumes/frontrow/$HANDLE/SourceBuilt/AceTempStamp
ABACKSTAMP=/Volumes/frontrow/$HANDLE/SourceBuilt/AceBackStamp
BUILDDIR=/Volumes/android/android-tzb_ics4.0.1
CCACHEBIN=prebuilt/darwin-x86/ccache/ccache
KERNELSPEC=leanKernel-tbolt-ics
USERLOCAL=/Users/$HANDLE
DROPBOX=/Users/$HANDLE/Dropbox/IceCreamSammy

cd $BUILDDIR

echo "Build Notes: "
read changes

if [ "$1" == "mecha" ]; then
    echo "Kernel (Y/n)? "
    read kernel
    echo '<center>' >> $MTIMESTAMP
    echo "New Compile Started:" >> $MTIMESTAMP
    echo '<br>' >> $MTIMESTAMP
    date >> $MTIMESTAMP
    echo '<br>' >> $MTIMESTAMP
    echo "Compile Information:" >> $MTIMESTAMP
    echo '<br>' >> $MTIMESTAMP
    echo $changes >> $MTIMESTAMP
    echo '</center>' >> $MTIMESTAMP
    cat $MBACKSTAMP $MTIMESTAMP > $MTEMPSTAMP
    mv -f $MTEMPSTAMP $MTIMESTAMP
    if [ "$kernel" == "Y" ]; then
        echo "Config Name? ";
        cd $BUILDDIR/kernel/$KERNELSPEC
        ls config
        read config
        ./buildlean.sh 1 $config $1
        echo '<p></p>' >> $MTIMESTAMP
        echo '<center>' >> $MTIMESTAMP
        if [ -e arch/arm/boot/zImage ]; then
            echo "Kernel Compile Success." >> $MTIMESTAMP
        else
            echo "-Kernel Compile Failed." >> $MTIMESTAMP
        fi
        echo '</center>' >> $MTIMESTAMP
        echo '<p></p>' >> $MTIMESTAMP
        cd $BUILDDIR
    fi
elif [ "$1" == "ace" ]; then
    echo "Kernel (Y/n)? "
    read kernel
    echo '<center>' >> $ATIMESTAMP
    echo "New Compile Started:" >> $ATIMESTAMP
    echo '<br>' >> $ATIMESTAMP
    date >> $ATIMESTAMP
    echo '<br>' >> $ATIMESTAMP
    echo "Compile Information:" >> $ATIMESTAMP
    echo '<br>' >> $ATIMESTAMP
    echo $changes >> $ATIMESTAMP
    echo '</center>' >> $ATIMESTAMP
    cat $ABACKSTAMP $ATIMESTAMP > $ATEMPSTAMP
    mv -f $ATEMPSTAMP $ATIMESTAMP
    if [ "$kernel" == "Y" ]; then
        echo "Config Name? ";
        cd $BUILDDIR/kernel/$KERNELSPEC
        ls config
        read config
        ./buildlean.sh 1 $config $1
        echo '<p></p>' >> $ATIMESTAMP
        echo '<center>' >> $ATIMESTAMP
        if [ -e arch/arm/boot/zImage ]; then
        echo "Kernel Compile Success." >> $ATIMESTAMP
        else
        echo "-Kernel Compile Failed." >> $ATIMESTAMP
        fi
        echo '</center>' >> $ATIMESTAMP
        echo '<p></p>' >> $ATIMESTAMP
        cd $BUILDDIR
    fi
elif [ "$1" == "shared" ]; then
    echo '<center>' >> $MTIMESTAMP
    echo "New Compile Started:" >> $MTIMESTAMP
    echo '<br>' >> $MTIMESTAMP
    date >> $MTIMESTAMP
    echo '<br>' >> $MTIMESTAMP
    echo "Compile Information:" >> $MTIMESTAMP
    echo '<br>' >> $MTIMESTAMP
    echo $changes >> $MTIMESTAMP
    echo '</center>' >> $MTIMESTAMP
    cat $MBACKSTAMP $MTIMESTAMP > $MTEMPSTAMP
    mv -f $MTEMPSTAMP $MTIMESTAMP
    echo '<center>' >> $ATIMESTAMP
    echo "New Compile Started:" >> $ATIMESTAMP
    echo '<br>' >> $ATIMESTAMP
    date >> $ATIMESTAMP
    echo '<br>' >> $ATIMESTAMP
    echo "Compile Information:" >> $ATIMESTAMP
    echo '<br>' >> $ATIMESTAMP
    echo $changes >> $ATIMESTAMP
    echo '</center>' >> $ATIMESTAMP
    cat $ABACKSTAMP $ATIMESTAMP > $ATEMPSTAMP
    mv -f $ATEMPSTAMP $ATIMESTAMP
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
            cp -R $MTIMESTAMP $MBACKSTAMP
        elif [ "$1" == "ace" ]; then
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
        fi
    else
        if [ "$1" == "mecha" ]; then
            echo '<center>' > $MTIMESTAMP
            echo "Compile Process Failed." >> $MTIMESTAMP
            echo '<p></p>' >> $MTIMESTAMP
            echo '<a href="http://db.tt/RICx4uEI">Previous Experimental</a>' >> $MTIMESTAMP
            echo '<br>' >> $MTIMESTAMP
            echo '<a href="http://db.tt/7svQgn6F">Download Milestone</a>' >> $MTIMESTAMP
            echo '</center>' >> $MTIMESTAMP
            echo '<p></p>' >> $MTIMESTAMP
            cat $MTIMESTAMP $MBACKSTAMP > $MTEMPSTAMP
            mv -f $MTEMPSTAMP $MTIMESTAMP
        elif [ "$1" == "ace" ]; then
            echo '<center>' > $ATIMESTAMP
            echo "Compile Process Failed." >> $ATIMESTAMP
            echo '<p></p>' >> $ATIMESTAMP
            echo '<a href="http://db.tt/m2DXP3EZ">Previous Experimental</a>' >> $ATIMESTAMP
            echo '</center>' >> $ATIMESTAMP
            echo '<p></p>' >> $ATIMESTAMP
            cat $ATIMESTAMP $ABACKSTAMP > $ATEMPSTAMP
            mv -f $ATEMPSTAMP $ATIMESTAMP
        fi
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
    else
        echo '<center>' > $MTIMESTAMP
        echo "Compile Process Failed." >> $MTIMESTAMP
        echo '<p></p>' >> $MTIMESTAMP
        echo '<a href="http://db.tt/RICx4uEI">Previous Experimental</a>' >> $MTIMESTAMP
        echo '<br>' >> $MTIMESTAMP
        echo '<a href="http://db.tt/7svQgn6F">Download Milestone</a>' >> $MTIMESTAMP
        echo '</center>' >> $MTIMESTAMP
        echo '<p></p>' >> $MTIMESTAMP
        cat $MTIMESTAMP $MBACKSTAMP > $MTEMPSTAMP
        mv -f $MTEMPSTAMP $MTIMESTAMP
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
    else
        echo '<center>' > $ATIMESTAMP
        echo "Compile Process Failed." >> $ATIMESTAMP
        echo '<p></p>' >> $ATIMESTAMP
        echo '<a href="http://db.tt/m2DXP3EZ">Previous Experimental</a>' >> $ATIMESTAMP
        echo '</center>' >> $ATIMESTAMP
        echo '<p></p>' >> $ATIMESTAMP
        cat $ATIMESTAMP $ABACKSTAMP > $ATEMPSTAMP
        mv -f $ATEMPSTAMP $ATIMESTAMP
    fi

fi