#!/bin/bash
killall bootnode
killall geth 
rm node*.log -f

# stop beaconnode
ps -ef | grep beaconnode | grep -v grep| awk '{print $2}' | xargs kill -9
rm prysm/bnode*.log

# stop validator
ps -ef | grep validator | grep -v grep| awk '{print $2}' | xargs kill -9

./deldata.sh


curdir=$PWD


# start beacon bootnode
cd prysm && ./run_bootnode.sh && cd $curdir

./deploygeth.sh
sleep 5
./addpeers.sh


# start beaconnode manual
cd prysm && ./run_all_beacon.sh && cd $curdir


# deploy deposit contract and deposit
cd contract && ./redeploy.sh && cd $curdir


# start validator manual
cd prysm && ./run_all_validator.sh && cd $curdir
