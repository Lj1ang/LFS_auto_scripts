#!/bin/bash

#bintuils-2.36.1
tar -xvf bintuils-2.36.1.tar.xz
cd bintuils-2.36.1

mkdir -v build
cd build

../configure --prefix=$LFS/tools          \
--with-sysroot=$LFS                       \
--target=$LFS_TGT                         \
--disable-nls                             \
--disable-werror                          \

make && make install
cd $LFS/sources
rm -rf bintuils-2.36.1

#gcc-10.2.0
tar -xvf gcc-10.2.0.tar.xz
cd gcc-10.2.0

tar -xf ../mpfr-4.1.0.tar.xz
mv -v mpfr-4.1.0 mpfr
tar -xf ../gmp-6.2.1.tar.xz
mv -v gmp-6.2.1 gmp
tar -xf ../mpc-1.2.1.tar.gz
mv -v mpc-1.2.1 mpc

case $(uname -m) in
    x86_64)
        sed -e '/m64=/s/lib64/lib/' \
            -i.orig gcc/config/i386/t-linux64
;;
esac

mkdir -v build
cd build

../configure            \
--target=$LFS_TGT       \
--prefix=$LFS/tools     \
--with-glibc-version=2.11   \
--with-sysroot=$LFS         \
--with-newlib               \
--without-headers           \
--enable-initfini-array     \
--disable-nls               \
--disable-shared            \
--disable-multilib          \
--disable-decimal-float     \
--disable-threads           \
--disable-libatomic         \
--disable-libgomp           \
--disable-libquadmath       \
--disable-libssp            \
--disable-libvtv            \
--disable-libstdcxx         \
--enable-languages=c,c++

make  &&  make install

cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
`dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/install-tools/include/limits.h

cd $LFS/sources
rm -rf gcc-10.2.0

#Linux-5.10.17
tar -xvf linux-5.10.17.tar.xz
cd linux-5.10.17

make mrproper

make headers
find usr/include -name '.*' -delete
rm usr/include/Makefile
cp -rv usr/include $LFS/usr

cd $LFS/sources
rm -rf linux-5.10.17

#glibc-2.33
tar -xvf glibc-2.33.tar.xz
cd glibc-2.33

case $(uname -m) in
    i?86)
            ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
    ;;
    
    x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
            ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
    ;;
esac

patch -Np1 -i ../glibc-2.33-fhs-1.patch

mkdir -v build
cd build

../configure                        \
--prefix=/usr                       \
--host=$LFS_TGT                     \
--build=$(../scripts/config.guess)  \
--enable-kernel=3.2                 \
--with-headers=$LFS/usr/include     \
libc_cv_slibdir=/lib                

make  && make DESTDIR=$LFS install

echo 'int main(){}' > dummy.c
$LFS_TGT-gcc dummy.c
readelf -l a.out | grep '/ld-linux'



rm -v dummy.c a.out
$LFS/tools/libexec/gcc/$LFS_TGT/10.2.0/install-tools/mkheaders

cd $LFS/sources
rm -rf glibc-2.33

#libstdc++ from gcc-10.2.0
tar -xvf gcc-10.2.0.tar.xz
cd gcc-10.2.0
mkdir -v build
cd build

../libstdc++-v3/configure   \
--host=$LFS_TGT             \
--build=$(../config.guess)  \
--prefix=/usr               \
--disable-multilib          \
--disable-nls               \
--disable-libstdcxx-pch     \
--with-gxx-include-dir=/tools/$LFS_TGT/include/c++/10.2.0

make  && make DESTDIR=$LFS install
cd $LFS/sources
rm-rf gcc-10.2.0