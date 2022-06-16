#!/usr/bin/env bash

FILE=$(pwd)/../example.txt

grep -o devops $FILE | wc -l | tr -d ' '