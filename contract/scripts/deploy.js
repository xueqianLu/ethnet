const hre = require("hardhat");

async function main() {
  const [admin] = await hre.ethers.getSigners();
  console.log("depoly with account", admin.address);
  const contract = await hre.ethers.getContractFactory("DepositContract");
  const deposit = await contract.deploy();

  await deposit.deployed();

  console.log( `deposit at ${deposit.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
