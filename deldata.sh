#!/bin/bash
source env.sh
for i in $(seq 0 $MAXNODEIDX)
do
	rm -f node${i}/node.log
	rm -rf node${i}/data/geth/*
	rm -rf beaconnode/node${i}/beaconchaindata/beaconchain.db
	#rm -rf beaconnode/node${i}/metadata
	rm -rf validator/node${i}/validator.db
done
rm -f node*.log
