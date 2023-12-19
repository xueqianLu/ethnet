#!/bin/bash
./bootnode.sh
sleep 3
bootnode_tmp=`docker logs bootnode | head -n 2 | grep -Eo "enr:*.*\ "`
echo "bootnode = $bootnode_tmp"
export BOOTNODE_ENR=$bootnode_tmp
docker compose -f docker-compose.yml up -d
