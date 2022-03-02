#!/bin/bash
set -e

./configure ADJTIME_PATH=/var/lib/hwclock/adjtime       \
            --docdir=/usr/share/doc/util-linux-2.36.2   \
            --disable-chfn-chsh                         \
            --disable-login                             \
            --disable-nologin                           \
            --disable-su                                \
            --disable-setpriv                           \
            --disable-runuser                           \
            --disable-pylibmount                        \
            --disable-static                            \
            --without-python                            \
            runstatedir=/run

make

chown -Rv tester .
su tester -s /bin/bash
make -k check

make install

