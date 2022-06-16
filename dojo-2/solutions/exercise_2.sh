#!/usr/bin/env bash

FILE=$(pwd)/../example.txt

#sed 's/{find}/{replace}/g' file.txt
sed 's/devops/helo_word/g' $FILE > new_example.txt