#!/usr/bin/env bash
DIR_CONFIG="$(dirname ${PWD})/audit/"
DIR_PROJECT="$(dirname ${PWD})/web/"

cd $DIR_PROJECT
echo "===== run audit ====="
npx audit-ci --config $DIR_CONFIG/audit-ci.jsonc