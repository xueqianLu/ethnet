#!/bin/bash
bootnode_tmp=`head -n 10 boot.log | grep -Eo "enr:*.*\""`
export BOOTNODE_ENR=`echo ${bootnode_tmp%?}`

echo "bootnode = $BOOTNODE_ENR"

declare NODEPEERS

if [ ! -f "/tmp/_tmp.peers" ]; then
  docker compose -f docker-compose.yml up -d
  getpeers
  export ALLPEERS=${NODEPEERS}
  echo "ALLPEERS = $ALLPEERS"
  docker compose -f docker-compose.yml down
  docker compose -f docker-compose.yml up -d
  echo "$ALLPEERS" > /tmp/_tmp.peers

else
  NODEPEERS=`cat /tmp/_tmp.peers`
  export ALLPEERS=${NODEPEERS}
  echo "ALLPEERS = $ALLPEERS"
  docker compose -f docker-compose.yml up -d
fi

function getpeers()
{
  total=`docker ps | grep "beacon"|wc -l`
	for((i=1;i<=${total};i++));
	do
		multiaddr_tmp=`docker logs beacon$i >/tmp/_b.log 2>&1 ; grep "Node started p2p server" /tmp/_b.log | grep -Eo "/ip4/*.*\""`
		multiaddr=`echo ${multiaddr_tmp%?}`
	  NODEPEERS=`echo "$NODEPEERS --peer \"$multiaddr\""`
	done
}
