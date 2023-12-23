#!/bin/bash
total_validators=${1:-"64"}
node_count=${2:-"16"}


check=$(($total_validators % $node_count))
if [ "$check" != 0 ];then
	echo "invalid param, please check and execute scripte again"
	exit 1
fi
echo "total validators $total_validators and node count $node_count"
step=$(($total_validators/$node_count))

file=docker-compose.yml
rm -f $file

echo 'version: "3.9"' >> $file
echo '' >> $file
echo 'services:' >> $file


for idx in `seq 1 $node_count`
do
	num=$step
	index=$(( $num * ($idx-1)))
#execution config
geth_rpc_port=$((1000+$idx))
geth_grpc_port=$((2000+$idx))
echo "  execute${idx}:" >> $file
echo '    image: ethnet/tools' >> $file
echo "    container_name: execute${idx}" >> $file
echo '    entrypoint: /usr/local/bin/execution.sh' >> $file
echo '    deploy:' >> $file
echo '      restart_policy:' >> $file
echo '        condition: on-failure' >> $file
echo '        delay: 1s' >> $file
echo '        max_attempts: 100' >> $file
echo '        window: 120s' >> $file
echo '    ports:' >> $file
echo "      - \"$geth_grpc_port:8551\"" >> $file
echo "      - \"$geth_rpc_port:8545\"" >> $file
echo '    volumes:' >> $file
echo '      - ./config:/root/config' >> $file
echo "      - ./data/gethdata${idx}:/root/gethdata" >> $file
echo '    networks:' >> $file
echo '      - meta' >> $file
echo '' >> $file

# beacon chain config
echo "  beacon${idx}:" >> $file
echo "    image: ethnet/tools" >> $file
echo "    container_name: beacon${idx}" >> $file
echo "    entrypoint: /usr/local/bin/beacon-node.sh" >> $file
echo "    environment:" >> $file
echo '      - BOOTNODE=${BOOTNODE_ENR}' >> $file
echo '      - ALLPEERS=${ALLPEERS}' >> $file
echo "      - EXECUTE=execute${idx}" >> $file
echo "    deploy:" >> $file
echo "      restart_policy:" >> $file
echo "        condition: on-failure" >> $file
echo "        delay: 1s" >> $file
echo "        max_attempts: 100" >> $file
echo "        window: 120s" >> $file
echo "    volumes:" >> $file
echo "      - ./config:/root/config" >> $file
echo "      - ./data/beacon${idx}:/root/beacondata" >> $file
echo "    depends_on:" >> $file
echo "      - execute${idx}" >> $file
echo "    networks:" >> $file
echo "      meta:" >> $file
echo "        ipv4_address: 172.99.1.${idx}" >> $file

echo "" >> $file
echo "  validators${idx}:" >> $file
echo '    image: ethnet/tools' >> $file
echo "    container_name: validators${idx}" >> $file
echo '    entrypoint: /usr/local/bin/validator.sh' >> $file
echo '    environment:' >> $file
echo "      - VALIDATORS_NUM=$num" >> $file
echo "      - VALIDATORS_INDEX=$index" >> $file
echo "      - BEACONRPC=beacon${idx}:4000" >> $file
echo '    deploy:' >> $file
echo '      restart_policy:' >> $file
echo '        condition: on-failure' >> $file
echo '        delay: 1s' >> $file
echo '        max_attempts: 100' >> $file
echo '        window: 120s' >> $file
echo '    volumes:' >> $file
echo '      - ./config:/root/config' >> $file
echo "      - ./data/validators${idx}:/root/validatordata" >> $file
echo '    depends_on:' >> $file
echo "      - beacon${idx}" >> $file
echo '    networks:' >> $file
echo '      - meta' >> $file
echo '' >> $file
done
echo 'networks:' >> $file
echo '  meta:' >> $file
echo '    driver: bridge' >> $file
echo '    ipam:' >> $file
echo '      config:' >> $file
echo '        - subnet: 172.99.0.0/16' >> $file

./clear.sh
./genesis.sh
