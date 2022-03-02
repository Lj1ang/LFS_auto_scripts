#!/bin/bash
set -e

sed "s/gold-version/& -R .note.gnu.property/" \
    -i Makefile.in grub-core/Makefile.in

./configure --prefix=/usr       \
            --sbindir=/sbin     \
            --sysconfdir=/etc   \
            --disable-efiemu    \
            --disable-werror

make

make install

mv -v /etc/bash_completion.d/grub /usr/share/bash-completion/completions

