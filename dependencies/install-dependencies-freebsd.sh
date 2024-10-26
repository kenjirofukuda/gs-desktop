#!/usr/bin/env bash

for DD in `cat ./freebsd.txt | grep -v -e '^#' ` ;do
  echo $DD
  pkg install -y $DD || exit 1
done
