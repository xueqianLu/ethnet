require("dotenv").config();

require("@nomiclabs/hardhat-etherscan");
require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-web3");
require("hardhat-gas-reporter");
require("solidity-coverage");

// Define mnemonic for accounts.
let mnemonic = process.env.MNEMONIC;
if (!mnemonic) {
  mnemonic = "test test test test test test test test test test test test";
}

let validators = require("./.secret.json");

const accounts = { mnemonic };

task("accounts", "Prints accounts", async (_, { web3 }) => {
	  console.log(await web3.eth.getAccounts());
});

module.exports = {
  solidity: {
    compilers: [
      {
        version: "0.6.11"
      },
    ],
  },
  networks: {
    deploy: {
      url: "http://127.0.0.1:9545",
      accounts: accounts,
      gasLimit: 100000000,
      gasPrice: 5000000000,
    },
    deposit: {
      url: "http://127.0.0.1:9545",
      accounts: validators,
      gasLimit: 100000000,
      gasPrice: 5000000000,
    },
  },
};
