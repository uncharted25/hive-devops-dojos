#!/bin/bash

# We will have two rules:

# - do not allow @skip in top of a Feature keyword
# - all annotation should be in 1 line
cd ../../../dojo-1/datas
count_error=0
find * -type f -name "*.feature" | while read -r line ; do
    raw_feature=$(grep "Feature:" $line)
    feature=$(grep -v "^[#]" <<< "$raw_feature")
    if [ ! -z "$feature" ]
    then
        line_before=$(grep -B1 "$feature" $line)
        not_skip=$(grep "@skip" <<< $line_before)
        if [ ! -z "$not_skip" ]
        then
            count_error=$(($count_error+1))
            echo "====="
            echo ""
            echo "Error format at file: $line"
            echo ""
            echo "Line Before Feature: $line_before"
            echo "====="
            echo ""
        fi
    fi
done
