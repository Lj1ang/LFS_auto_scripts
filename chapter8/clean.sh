#!/bin/bash
set -e

save_lib="ld-2.33.so libc-2.33.so libpthread-2.33.so libthread_db-1.0.so"

cd /lib

for LIB in $save_lib; do
    objcopy --only-keep-debug $LIB $LIB.dbg
    strip --strip-unneeded $LIB
    objcopy --add-gnu-debuglink=$LIB.dbg $LIB
done

save_usrlib="libquadmath.so.0.0.0 libstdc++.so.6.0.28
            libitm.so.1.0.0 libatomic.so.1.2.0"

cd /usr/lib

for LIB in $save_usrlib; do
    objcopy --only-keep-debug $LIB $LIB.dbg
    strip --strip-unneeded $LIB
    objcopy --add-gnu-debuglink=$LIB.dbg $LIB
done

unset LIB save_lib save_usrlib

find /usr/lib -type f -name \*.a \
    -exec strip --strip-debug {} ';'

find /lib /usr/lib -type f -name \*.so* ! -name \*dbg \
    -exec strip --strip-unneeded {} ';'

find /{bin,sbin} /usr/{bin,sbin,libexec} -type f \
    -exec strip --strip-all {} ';'

rm -rf /tmp/*

logout
chroot "$LFS" /usr/bin/env -i           \
    HOME=/root TERM="$TERM"             \
    PS1='(lfs chroot) \u:\w\$ '         \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin  \
    /bin/bash --login

find /usr/lib /usr/libexec -name \*.la -delete

find /usr -depth -name $(uname -m)-lfs-linux-gnu\* | xargs rm -rf

rm -rf /tools

userdel -r tester