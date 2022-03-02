#!/bin/bash
set -e 

./configure --prefix=/usr --disable-static --with-gcc-arch=native

make 

make check

make install

