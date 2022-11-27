#!/bin/bash
npx hardhat run scripts/deploy.js --network deploy
npx hardhat run scripts/deposit.js --network deposit
