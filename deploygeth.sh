#!/bin/bash
source env.sh
for i in $(seq 0 $MAXNODEIDX)
do
	echo "node$i"
	./init.sh $i
	./mine.sh $i
done

sleep 5
./addpeers.sh
