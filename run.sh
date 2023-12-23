#!/bin/bash

bootnode_tmp=`head -n 10 boot.log | grep -Eo "enr:*.*\""`
export BOOTNODE_ENR=`echo ${bootnode_tmp%?}`


echo "bootnode = $BOOTNODE_ENR"
docker compose -f docker-compose.yml up -d


total=`docker ps | grep "beacon"|wc -l`
declare -A peerids
function getpeers() 
{
	for((i=1;i<=${total};i++));
	do
		multiaddr_tmp=`docker logs beacon$i >/tmp/_b.log 2>&1 ; grep "Node started p2p server" /tmp/_b.log | grep -Eo "/ip4/*.*\""`
		multiaddr=`echo ${multiaddr_tmp%?}`
		peerids[$i]=$multiaddr
	done
}
getpeers
