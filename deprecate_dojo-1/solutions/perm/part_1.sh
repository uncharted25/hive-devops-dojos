#!/usr/bin/env bash

DATA_DIR=$(pwd)/../../datas/features

targetFile=$(grep -r -l "@skip" $DATA_DIR)
echo "$targetFile"