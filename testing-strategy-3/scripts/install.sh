#!/usr/bin/env bash
path=$(pwd)
e2e_path="${path/scripts/""}/e2e-web"
web_path="${path/scripts/""}/web"
cd $e2e_path && yarn
cd $web_path && yarn