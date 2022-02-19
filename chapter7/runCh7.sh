#!/bin/bash
set -e 
DIR=/scripts/chapter7
LOG_DIR=/scripts/chapter7

tools=(
    'libstdcxx.sh-pass2'  
    'gettext-0.21'  
    'bison-3.7.5'
    'perl-5.32.1'
    'python-3.9.2'
    'texinfo-6.7'
    'util-linux-2.36.2'
)
dirs=( 
    libstdcxx
    gettext-0.21
    bison-3.7.5
    perl-5.32.1
    python-3.9.2
    texinfo-6.7
    util-linux-2.36.2
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

bash ${DIR}/clean.sh > ${LOG_DIR}/clean.log 2>&1