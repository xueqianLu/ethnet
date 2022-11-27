#!/bin/bash
for i in $(seq 0 3)
do
	rm -rf node${i}/data/geth/*
	rm -rf beaconnode/node${i}/beaconchaindata
	rm -rf beaconnode/node${i}/metadata
done

