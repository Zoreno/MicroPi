#!/bin/bash -e
#
# Fetch gcc-arm-none-eabi cross compiler and unpack it to ./cross-cc
#

wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2
tar xvf gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2
mv gcc-arm-none-eabi-10-2020-q4-major cross-cc
rm gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2