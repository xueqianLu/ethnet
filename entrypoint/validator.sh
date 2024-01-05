#!/bin/sh

echo "bootstart validator with validators_num=${VALIDATORS_NUM} and index=${VALIDATORS_INDEX} and beacon $BEACONRPC"

/usr/bin/validator   --datadir=validatordata   \
	--accept-terms-of-use   \
	--interop-num-validators=${VALIDATORS_NUM}   \
	--interop-start-index=${VALIDATORS_INDEX}   \
	--force-clear-db   \
	--chain-config-file=/root/config/config.yml   \
	--config-file=/root/config/config.yml \
	--beacon-rpc-provider "$BEACONRPC"
