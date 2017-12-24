#!/bin/bash
#Change NDK to your Android NDK location

MODULES="--enable-gpl"



function build_x86_64
{
  ./configure \
  --logfile=conflog.txt \
  --target-os=linux \
  --prefix=./x86/64bit \
  --disable-doc \
  ${MODULES} \
  --disable-everything \
  --disable-programs \
  --disable-x86asm \
  --disable-optimizations \
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

build_x86_64


echo x86 64 builds finished
