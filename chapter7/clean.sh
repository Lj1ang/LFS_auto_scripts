#!/bin/bash
set -e 

find /usr/{lib,libexec} -name \*.la -delete

rm -rf /usr/share/{info,man,doc}/*


