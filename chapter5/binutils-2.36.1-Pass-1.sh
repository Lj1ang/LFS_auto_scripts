#!/bin/sh
set -e

#binutils-2.36.1-Pass-1
mkdir -v build
cd build

../configure --prefix=$LFS/tools    \
    --with-sysroot=$LFS                 \
    --target=$LFS_TGT                   \
    --disable-nls                       \
    --disable-werror

make && make install
