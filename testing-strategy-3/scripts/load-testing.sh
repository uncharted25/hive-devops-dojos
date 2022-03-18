#!/usr/bin/env bash

if [ -z "$2" ]; then
    echo "Missing env, stopping now."
    exit 1
fi
ENVIRONMENT="$2"

test() {
  ab -n 10000 -c 10 "https://www.google.com/"
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
