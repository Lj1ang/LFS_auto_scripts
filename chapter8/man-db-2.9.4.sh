#!/bin/bash
set -e

sed -i '/find/s@/usr@@' init/systemd/man-db.service.in
./configure --prefix=/usr                           \
            --docdir=/usr/share/doc/man-db-2.9.4    \
            --sysconfdir=/etc                       \
            --disable-setuid                        \
            --enable-cache-owner=bin                \
            --with-browser=/usr/bin/lynx            \
            --with-vgrind=/usr/bin/vgrind           \
            --with-grap=/usr/bin/grap

make 

make check

make install
                
