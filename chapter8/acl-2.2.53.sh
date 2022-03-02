#!/bin/bash
set -e 

./configure --prefix=/usr           \
            --disable-static        \
            --libexecdir=/usr/lib   \
            --docdir=/usr/share/doc/acl-2.2.53

make

make install

mv -v /usr/lib/libacl.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libacl.so) /usr/lib/libacl.so

