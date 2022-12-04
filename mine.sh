#!/bin/bash
nodeidx=${1:-""}
randomport=`shuf -i 10000-11000 -n1`
port=$((10300+$nodeidx))
rpcport=$((9545+$nodeidx))
authrpcport=$((8851+$nodeidx))
p2pport=$((30403+$nodeidx))
miner=0x`cat node${nodeidx}/data/keystore/* | jq -r .address`

echo "start geth node $nodeidx"
nodedir=node${nodeidx}

./geth --datadir ${nodedir}/data --verbosity 3 --networkid 1024 --mine --miner.etherbase=$miner --port $port --allow-insecure-unlock --unlock $miner --password pwd  --http --http.addr 127.0.0.1 --http.port $rpcport --http.api admin,eth,web3,net,debug,miner,txpool --http.corsdomain '*' --http.vhosts '*' --authrpc.port ${authrpcport} --nat=none --nodiscover >> $nodedir/node.log 2>&1 &
