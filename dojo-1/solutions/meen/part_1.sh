#!/usr/bin/env bash

DATA_DIR=$(pwd)/../../datas

for file in $(find $DATA_DIR -print | grep .feature); 
do 
  if [ -f $file ] && grep -q "@skip" $file; then
    echo $file; #For part 1
  fi
done
