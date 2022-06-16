#!/usr/bin/env bash

DATA_DIR=$(pwd)/../../datas/features

fileName="result.txt"
echo "" > $fileName
targetFile=$(grep -r -l "@skip" $DATA_DIR)
for file in $targetFile
do 
    var1=$(grep Feature: $file)
    var2=$(grep -A 3 @skip $file | grep Scenario: | wc -l)
    var3=$(grep -A 3 @skip $file | grep Scenario:)
    echo $var1 $var2 skipped >> $fileName
    echo "$var3" >> $fileName
    echo "" >> $fileName
done

cat $fileName