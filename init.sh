#!/bin/bash
nodeidx=${1:-""}
./geth --datadir node${nodeidx}/data init sgxchain.json
