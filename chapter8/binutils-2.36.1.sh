#!/bin/bash
set -e

res=$(expect -c "spawn ls")
rest=${res:0 :5}

if [ "$rest" == spawn ];
then 
    echo "pass" 
else
    exit
fi

sed -i '/@\tincremental_copy/d' gold/testsuite/Makefile.in

mkdir -v build
cd build

../configure    --prefix=/usr       \
                --enable-gold       \
                --enable-ld=default \
                --enable-plugins    \
                --enable-shared     \
                --disable-werror    \
                --enable-64-bit-bfd \
                --with-system-zlib

make tooldir=/usr

make -k check

make tooldir=/usr install

rm -fv /usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes}.a