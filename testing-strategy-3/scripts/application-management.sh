#!/usr/bin/env bash
DIR_PROJECT="$(dirname ${PWD})/web/"

build() {
  cd $DIR_PROJECT
  echo "===== run web ====="
  npm install
  npm run build
}

start() {
  cd $DIR_PROJECT
  echo "===== starting web ====="
  npm run start
}

case "$1" in
build)
  build
  ;;
start)
  start
  ;;
*)
  echo "Usage: $0 {build|start} $3" >&2
  echo "Example: ./load-testing.sh test dev" >&2
  exit 1
  ;;
esac
