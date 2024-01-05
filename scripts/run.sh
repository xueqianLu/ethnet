#!/bin/bash

CASEFILE=${1:-""}

if [ "$CASEFILE" ==  "" ];then
  echo "invalid param, case file is empty"
  exit 1
fi

# check $CASEFILE is exist in testcase dir
if [ ! -f "$CASEFILE" ];then
  echo "invalid param, case file is not exist"
  exit 1
fi

# clear generated dir
./scripts/clear.sh || exit 1

# parse case file
./bin/dparser -file $CASEFILE || exit 1

# build docker image
bash ./generated/build.sh || exit 1

# generate genesis
./scripts/genesis.sh || exit 1

# start docker compose
docker compose -f docker-compose.yml up -d

echo "start testcase success"
