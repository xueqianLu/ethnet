#!/bin/bash

killall geth 

# stop beaconnode
ps -ef | grep beaconnode | grep -v grep| awk '{print $2}' | xargs kill -9

# stop validator
ps -ef | grep validator | grep -v grep| awk '{print $2}' | xargs kill -9
