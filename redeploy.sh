#!/bin/bash
curdir=$PWD
./stopall.sh

./deldata.sh

cd  prysm && ./deldata.sh && cd $curdir


# start beacon bootnode
cd prysm && ./run_bootnode.sh && cd $curdir

./deploygeth.sh
sleep 3

# start beaconnode manual
cd prysm && ./run_all_beacon.sh && cd $curdir


# deploy deposit contract and deposit
cd contract && ./redeploy.sh && cd $curdir


# start validator manual
cd prysm && ./run_all_validator.sh && cd $curdir
