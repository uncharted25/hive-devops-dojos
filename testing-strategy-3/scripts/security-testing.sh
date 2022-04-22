#!/usr/bin/env bash

DIR_SCRIPTS="$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)"
DIR_PIPELINES="$(dirname ${DIR_SCRIPTS})/pipelines"
DIR_REPORTS="$(dirname ${DIR_SCRIPTS})/reports"

if [ -z "$2" ]; then
    echo "Missing env, stopping now."
    exit 1
fi
ENVIRONMENT="$2"

prepare () {
  cd $DIR_PIPELINES
  docker-compose up
}

case "$1" in
prepare)
  prepare
  ;;
*)
  echo "Usage: $0 {test|report|clean} $3" >&2
  echo "Example: ./security-testing.sh prepare dev" >&2
  exit 1
  ;;
esac
