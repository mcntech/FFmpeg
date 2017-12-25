#!/bin/bash
#Change NDK to your Android NDK location
NDK=/home/ramp/Android/Sdk/ndk-bundle
PLATFORM=$NDK/platforms/android-21/arch-arm64/
PREBUILT=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64

GENERAL="\
--enable-small \
--enable-cross-compile \
--extra-libs="-lgcc" \
--arch=aarch64 \
--cc=$PREBUILT/bin/aarch64-linux-android-gcc \
--cross-prefix=$PREBUILT/bin/aarch64-linux-android- \
--nm=$PREBUILT/bin/aarch64-linux-android-nm"

MODULES="--enable-gpl"



function build_arm64
{
  ./configure \
  --logfile=conflog.txt \
  --target-os=linux \
  --prefix=./ffmpeg_dist/android/arm64-v8a \
  ${GENERAL} \
  --sysroot=$PLATFORM \
  --extra-cflags="-I$NDK/sysroot/usr/include/ -I$NDK/sysroot/usr/include/aarch64-linux-android/" \
  --extra-ldflags="-Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog" \
  --disable-doc \
  ${MODULES} \
  --disable-everything \
  --disable-programs \
  --disable-devices \
  --enable-decoder=aac \
  --enable-decoder=ac3 \
  --enable-decoder=eac3 \
  --enable-decoder=mp1 \
  --enable-decoder=mp2 \
  --enable-parser=mpegaudio \
  --enable-parser=aac

  make clean
  make
  make install
}

build_arm64


echo Android ARM64 builds finished
