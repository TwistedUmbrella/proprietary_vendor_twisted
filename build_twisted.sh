# This script is designed to compliment .bash_profile code to automate the build process by adding a typical shell command such as:
# function buildTwist { echo "Ace or Mecha? "; read device; cd /Volumes/android/android-tzb_ics4.0.1/vendor/twisted; ./build_twisted.sh $device; }
# This script is designed by Twisted Playground for use on MacOSX 10.7 but can be modified for other distributions of Mac and Linux

HANDLE=TwistedZero
MTIMESTAMP=/Volumes/frontrow/$HANDLE/SourceBuilt/MechaTimeStamp
MTEMPSTAMP=/Volumes/frontrow/$HANDLE/SourceBuilt/MechaTempStamp
MBACKSTAMP=/Volumes/frontrow/$HANDLE/SourceBuilt/MechaBackStamp
ATIMESTAMP=/Volumes/frontrow/$HANDLE/SourceBuilt/AceTimeStamp
ATEMPSTAMP=/Volumes/frontrow/$HANDLE/SourceBuilt/AceTempStamp
ABACKSTAMP=/Volumes/frontrow/$HANDLE/SourceBuilt/AceBackStamp
BUILDDIR=/Volumes/android/android-tzb_ics4.0.1
CCACHEBIN=prebuilt/darwin-x86/ccache/ccache
KERNELSPEC=leanKernel-tbolt-ics
USERLOCAL=/Users/$HANDLE
DROPBOX=/Users/$HANDLE/Dropbox/IceCreamSammy

echo "Build Notes: "
read changes

if [ "$1" == "mecha" ]; then
    echo "Kernel (Y/n)? "
    read kernel
    echo "" > $MTIMESTAMP
    echo "New Compile Started:" >> $MTIMESTAMP
    date >> $MTIMESTAMP
    echo "Compile Information:" >> $MTIMESTAMP
    echo $changes >> $MTIMESTAMP
    cat $MBACKSTAMP $MTIMESTAMP > $MTEMPSTAMP
    mv -f $MTEMPSTAMP $MTIMESTAMP
    if [ "$kernel" == "Y" ]; then
        echo "Config Name? ";
        cd $BUILDDIR/kernel/$KERNELSPEC
        ls config
        read config
        ./buildlean.sh 1 $config

        if [ -e arch/arm/boot/zImage ]; then
            echo "" >> $MTIMESTAMP
            echo "Kernel Compile Success." >> $MTIMESTAMP
            echo "" >> $MTIMESTAMP
        else
            echo "" >> $MTIMESTAMP
            echo "-Kernel Compile Failed." >> $MTIMESTAMP
            echo "" >> $MTIMESTAMP
        fi
    fi
fi

if [ "$1" == "ace" ]; then
    echo "" > $ATIMESTAMP
    echo "New Compile Started:" >> $ATIMESTAMP
    date >> $ATIMESTAMP
    echo "Compile Information:" >> $ATIMESTAMP
    echo $changes >> $ATIMESTAMP
    cat $ABACKSTAMP $ATIMESTAMP > $ATEMPSTAMP
    mv -f $ATEMPSTAMP $ATIMESTAMP
fi

if [ "$1" == "shared" ]; then
    echo "" > $MTIMESTAMP
    echo "New Compile Started:" >> $MTIMESTAMP
    date >> $MTIMESTAMP
    echo "Compile Information:" >> $MTIMESTAMP
    echo $changes >> $MTIMESTAMP
    cat $MBACKSTAMP $MTIMESTAMP > $MTEMPSTAMP
    mv -f $MTEMPSTAMP $MTIMESTAMP
    echo "" > $ATIMESTAMP
    echo "New Compile Started:" >> $ATIMESTAMP
    date >> $ATIMESTAMP
    echo "Compile Information:" >> $ATIMESTAMP
    echo $changes >> $ATIMESTAMP
    cat $ABACKSTAMP $ATIMESTAMP > $ATEMPSTAMP
    mv -f $ATEMPSTAMP $ATIMESTAMP
fi

repo sync

cd $BUILDDIR
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
            echo "Latest Build Completed:" > $MTIMESTAMP
            date >> $MTIMESTAMP
            echo "Please Allow 30-45 Min." >> $MTIMESTAMP
            cp -R $MTIMESTAMP $MBACKSTAMP
        fi
        if [ "$1" == "ace" ]; then
            echo "Latest Build Completed:" > $ATIMESTAMP
            date >> $ATIMESTAMP
            echo "Please Allow 30-45 Min." >> $ATIMESTAMP
            cp -R $ATIMESTAMP $ABACKSTAMP
        fi
    else
        if [ "$1" == "mecha" ]; then
            echo "Compile Process Failed." > $MTIMESTAMP
            echo "" >> $MTIMESTAMP
            cat $MTIMESTAMP $MBACKSTAMP > $MTEMPSTAMP
            mv -f $MTEMPSTAMP $MTIMESTAMP
        fi
        if [ "$1" == "ace" ]; then
            echo "Compile Process Failed." > $ATIMESTAMP
            echo "" >> $ATIMESTAMP
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
        echo "Latest Build Completed:" > $MTIMESTAMP
        date >> $MTIMESTAMP
        echo "Please Allow 30-45 Min." >> $MTIMESTAMP
        cp -R $MTIMESTAMP $MBACKSTAMP
    else
        echo "Compile Process Failed." > $MTIMESTAMP
        echo "" >> $MTIMESTAMP
        cat $MTIMESTAMP $MBACKSTAMP > $MTEMPSTAMP
        mv -f $MTEMPSTAMP $MTIMESTAMP
    fi

    export USE_CCACHE=1
    export CCACHE_DIR=$USERLOCAL/.ccache
    $CCACHEBIN -M 40G
    make clean -j8
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
        echo "Latest Build Completed:" > $ATIMESTAMP
        date >> $ATIMESTAMP
        echo "Please Allow 30-45 Min." >> $ATIMESTAMP
        cp -R $ATIMESTAMP $ABACKSTAMP
    else
        echo "Compile Process Failed." > $ATIMESTAMP
        echo "" >> $ATIMESTAMP
        cat $ATIMESTAMP $ABACKSTAMP > $ATEMPSTAMP
        mv -f $ATEMPSTAMP $ATIMESTAMP
    fi

fi