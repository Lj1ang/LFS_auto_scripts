#!/bin/bash
set -e 

./configure --prefix=/usr

make 

make check

make install

