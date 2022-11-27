#!/bin/bash
nodeidx=${1:-""}
cat node${nodeidx}/data/keystore/*| jq .address
