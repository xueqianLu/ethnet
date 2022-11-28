#!/bin/bash
for i in $(seq 0 3)
do
	cp node${i}/data/geth/nodekey node${i}/data/nodekey
	rm -rf node${i}/data/geth/*
	cp node${i}/data/nodekey node${i}/data/geth/nodekey
	rm -rf beaconnode/node${i}/beaconchaindata/beaconchain.db
	#rm -rf beaconnode/node${i}/metadata
	rm -rf validator/node${i}/validator.db
done

