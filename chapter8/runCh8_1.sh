#!/bin/bash
set -e 

DIR=/scripts/chapter8
LOG_DIR=/scripts/chapter8

tools=(
    'man-pages-5.10'
    'iana-etc-20210202'
    'glibc-2.33'
    'zlib-1.2.11'
    'bzip2-1.0.8'
    'xz-5.2.5'
    'zstd-1.4.8'
    'file-5.39'
    'readline-8.1'
    'm4-1.4.18'
    'bc-3.3.0'
    'flex-2.6.4'
    'tcl-8.6.11'
    'expect-5.45.4'
    'dejagnu-1.6.2'
    'binutils-2.36.1'
    'gmp-6.2.1'
    'mpfr-4.1.0'
    'mpc-1.2.1'
    'attr-2.4.48'
    'acl-2.2.53'
    'libcap-2.48'
    'shadow-4.8.1'
)

dirs=(
    man-pages-5.10
    iana-etc-20210202
    glibc-2.33
    zlib-1.2.11
    bzip2-1.0.8
    xz-5.2.5
    zstd-1.4.8
    file-5.39
    readline-8.1
    m4-1.4.18
    bc-3.3.0
    flex-2.6.4
    tcl-8.6.11
    expect-5.45.4
    dejagnu-1.6.2
    binutils-2.36.1
    gmp-6.2.1
    mpfr-4.1.0
    mpc-1.2.1
    attr-2.4.48
    acl-2.2.53
    libcap-2.48
    shadow-4.8.1

)

cd /sources

for i in ${!tools[@]}
do
    echo "build  ${tools[i]}...."
    if [ ! -e ${dirs[i]}.tar.* ];then
        echo "can not find tar"
        exit
    fi
    tar -xvf ${dirs[i]}.tar.* > ${LOG_DIR}/${dirs[i]}.log 2>&1
    pushd ${dirs[i]} > /dev/null

    # not fix 
    if [ ! -e ${DIR}/${dirs[i]}.sh ];then
        echo "can not find .sh"
        rm -rf ${dirs[i]}
        exit
    fi

    bash ${DIR}/${dirs[i]}.sh > ${LOG_DIR}/${dirs[i]}.log 2>&1
    popd > /dev/null

    rm -rf ${dirs[i]}
    echo -e "${tools[i]}done\n"
done

