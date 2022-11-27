#!/bin/bash
killall geth 
rm node*.log -f

# stop beaconnode
ps -ef | grep beaconnode | grep -v grep| awk '{print $2}' | xargs kill -9
rm prysm/bnode*.log

# stop validator
ps -ef | grep validator | grep -v grep| awk '{print $2}' | xargs kill -9

./deldata.sh






./deploygeth.sh
sleep 5

# deploy deposit contract and deposit
cd contract && ./redeploy.sh


# start beaconnode manual
cd prysm && ./run.sh

# start validator manual
