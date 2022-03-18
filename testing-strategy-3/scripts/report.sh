#!/usr/bin/env bash
DIR_CURRENT=$(pwd)
DIR_E2E="${DIR_CURRENT/scripts/""}/e2e-web" 
DIR_REPORT="${DIR_E2E}/cypress/cucumber-json"
cd $DIR_E2E

test() {
  npm run test
}
generate() {
  npm run generate-report 
  open $DIR_REPORT
}

clean() {
  rm -rf $DIR_REPORT
}


if [ -z "$2" ]; then
    echo "Missing env, stopping now."
    exit 1
fi
ENVIRONMENT="$2"

case "$1" in
test)
  test
  ;;
generate)
  generate
  ;;
clean)
  clean
  ;;
*)
  echo "Usage: $0 {test|report|clean} $3" >&2
  echo "Example: ./report.sh test dev" >&2
  exit 1
  ;;
esac

