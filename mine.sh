#!/bin/bash
nodeidx=${1:-""}
port=$((40303+$nodeidx))
rpcport=$((9545+$nodeidx))
authrpcport=$((8851+$nodeidx))
p2pport=$((30403+$nodeidx))
miner=0x`cat node${nodeidx}/data/keystore/* | jq -r .address`
echo "miner=$miner"

./geth --datadir node${nodeidx}/data --verbosity 3 --networkid 1024 --mine --miner.etherbase=$miner --port $port --allow-insecure-unlock --unlock $miner --password pwd  --http --http.addr 127.0.0.1 --http.port $rpcport --http.api admin,eth,web3,net,debug,miner,txpool --http.corsdomain '*' --http.vhosts '*' --authrpc.port ${authrpcport} --bootnodes "enode://e7dca373212dbb37e69b41d3ab228533f6719a25a70260c4fc9d9e2272ae8b93c1cadbb03cb0f0947e34dbf27adc0eb5791d744b9e174a99c481a3917096c7f4@127.0.0.1:30301" --discovery.port ${p2pport} --nat=none >> node${nodeidx}.log 2>&1 &
