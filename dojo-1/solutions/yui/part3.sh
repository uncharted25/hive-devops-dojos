#!/bin/bash

for file in $(grep -rl --include \*.feature -e @skip ./datas); do
  line=$(grep -e Feature: $file)
  head=$(grep -B1 Feature: $file)
  if [[ "$head" == *"@skip"* ]]
  then
    count=$(grep -r -e Scenario: $file | wc -l)
    echo ${line} ":" ${count} "skipped"
    echo "$(grep -e Scenario: $file)"
  else
    count=$(grep -r -e @skip $file | wc -l)
    echo ${line} ":" ${count} "skipped"
    grep -A 2 -e @skip $file | while read -r line; do
      if [[ "$line" == *"Scenario"* ]]
      then
        echo "  $line"
      else
        :
      fi
    done;
  fi
done;
