FROM ubuntu:22.04

WORKDIR /root

COPY ./bin/geth /usr/bin/geth
COPY ./bin/prysmctl /usr/bin/prysmctl
COPY ./bin/beacon-chain /usr/bin/beacon-chain
COPY ./bin/bootnode /usr/bin/bootnode
COPY ./bin/validator /usr/bin/validator

COPY ./scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod u+x /usr/local/bin/entrypoint.sh
COPY ./scripts/execution.sh /usr/local/bin/execution.sh
RUN chmod u+x /usr/local/bin/execution.sh
COPY ./scripts/beacon-node.sh /usr/local/bin/beacon-node.sh
RUN chmod u+x /usr/local/bin/beacon-node.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
