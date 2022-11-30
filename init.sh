#!/bin/bash
nodeidx=${1:-""}
echo "init node $nodeidx"
./geth --datadir node${nodeidx}/data init sgxchain.json > /dev/null
