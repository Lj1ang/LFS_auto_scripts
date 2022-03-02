#!/bin/bash
set -e 

./configure --prefix=/usr --bindir=/bin

make
make html

chown -Rv tester .
su tester -s /bin/bash
PATH=$PATH make -k check

make install
install -d -m755            /usr/share/doc/sed-4.8
install -m644 doc/sed.html  /usr/share/doc/sed-4.8

