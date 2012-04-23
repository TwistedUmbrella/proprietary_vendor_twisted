# Copyright (C) 2011 Twisted Playground

# This script is designed to compliment .bash_profile code to automate the build process by adding a typical shell command such as:
# function buildTwist { cd /Volumes/android/github-aosp_source/proprietary_vendor_twisted; ./build_twisted.sh $1 $2 $3; }
# This script is designed by Twisted Playground for use on MacOSX 10.7 but can be modified for other distributions of Mac and Linux

if cat /etc/issue | grep Ubuntu; then
    HANDLE=twistedumbrella
    ANDROIDREPO=~/Twisted-Playground
    DROIDGITHUB=~/Twisted-Playground.git
    BUILDDIR=~/android-tzb_ics4.0.1
    CCACHEBIN=prebuilt/linux-x86/ccache/ccache
    MECHASPEC=~/leanKernel-tbolt-ics
    SPADESPEC=~/htc-kernel-msm7x30
    SHOOTRSPEC=~/htc-kernel-msm8660
    TIAMATSPEC=~/cayniarb-8660-kernel
    USERLOCAL=/home/$HANDLE

else

    HANDLE=TwistedZero
    ANDROIDREPO=/Volumes/android/Twisted-Playground
    DROIDGITHUB=TwistedUmbrella/Twisted-Playground.git
    BUILDDIR=/Volumes/android/android-tzb_ics4.0.1
    CCACHEBIN=prebuilt/darwin-x86/ccache/ccache
    MECHASPEC=/Volumes/android/leanKernel-tbolt-ics
    SPADESPEC=/Volumes/android/htc-kernel-msm7x30
    SHOOTRSPEC=/Volumes/android/htc-kernel-msm8660
    TIAMATSPEC=/Volumes/android/cayniarb-8660-kernel
    USERLOCAL=/Users/$HANDLE
    DROPBOX=/Users/$HANDLE/Dropbox/IceCreamSammy

fi

    cd $ANDROIDREPO
    git checkout gh-pages
    cd $BUILDDIR

    specDevice() {

        PRODUCT=htc_$DEVICE
        PROPER=`echo $DEVICE | sed 's/\([a-z]\)\([a-zA-Z0-9]*\)/\u\1\2/g'`
        TIMESTAMP=$ANDROIDREPO/$PROPER/TimeStamp.html
        TEMPSTAMP=$ANDROIDREPO/$PROPER/TempStamp
        BACKSTAMP=$ANDROIDREPO/$PROPER/BackStamp

        source build/envsetup.sh
        export USE_CCACHE=1
        export CCACHE_DIR=$USERLOCAL/.ccache-$DEVICE
        $CCACHEBIN -M 40G
        COMPILED=`date`
        make otapackage -j4 TARGET_PRODUCT=$PRODUCT TARGET_BUILD_VARIANT=userdebug
        rm -R $CCACHE_DIR/*
        if [ -e $BUILDDIR/out/target/product/$DEVICE/$PRODUCT-ota-eng.$HANDLE.zip ]; then
            MD5STRING=`md5 /Volumes/android/android-tzb_ics4.0.1/out/target/product/$DEVICE/$PRODUCT-ota-eng.$HANDLE.zip | awk {'print $4'}`
            cp -R $BUILDDIR/out/target/product/$DEVICE/$PRODUCT-ota-eng.$HANDLE.zip $DROPBOX/$PRODUCT-ota-eng.$HANDLE.zip
            rm -R $TIMESTAMP
            echo '<html>'  > $TIMESTAMP
            echo '<head>' >> $TIMESTAMP
            echo '<META http-equiv="Pragma" content="no-cache">' >> $TIMESTAMP
            echo '<META http-equiv="Cache-Control" content="no-cache">' >> $TIMESTAMP
            echo '<META http-equiv="Pragma-directive" content="no-cache">' >> $TIMESTAMP
            echo '<META http-equiv="Cache-Directive" content="no-cache">' >> $TIMESTAMP
            echo '<META http-equiv="Expires" content="0">' >> $TIMESTAMP
            echo '<link rel="apple-touch-icon" href="../Modules/images/iphone.png" />' >> $TIMESTAMP
            echo '<link rel="shortcut icon" href="../Modules/images/favicon.ico" />' >> $TIMESTAMP
            echo '<meta name="HandheldFriendly" content="True">' >> $TIMESTAMP
            echo '<meta name="MobileOptimized" content="320">' >> $TIMESTAMP
            echo '<meta name="viewport" content="width=device-width, initial-scale=1.0">' >> $TIMESTAMP
            echo '<meta http-equiv="cleartype" content="on">' >> $TIMESTAMP
            echo '<script type="text/javascript">' >> $TIMESTAMP
            echo 'window.scrollTo(0, window.innerHeight)' >> $TIMESTAMP
            echo '</script>' >> $TIMESTAMP
            echo '<meta charset="UTF-8">' >> $TIMESTAMP
            echo '<title>'${PROPER}' TimeStamp - The Playground</title>' >> $TIMESTAMP
            echo '<link rel="stylesheet" href="http://code.jquery.com/mobile/1.1.0/jquery.mobile-1.1.0.min.css" />' >> $TIMESTAMP
            echo '<link rel="stylesheet" type="text/css" href="../Modules/css/accordion.css">' >> $TIMESTAMP
            echo '<script src="../Modules/js/libs/modernizr.custom.min.js"></script>'>> $TIMESTAMP
            echo '</head>'>> $TIMESTAMP
            echo '<body>' >> $TIMESTAMP
            echo '<div data-role="page" id="release-'$DEVICE'" data-add-back-btn="true" data-cache="never">' >> $TIMESTAMP
            echo '<div data-role="header" data-position="fixed" data-theme="b">' >> $TIMESTAMP
            echo '<img src="../Modules/images/banner.png" id="banner">' >> $TIMESTAMP
            echo '</div>' >> $TIMESTAMP
            echo '<div data-role="content">' >> $TIMESTAMP
            echo '<center><h3>' >> $TIMESTAMP
            echo "Latest Build Compiled:" >> $TIMESTAMP
            echo '<br>' >> $TIMESTAMP
            echo $COMPILED >> $TIMESTAMP
            echo '<p></p>' >> $TIMESTAMP
            echo "Notes About The Compile" >> $TIMESTAMP
            echo '<br>' >> $TIMESTAMP
            echo $changes >> $TIMESTAMP
            echo '<p></p>' >> $TIMESTAMP
            echo 'MD5: '$MD5STRING >> $TIMESTAMP
            echo '</h3></center>' >> $TIMESTAMP
            echo '</div>' >> $TIMESTAMP
            echo '<div data-role="footer" data-position="fixed" data-theme="b">' >> $TIMESTAMP
            echo '<h1><a href="http://twistedplayground.info" target="_blank"><img src="../Modules/images/webdesign.png" id="webdesign" width="200" height="30"/></a></h1>' >> $TIMESTAMP
            echo '</div>' >> $TIMESTAMP
            echo '</div>' >> $TIMESTAMP
            echo '<script src="http://code.jquery.com/jquery-1.7.1.min.js"></script>' >> $TIMESTAMP
            echo '<script src="http://code.jquery.com/mobile/1.1.0/jquery.mobile-1.1.0.min.js"></script>' >> $TIMESTAMP
            echo '<script src="http://cdn.jquerytools.org/1.2.6/all/jquery.tools.min.js"></script>' >> $TIMESTAMP
            echo '<script src="../Modules/js/libs/data-cache-never-min.js"></script>' >> $TIMESTAMP
            echo '</body>' >> $TIMESTAMP
            echo '</html>' >> $TIMESTAMP
            cd $ANDROIDREPO
            git push git@github.com:$DROIDGITHUB HEAD:gh-pages -f
            cd $BUILDDIR
        fi
    }

if [ "$1" != "" ]; then

    SELECTION=`echo $1 | awk '{print tolower($0)}'`
    export PROPER=`echo $SELECTION | sed 's/\([a-z]\)\([a-zA-Z0-9]*\)/\u\1\2/g'`
    if [ "$SELECTION" != "kernel" ]; then
        syncup=$2
        thing=$3
    fi

else

    echo "1. Shooter"
    echo "2. Mecha"
    echo "3. Ace"
    echo "4. Vivo"
    echo "5. Shared"
    echo "6. Kernel"
    echo "Please Choose: "
    read profile

    case $profile in
        1)
            SELECTION="shooter"
        ;;
        2)
            SELECTION="mecha"
        ;;
        3)
            SELECTION="ace"
        ;;
        4)
            SELECTION="vivo"
        ;;
        5)
            SELECTION="shared"
        ;;
        6)
            SELECTION="kernel"
        ;;
        *)
            SELECTION="invalid"
        ;;
    esac

    if [ "$SELECTION" != "kernel" ]; then
        echo "Sync Sources (y/n): "
        read syncup
        echo "Clobberin Time (y/n): "
        read thing
    fi

fi

if [ "$SELECTION" != "kernel" ]; then
    echo "Build Notes: "
    read changes
fi

if [ "$SELECTION" == "kernel" ]; then
    echo "Prebuilt (y/n): "
    read prebuilt
    echo "1. Shooter"
    echo "2. Mecha"
    echo "3. Ace"
    echo "4. Vivo"
    echo "5. Shared"
    echo "Please Choose: "
    read devicesel

    case $devicesel in
        1)
            kernel="shooter"
        ;;
        2)
            kernel="mecha"
        ;;
        3)
            kernel="ace"
        ;;
        4)
            kernel="vivo"
        ;;
        5)
            kernel="shared"
        ;;
    esac
    if [ "$kernel" == "shooter" ]; then
        cd $SHOOTRSPEC
        if [ "$prebuilt" == "y" ]; then
            ./buildKernel.sh 1 shooter
        else
            ./buildKernel.sh 0 shooter
        fi
    elif [ "$kernel" == "mecha" ]; then
        cd $MECHASPEC
        if [ "$prebuilt" == "y" ]; then
            ./buildKernel.sh 1 mecha
        else
            ./buildKernel.sh 0 mecha
        fi
    elif [ "$kernel" == "ace" ]; then
        cd $SPADESPEC
        if [ "$prebuilt" == "y" ]; then
            ./buildKernel.sh 1 ace
        else
            ./buildKernel.sh 0 ace
        fi
    elif [ "$kernel" == "vivo" ]; then
        cd $SPADESPEC
        if [ "$prebuilt" == "y" ]; then
            ./buildKernel.sh 1 vivo
        else
            ./buildKernel.sh 0 vivo
        fi
    elif [ "$kernel" == "shared" ]; then
        if [ "$prebuilt" == "y" ]; then
            cd $SHOOTRSPEC
            ./buildKernel.sh 1 shooter
            cd $MECHASPEC
            ./buildKernel.sh 1 mecha
            cd $SPADESPEC
            ./buildKernel.sh 1 ace
            ./buildKernel.sh 1 vivo
        else
            cd $SHOOTRSPEC
            ./buildKernel.sh 0 shooter
            cd $MECHASPEC
            ./buildKernel.sh 0 mecha
            cd $SPADESPEC
            ./buildKernel.sh 0 ace
            ./buildKernel.sh 0 vivo
        fi
    fi
    cd $BUILDDIR
elif [ "$SELECTION" != "invalid" ]; then
    if [ "$SELECTION" != "kernel" ]; then
        if [ "$syncup" != "n" ]; then
            repo sync
        fi
        if [ "$thing" == "y" ]; then
            export USE_CCACHE=1
            export CCACHE_DIR=$USERLOCAL/.ccache-$SELECTION
            $CCACHEBIN -M 40G
            make clobber -j8
            rm -R $CCACHE_DIR/*
        fi
        if [ "$SELECTION" != "shared" ]; then
            DEVICE=$SELECTION
            specDevice    
        else
            DEVICE="shooter"
            specDevice
            DEVICE="mecha"
            specDevice
            DEVICE="ace"
            specDevice
            DEVICE="vivo"
            specDevice
        fi
    fi
else
    echo "Available Device NOT Selected"
    echo "Sync Only Procedure Initiated"
    repo sync
    exit 1
fi
