#!/usr/bin/env bash
DIR_CONFIG="$(dirname ${PWD})/audit/"
DIR_PROJECT="$(dirname ${PWD})/web/"

test() {
  cd $DIR_PROJECT
  echo "===== run audit ====="
  npx audit-ci --config $DIR_CONFIG/audit-ci.jsonc
  testsResult=$?
  exit $testsResult
}

case "$1" in
test)
  test
  ;;
report)
  report
  ;;
clean)
  clean
  ;;
*)
  echo "Usage: $0 {test|report|clean} $3" >&2
  echo "Example: ./load-testing.sh test dev" >&2
  exit 1
  ;;
esac
