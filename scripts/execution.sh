#!/bin/sh
initialize() {
	if [ ! -d "/root/gethdata/geth" ]; then
		echo "genesis init"
		/usr/bin/geth --datadir /root/gethdata init /root/config/genesis.json
		/usr/bin/geth --datadir /root/gethdata account import /root/config/secret.json <<EOM
123
123
EOM
		echo "123" > /root/config/password.txt
	fi
}

initialize 

/usr/bin/geth --datadir /root/gethdata \
	--http \
	--http.api=eth,net,web3 \
	--http.addr=0.0.0.0 \
	--http.corsdomain=* \
	--ws \
	--ws.api=eth,net,web3 \
	--ws.addr=0.0.0.0 \
	--ws.origins=* \
	--authrpc.vhosts=* \
	--authrpc.addr=0.0.0.0 \
	--authrpc.jwtsecret=/root/config/jwtsecret \
	--datadir=gethdata \
	--allow-insecure-unlock \
	--unlock=0x123463a4b065722e99115d6c222f267d9cabb524 \
	--password=/root/config/password.txt \
	--nodiscover \
	--syncmode=full
