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
    SHOOTRSPEC=~/toastcfh-8660-kernel
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
    SHOOTRSPEC=/Volumes/android/toastcfh-8660-kernel
    TIAMATSPEC=/Volumes/android/cayniarb-8660-kernel
    USERLOCAL=/Users/$HANDLE
    DROPBOX=/Users/$HANDLE/Dropbox/IceCreamSammy

fi

    cd $ANDROIDREPO
    git checkout gh-pages
    cd $BUILDDIR

    specKernel() {
        PROPER=`echo $SELECTION | sed 's/\([a-z]\)\([a-zA-Z0-9]*\)/\u\1\2/g'`
        echo $PROPER "Kernel (y/n)? "
        read kernel
        if [ "$kernel" == "y" ]; then

        TIMESTAMP=$ANDROIDREPO/$PROPER/TimeStamp.html

            if [ "$SELECTION" == "mecha" ]; then
                cd $MECHASPEC
                ./buildKernel.sh 1 $SELECTION
                if [ -e arch/arm/boot/zImage ]; then
                    echo '<p></p>' >> $TIMESTAMP
                    echo '<center>' >> $TIMESTAMP
                    echo "Kernel Compile Success." >> $TIMESTAMP
                    echo '</center>' >> $TIMESTAMP
                    echo '<p></p>' >> $TIMESTAMP
                fi
            fi

            if [ "$SELECTION" == "ace" ]; then
                cd $SPADESPEC
                ./buildKernel.sh 1 $SELECTION
                if [ -e arch/arm/boot/zImage ]; then
                    echo '<p></p>' >> $TIMESTAMP
                    echo '<center>' >> $TIMESTAMP
                    echo "Kernel Compile Success." >> $TIMESTAMP
                    echo '</center>' >> $TIMESTAMP
                    echo '<p></p>' >> $TIMESTAMP
                fi
            fi

            if [ "$SELECTION" == "shooter" ]; then
                echo "Tiamat Version (y/n)? "
                read subversion
                if [ "$subversion" == "y" ]; then
                    cd $TIAMATSPEC
                else
                    cd $SHOOTRSPEC
                fi
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
        PRODUCT=htc_$DEVICE

        PROPER=`echo $DEVICE | sed 's/\([a-z]\)\([a-zA-Z0-9]*\)/\u\1\2/g'`
        TIMESTAMP=$ANDROIDREPO/$PROPER/TimeStamp.html
        TEMPSTAMP=$ANDROIDREPO/$PROPER/TempStamp
        BACKSTAMP=$ANDROIDREPO/$PROPER/BackStamp
        source build/envsetup.sh
        export USE_CCACHE=1
        export CCACHE_DIR=$USERLOCAL/.ccache-$DEVICE
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
            if [ "$kernel" == "y" ]; then
                if [ -e arch/arm/boot/zImage ]; then
                    echo "Updated Prebuilt Device Kernel" >> $TIMESTAMP
                    echo '<p></p>' >> $TIMESTAMP
                fi
            fi
            echo '<p></p>' >> $TIMESTAMP
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

if [ "$1" != "" ]; then

    SELECTION=`echo $1 | awk '{print tolower($0)}'`
    if [ "$SELECTION" != "kernel" ]; then
        syncup=$2
        thing=$3
    fi

else

    echo "1. Shooter"
    echo "2. Ace"
    echo "3. Mecha"
    echo "4. Shared"
    echo "5. Kernel"
    echo "Please Choose: "
    read profile

    case $profile in
        1)
            SELECTION="shooter"
        ;;
        2)
            SELECTION="ace"
        ;;
        3)
            SELECTION="mecha"
        ;;
        4)
            SELECTION="shared"
        ;;
        5)
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
        echo "2. Ace"
        echo "3. Mecha"
        echo "4. Shared"
        echo "Please Choose: "
        read devicesel

        case $devicesel in
            1)
                kernel="shooter"
            ;;
            2)
                kernel="ace"
            ;;
            3)
                kernel="mecha"
            ;;
            4)
                kernel="shared"
            ;;
        esac
        if [ "$kernel" == "shooter" ]; then
            echo "Tiamat Version (y/n)? "
            read subversion
            if [ "$subversion" == "y" ]; then
                cd $TIAMATSPEC
            else
                cd $SHOOTRSPEC
            fi
            if [ "$prebuilt" == "y" ]; then
                ./buildKernel.sh 1 shooter
            else
                ./buildKernel.sh
            fi
        elif [ "$kernel" == "mecha" ]; then
            cd $MECHASPEC
            if [ "$prebuilt" == "y" ]; then
                ./buildKernel.sh 1 mecha
            else
                ./buildKernel.sh
            fi
        elif [ "$kernel" == "ace" ]; then
            cd $SPADESPEC
            if [ "$prebuilt" == "y" ]; then
                ./buildKernel.sh 1 ace
            else
                ./buildKernel.sh
            fi
        elif [ "$kernel" == "shared" ]; then
            if [ "$prebuilt" == "y" ]; then
                echo "Tiamat Version (y/n)? "
                read subversion
                if [ "$subversion" == "y" ]; then
                    cd $TIAMATSPEC
                else
                    cd $SHOOTRSPEC
                fi
                ./buildKernel.sh 1 shooter
                cd $MECHASPEC
                ./buildKernel.sh 1 mecha
                cd $SPADESPEC
                ./buildKernel.sh 1 ace
            else
                echo "Tiamat Version (y/n)? "
                read subversion
                if [ "$subversion" == "y" ]; then
                    cd $TIAMATSPEC
                else
                    cd $SHOOTRSPEC
                fi
                ./buildKernel.sh
                cd $MECHASPEC
                ./buildKernel.sh
                cd $SPADESPEC
                ./buildKernel.sh
            fi
        fi
        cd $BUILDDIR
    elif [ "$SELECTION" != "invalid" ]; then
        specKernel
    else
        echo "Available Device NOT Selected"
        echo "Sync Only Procedure Initiated"
        repo sync
        exit 1
    fi
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
        fi
    fi
