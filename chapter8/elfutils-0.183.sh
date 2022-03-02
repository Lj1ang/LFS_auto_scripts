#!/bin/bash
set -e 

./configure --prefix=/usr                   \
            --disable-debuginfod            \
            --enable-libdebuginfod=dummy    \
            --libdir=/lib

make 

make check

make -C libelf install
install -vm644 config/libelf.pc /usr/lib/pkgconfig
rm /lib/libelf.a