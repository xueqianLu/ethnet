#!/bin/bash
for i in $(seq 0 3)
do
	echo "node$i"
	./init.sh $i
	./mine.sh $i
done
