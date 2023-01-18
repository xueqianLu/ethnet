#!/bin/bash
dir=${1:-""}
make build_docker
docker run -it --rm -v $(pwd)/${dir}:/app/validator_keys ethereum/staking-deposit-cli new-mnemonic --num_validators=1 --mnemonic_language=english --chain=sgx
