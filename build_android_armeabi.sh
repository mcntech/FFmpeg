#!/bin/bash
#Change NDK to your Android NDK location
NDK=/home/ramp/Android/Sdk/ndk-bundle
PLATFORM=$NDK/platforms/android-21/arch-arm/
PREBUILT=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64

GENERAL="\
--enable-small \
--enable-cross-compile \
--extra-libs="-lgcc" \
--arch=arm \
--cc=$PREBUILT/bin/arm-linux-androideabi-gcc \
--cross-prefix=$PREBUILT/bin/arm-linux-androideabi- \
--nm=$PREBUILT/bin/arm-linux-androideabi-nm"

MODULES="\
--enable-gpl"

function build_ARMv6
{
  ./configure \
  --target-os=linux \
  --prefix=./ffmpeg_dist/android/armeabi \
  ${GENERAL} \
  --sysroot=$PLATFORM \
  --extra-cflags="-I$NDK/sysroot/usr/include/ -I$NDK/sysroot/usr/include/arm-linux-androideabi/  -O3 -fpic -fasm -Wno-psabi -fno-short-enums -fno-strict-aliasing -finline-limit=300 -mfloat-abi=softfp -mfpu=vfp -marm -march=armv6" \
  --extra-ldflags="-Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog" \
  --enable-zlib \
  ${MODULES} \
  --disable-doc \
  --enable-neon \
  --disable-everything \
  --disable-programs \
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



build_ARMv6

echo Android ARMEABI builds finished
