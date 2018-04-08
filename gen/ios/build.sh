#!/bin/sh

#autodetect ios arch if not specified

if [ "$1" == "iphoneos" ]
then
if [ "$_64BIT" = "1" ]
then
export ARCH=arm64
else
export ARCH=armv7
fi
fi
if [ "$1" == "iphonesimulator" ]
then
if [ "$_64BIT" = "1" ]
then
export ARCH=x86_64
else
export ARCH=i386
fi
fi

if [ "$IOSARCH" != "" ]; then export ARCH=$IOSARCH;fi

xcodebuild -configuration Debug -sdk $1 -project $2/lib.xcodeproj -arch $ARCH CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO

cp $2/build/Debug-$1/lib.framework/lib $3