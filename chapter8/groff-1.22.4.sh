#!/bin/bash
set -e

PAGE=A4 ./configure --prefix=/usr

make -j1

make install
