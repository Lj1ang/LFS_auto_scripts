#!/bin/bash
set -echo

./configure --prefix=/usr

make

make check

make install

