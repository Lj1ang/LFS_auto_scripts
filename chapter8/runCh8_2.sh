#!/bin/bash
set -e 

DIR=/scripts/chapter8
LOG_DIR=/scripts/chapter8

tools=(    
    'pkg-config-0.29.2'
    'ncurses-6.2'
    'sed-4.8'
    'psmisc-23.4'
    'gettext-0.21'
    'bison-3.7.5'
    'grep-3.6'
    'bash-5.1'
    'libtool-2.4.6'
    'gdbm-1.19'
    'gperf-3.1'
    'expat-2.2.10'
    'inetutils-2.0'
    'perl-5.32.1'
    'xml-parser-2.46'
    'intltool-0.51.0'
    'autoconf-2.71'
    'automake-1.16.3'
    'kmod-28'
    #mind
    'libelf'

    'libffi-3.3'
    'openssl-1.1.1j'
    'python-3.9.2'
    'ninja-1.10.2'
    'meson-0.57.1'
    'coreutils-8.32'
    'check-0.15.2'
    'diffutils-3.7'
    'gawk-5.1.0'
    'findutils-4.8.0'
    'groff-1.22.4'
    'grub-2.04'
    'less-563'
    'gzip-1.10'
    'iproute2-5.10.0'
    'kbd-2.4.0'
    'libpipeline-1.5.3'
    'make-4.3'
    'patch-2.7.6'
    'man-db-2.9.4'
    'tar-1.34'
    'texinfo-6.7'
    'vim-8.2.2433'
    'systemd-247'
    'd-bus-1.12.20'
    'procps-ng-3.3.17'
    'util-linux-2.36.2'
    'e2fsprogs-1.46.1'

)

dirs=(
  pkg-config-0.29.2
    ncurses-6.2
    sed-4.8
    psmisc-23.4
    gettext-0.21
    bison-3.7.5
    grep-3.6
    bash-5.1
    libtool-2.4.6
    gdbm-1.19
    gperf-3.1
    expat-2.2.10
    inetutils-2.0
    perl-5.32.1
    xml-parser-2.46
    intltool-0.51.0
    autoconf-2.71
    automake-1.16.3
    kmod-28
    #mind
    elfutils-0.183

    libffi-3.3
    openssl-1.1.1j
    python-3.9.2
    ninja-1.10.2
    meson-0.57.1
    coreutils-8.32
    check-0.15.2
    diffutils-3.7
    gawk-5.1.0
    findutils-4.8.0
    groff-1.22.4
    grub-2.04
    less-563
    gzip-1.10
    iproute2-5.10.0
    kbd-2.4.0
    libpipeline-1.5.3
    make-4.3
    patch-2.7.6
    man-db-2.9.4
    tar-1.34
    texinfo-6.7
    vim-8.2.2433
    systemd-247
    d-bus-1.12.20
    procps-ng-3.3.17
    util-linux-2.36.2
    e2fsprogs-1.46.1
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

bash clean.sh > clean.log 2>&1