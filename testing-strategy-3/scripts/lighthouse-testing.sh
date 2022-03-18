
#!/usr/bin/env bash
DIR_PROJECT="$(dirname ${PWD})"
DIR_CONFIG="$(dirname ${PWD})/lighthouse/"
DIR_LH_GEN_REPORT="$(dirname ${PWD})/script/.lighthouseci"

if [[ "$1" == "test" ]]; then
 if [ -z "$2" ]; then
      echo "Missing url, stopping now."
      exit 1
  fi

  URL="$2"
fi
test() {
  echo "==== testing ===="
  echo $DIR_CONFIG
  echo "url => $URL "

  CONFIG_FILE="${DIR_CONFIG}/lh-config.json"
   if [[ ! -f $CONFIG_FILE ]]; then
      echo "The file ${CONFIG_FILE} does not exist! stopping now"
      exit 1
    fi
  lhci healthcheck --config="$CONFIG_FILE"
  lhciValHealthcheck=$?
  if [ $lhciValHealthcheck -ne 0 ]; then
      echo "========================="
      echo "Lighthouse healthcheck is failling..."
      echo "========================="
      EXIT_CODE=1
  fi
  lhci collect --url $URL --config="$CONFIG_FILE"
  lhciValCollect=$?
  if [ $lhciValCollect -ne 0 ]; then
      echo "========================="
      echo "Lighthouse collect is failling..."
      echo "========================="
      EXIT_CODE=1
  fi
  lhci assert --config="$CONFIG_FILE" --fatal
  lhciValAssert=$?
  if [ $lhciValAssert -ne 0 ]; then
      echo "========================="
      echo "Lighthouse assert is failling... $1 $2"
      echo "========================="
      EXIT_CODE=1
  fi
}

report() {
  open $DIR_PROJECT/scripts/.lighthouseci/lhr-*.html
}

clean() {
  echo  " delete => $DIR_PROJECT/scripts/.lighthouseci"
  rm -rf $DIR_PROJECT/scripts/.lighthouseci
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
  echo "Usage: $0 {test|report|clean}" >&2
  echo "Example: ./lighthouse-testing.sh test 'http://localhost:3000'" >&2
  echo "Example: ./lighthouse-testing.sh report" >&2
  exit 1
  ;;
esac