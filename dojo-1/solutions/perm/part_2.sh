#!/usr/bin/env bash

DATA_DIR=$(pwd)/../../datas/features

targetFile=$(grep -r -l "@skip" $DATA_DIR)
for file in $targetFile
do 
    var1=$(grep Feature: $file)
    var2=$(grep -A 1 @skip $file | grep Scenario: | wc -l)
    echo $var1 $var2 skipped
done