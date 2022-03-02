#!/bin/bash
set -e 

./configure --prefix=/usr --bindir=/bin

make 

make check

make install
