#!/bin/bash
node_count=${1:-"1"}

total_validators=64

# check node count little than total validators
if [ "$node_count" -gt "$total_validators" ];then
  echo "invalid param, node count need little than total validators"
  exit 1
fi

echo "total validators $total_validators and node count $node_count"

file=docker-compose.yml
rm -f $file

./bin/dparser -file topology.json


./clear.sh
./genesis.sh
