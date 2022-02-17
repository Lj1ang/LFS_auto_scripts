#!/bin/bash

DIR=~/scripts/chapter5

tools=(
    'bintuils-2.36.1-pass-1'
    'gcc-10.2.0-pass-1'
    'linux-5.10.17'
    'glibc-2.33'
    'libstdcxx'
)
dirs=(
    bintuils-2.36.1
    gcc-10.2.0
    linux-5.10.17
    glibc-2.33
    
    
)

cd $LFS/sources

for i in ${!tools[@]}
do
    echo "build${tools[i]}...."
    if [ ! -e ${dirs[i]}.tar.* ];then
        echo "can not find tar"
        exit
    fi
    tar -xvf ${dirs[i]}.tar.*
    cd ${dirs[i]}

    # not fix 
    if [ ! -e ${dirs[i]}.sh ];then
        echo "can not find .sh"
        rm -rf ${dirs[i]}
        exit
    fi

    bash ${DIR}/${dirs[i]}.sh
    cd $LFS/sources
    rm -rf ${dirs[i]}
    echo -e "${tools[i]}done\n"
done

gcc-10.2.0
echo "build libcxx"
tar -xvf gcc-10.2.0.tar.*
cd gcc-10.2.0
bash ${DIR}/libstdcxx.sh
cd gcc-10.2.0
rm -rf gcc-10.2.0
echo -e "libstdcxx done"