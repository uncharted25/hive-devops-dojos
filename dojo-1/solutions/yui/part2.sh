#!/bin/bash

for file in $(grep -rl --include \*.feature -e @skip ./datas); do
  line=$(grep -e Feature: $file)
  head=$(grep -B1 Feature: $file)
  if [[ "$head" = *"@skip"* ]]
  then
    scenario=$(grep -r -e Scenario: $file | wc -l)
    echo ${line} ":" ${scenario} "skipped"
  else
    count=$(grep -r -e @skip $file | wc -l)
    echo ${line} ":" ${count} "skipped"
  fi
done;
