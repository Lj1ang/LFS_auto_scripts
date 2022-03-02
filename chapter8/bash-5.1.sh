#!/bin/bash
set -e 

sed -i '/^bashline.o:.*shmbchar.h/a bashline.o: ${DEFDIR}/builtext.h' Makefile.in

./configure --prefix=/usr                       \
            --docdir=/usr/share/doc/bash-5.1    \
            --without-bash-malloc               \
            --with-installed-readline

make 

chown -Rv tester .

su tester << EOF
PATH=$PATH make tests < $(tty)
EOF

make install
mv -vf /usr/bin/bash /bin

exec /bin/bash --login +h

exit

