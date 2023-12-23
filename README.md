# ethnet 
This is a tools for build multi node eth2.0 private network with interop mode.

# environment
- linux operating system
- docker and docker compose

# step to run
1. clone this repo
2. run `./build.sh` to build the docker image
3. run `./generate.sh N` to generate `docker-compose.yml` and config files for N nodes.
4. run `./start.sh` and `./stop.sh` to boot and stop all nodes.

# nodes topology
- N execute nodes and N beacon nodes
- beacon node connect to each other with peer parameter
- static 64 validators