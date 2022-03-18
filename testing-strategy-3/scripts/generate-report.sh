#!/usr/bin/env bash
path=$(pwd)
e2e_path="${path/scripts/""}/e2e-web" 
cd $e2e_path
npm run generate-report 

