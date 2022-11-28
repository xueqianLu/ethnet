#!/bin/bash
total=4
declare -A peerids
function addpeer() 
{
	index=$1
	rpcport=$((9545+$index))
	echo "addpeer for node $index"
	for((i=0;i<${total};i++));
	do
		if [ $index == $i ];
		then
			continue
		fi

		pid=${peerids[$i]}
		curl -s -H "Content-Type:application/json" -X POST --data "{\"jsonrpc\":\"2.0\",\"method\":\"admin_addPeer\",\"params\":[\"$pid\"],\"id\":67}" http://127.0.0.1:$rpcport > /dev/null
	done
}

for((i=0;i<${total};i++));
do
	logfile="./node${i}.log"
	pid=`grep "self" $logfile | grep -Eo "enode.*[a-z0-9:/?=]"`
	peerids[$i]=$pid
done

for((m=0;m<${total};m++));
do
	addpeer $m
done

