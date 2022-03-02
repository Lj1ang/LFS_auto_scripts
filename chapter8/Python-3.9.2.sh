#!/bin/bash
set -e 

./configure --prefix=/usr           \
            --enable-shared         \
            --with-system-expat     \
            --with-system-ffi       \
            --with-ensurepip=yes

make

make test

make install

install -v -dm755 /usr/share/doc/python-3.9.2/html

tar --strip-components=1                \
    --no-same-owner                     \
    --no-same-permissions               \
    -C /usr/share/doc/python-3.9.2/html \
    -xvf ../python-3.9.2-docs-html.tar.bz2

