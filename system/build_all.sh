#!/bin/bash
set -e

sudo -E cp ../config/etc/ld.so.conf.d/gs-desktop.conf /etc/ld.so.conf.d

for DD in `ls -1 *-build_*.sh`; do
  echo $DD
  ./$DD || exit
done
