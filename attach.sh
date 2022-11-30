#!/bin/bash
nodeidx=${1:-"0"}
rpcport=$((9545+$nodeidx))
./geth attach http://127.0.0.1:$rpcport
