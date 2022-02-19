#!/bin/bash
set -e 

sh Configure -des                           \
            -Dprefix=/usr                               \
            -Dvendorprefix=/usr                         \
            -Dprivlib=/usr/lib/perl5/5.32/core_perl     \
            -Darchlib=/usr/lib/perl5/5.32/core_perl     \
            -Dsitelib=/usr/lib/perl5/5.32/site_perl     \
            -Dsitearch=/usr/lib/perl5/5.32/site_perl    \
            -Dvendorlib=/usr/lib/perl5/5.32/vendor_perl \
            -Dvendorarch=/usr/lib/perl5/5.32/vendor_perl

make && make install