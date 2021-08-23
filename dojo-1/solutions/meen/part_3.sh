#!/usr/bin/env bash

DATA_DIR=$(pwd)/../../datas

for file in $(find $DATA_DIR -print | grep .feature); 
do 
  if [ -f $file ] && grep -q "@skip" $file; then
    # Need to improve using Regex to find Feature after @skip
    LEN_SKIP_FEATURE=$(pcregrep -M "@skip.*\n.*Feature:" $file | wc -w)
    if [ $LEN_SKIP_FEATURE = 0 ]; then
      # Need to improve using Regex to find Scenario after @skip
      NUM_SKIP_SCENARIO=$(grep -A 5 '@skip' $file | grep -c "Scenario:")
      echo $(grep "Feature:" $file): $NUM_SKIP_SCENARIO skiped #For part 2
      grep -A 5 '@skip' $file | grep "Scenario:" #For part 3
    else
      echo $(grep "Feature:" $file): $(grep -c "Scenario:" $file) skiped #For part 2
      grep "Scenario:" $file #For part 3
    fi
  fi
done
