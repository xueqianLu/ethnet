# ethnet 
This is a tools for build multi node eth2.0 private network with interop mode.

# 
```shell
.
├── README.md
├── bin         # binary files
├── config      # config files
├── data        # system data files
├── entrypoint  # container entrypoint scripts
├── generated   # generated files for testcase
├── scripts     # scripts for build and run
├── templates   # Dockerfile templates
└── testcase    # testcase files
```

# environment
- linux operating system
- docker and docker compose

# step to run
1. clone this repo
2. choose a testcase in `testcase` folder
3. run the case with command `./scripts/run.sh testcase/<xxxx>`
4. run `./scripts/stop.sh` to stop the system.

# static config
- static 64 validators
- static genesis.json

# what is testcase
Testcase is a topology of all nodes, which is defined in `testcase` folder.

- testcase/normal-1.json define a single node topology
- testcase/normal-5.json define a 5 nodes topology
- testcase/case0.json define a complex topological structure with special peer-peer connection.

You can create new testcase file to define your own topology.
