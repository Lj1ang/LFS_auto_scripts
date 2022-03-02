#!/bin/bash
set -e 

sed -i "s/''/etags/" t/tags-lisp-space.sh

./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.16.3

make 

make -j4 check

make install

