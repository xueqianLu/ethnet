#!/bin/bash
curdir=${PWD}
docker run -it -d --restart=always --name bootnode -p 39000:39000 --entrypoint /usr/bin/bootnode ethnet/tools -discv5-port 39000 -private 37871f094f89fc95599e73d72d3008c828bb76d0864759011fa14dbaf6cf3c06 -fork-version 20000089 -external-ip "172.17.0.1" -debug true
