#!/bin/bash
set -e 

python3 setup.py build

python3 setup.py install --root=dest
cp -rv dest/* /

