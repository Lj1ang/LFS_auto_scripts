#!/bin/bash

DIR=/root/scripts/chapter6
LOG_DIR=/root/scripts/chapter6
tools=(
    'm4-1.4.18'
    'ncurses-6.2'
    'bash-5.1'
    'coreutils-8.32'
    'diffutils-3.7'
    'file-5.39'
    'findutils-4.8.0'
    'gawk-5.1.0'
    'grep-3.6'
    'gzip-1.10'
    'make-4.3'
    'patch-2.7.6'
    'sed-4.8'
    'tar-1.34'
    'xz-5.2.5'
    'binutils-2.36.1-Pass-2'
    'gcc-10.2.0-Pass-2'


)
dirs=(
    m4-1.4.18
    ncurses-6.2
    bash-5.1
    coreutils-8.32
    diffutils-3.7
    file-5.39
    findutils-4.8.0
    gawk-5.1.0
    grep-3.6
    gzip-1.10
    make-4.3
    patch-2.7.6
    sed-4.8
    tar-1.34
    xz-5.2.5
    binutils-2.36.1
    gcc-10.2.0
    
    
)

cd $LFS/sources

for i in ${!tools[@]}
do
    echo "build${tools[i]}...."
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