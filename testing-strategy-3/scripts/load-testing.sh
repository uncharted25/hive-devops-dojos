#!/usr/bin/env bash

DIR_SCRIPTS="$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)"
DIR_REPORTS="$(dirname ${DIR_SCRIPTS})/reports"

echo $DIR_REPORTS

if [ -z "$2" ]; then
    echo "Missing env, stopping now."
    exit 1
fi
ENVIRONMENT="$2"

test() {
  ab -n 10000 -c 10  -H "pod-canary:enable" "http://127.0.0.1:3000/" >$DIR_REPORTS/load-testing-result.txt 2>&1
}

clean() {
  rm $DIR_REPORTS/load-testing-result.txt
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
