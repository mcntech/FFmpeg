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

function build_ARMv7
{
  ./configure \
  --target-os=linux \
  --prefix=./ffmpeg_dist/android/armeabi-v7a \
  ${GENERAL} \
  --sysroot=$PLATFORM \
  --extra-cflags="-I$NDK/sysroot/usr/include/ -I$NDK/sysroot/usr/include/arm-linux-androideabi/  -DANDROID -fPIC -ffunction-sections -funwind-tables -fstack-protector -march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16 -fomit-frame-pointer -fstrict-aliasing -funswitch-loops -finline-limit=300" \
  --extra-ldflags="-Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog" \
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

build_ARMv7
echo Android ARMv7-a builds finished
