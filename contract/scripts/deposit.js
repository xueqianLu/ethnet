const hre = require("hardhat");
require("@nomiclabs/hardhat-web3");

async function main() {
	//const accounts = await web3.eth.getAccounts();
	const accounts = await hre.ethers.getSigners();
	for (var i = 0; i < accounts.length; i++){
		var dpath=`./d${i}.json`;
		const depositdata = require(dpath)
		console.log("deposit data is ", depositdata)

		let account = accounts[i];

		console.log("depoly with account", account.address);
		const deposit = await hre.ethers.getContractAt("DepositContract", "0x2B2f78c5BF6D9C12Ee1225D5F374aa91204580c3");

		var pubkey = "0x"+depositdata[0].pubkey;
		console.log("pubkey is", pubkey);
		var withdrawal_credentials = "0x" + depositdata[0].withdrawal_credentials;
		var amount = depositdata[0].amount;
		var signature = "0x"+depositdata[0].signature;
		var deposit_message_root = "0x"+depositdata[0].deposit_message_root;
		var deposit_data_root = "0x" + depositdata[0].deposit_data_root;

		var tx = await deposit.connect(account).deposit(pubkey, withdrawal_credentials, signature, deposit_data_root, { value: hre.ethers.utils.parseEther('32') });
		await tx.wait();


		console.log( `deposit at ${tx}`);
	}
	//for(var i = 1; i <= 4; i++) {
	//	var kpath=`./k${i}.json`;
	//	var dpath=`./d${i}.json`;
	//	const depositdata = require(dpath)
	//	const keystore = require(kpath)
	//	console.log("deposit data is ", depositdata)
	//	console.log("keystore data is ", keystore)

	//	let account = web3.accounts.decrypt(keystore, "password")

	//	console.log("depoly with account", account.address);
	//	const deposit = await hre.ethers.getContractAt("DepositContract", "0x2B2f78c5BF6D9C12Ee1225D5F374aa91204580c3");

	//	var pubkey = "0x"+depositdata[0].pubkey;
	//	console.log("pubkey is", pubkey);
	//	var withdrawal_credentials = "0x" + depositdata[0].withdrawal_credentials;
	//	var amount = depositdata[0].amount;
	//	var signature = "0x"+depositdata[0].signature;
	//	var deposit_message_root = "0x"+depositdata[0].deposit_message_root;
	//	var deposit_data_root = "0x" + depositdata[0].deposit_data_root;

	//	var tx = await deposit.connect(account).deposit(pubkey, withdrawal_credentials, signature, deposit_data_root, { value: hre.ethers.utils.parseEther('32') });
	//	await tx.wait();


	//	console.log( `deposit at ${tx}`);
	//}
  //const [admin] = await hre.ethers.getSigners();
  //console.log("depoly with account", admin.address);
  //const deposit = await hre.ethers.getContractAt("DepositContract", "0x2B2f78c5BF6D9C12Ee1225D5F374aa91204580c3");
  //console.log("deposit data is ", depositdata)
  //var pubkey = "0x"+depositdata[0].pubkey;
  //console.log("pubkey is", pubkey);
  //var withdrawal_credentials = "0x" + depositdata[0].withdrawal_credentials;
  //var amount = depositdata[0].amount;
  //var signature = "0x"+depositdata[0].signature;
  //var deposit_message_root = "0x"+depositdata[0].deposit_message_root;
  //var deposit_data_root = "0x" + depositdata[0].deposit_data_root;

  //var tx = await deposit.deposit(pubkey, withdrawal_credentials, signature, deposit_data_root, { value: hre.ethers.utils.parseEther('32') });
  //await tx.wait();


  //console.log( `deposit at ${tx}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
