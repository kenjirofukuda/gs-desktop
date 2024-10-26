#!/bin/bash

for DD in `cat ./freebsd.txt` ;do
  echo $DD
  pkg install -y $DD || exit 1
done
