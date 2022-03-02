#!/bin/bash
set -e

./configure --prefix=/usr --localstatedir=/var/lib/locate

make

chown -Rv tester .
#su tester -c "PATH=$PATH make check"
su tester -s /bin/bash
PATH=$PATH make -k check

make install

mv -v /usr/bin/find /bin
sed -i 's|find:=${BINDIR}|find:=/bin|' /usr/bin/updatedb