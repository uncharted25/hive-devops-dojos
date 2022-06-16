#!/bin/bash
cd ../../datas
grep -r -H -l "@skip" * | while read -r line ; do
    # echo "Processing $line"
    feature_line=$(grep "Feature:" $line)

    if [ ! -z "$feature_line" ]
    then
        count_skip=$(grep -c "@skip" $line)
        # five_lines=$(grep -A2 "@skip" $line | grep "Scenario:")
        
        output="${feature_line}: ${count_skip} skipped"
        echo $output
        # echo $five_lines
        echo ""
    fi
done