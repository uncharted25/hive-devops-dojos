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
close() {
  kill $(lsof -t -i:3000)
}
case "$1" in
build)
  build
  ;;
start)
  start
  ;;
close)
  close
  ;;
*)
  echo "Usage: $0 {build|start|close} $3" >&2
  echo "Example: ./load-testing.sh test dev" >&2
  exit 1
  ;;
esac
