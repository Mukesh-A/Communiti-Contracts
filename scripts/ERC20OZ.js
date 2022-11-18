// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  //   const lockedAmount = hre.ethers.utils.parseEther("1");

  const [lawer] = await hre.ethers.getSigners();
  console.log("mukesh", lawer);

  const CommunitiToken = await hre.ethers.getContractFactory(
    "CommunitiTokenOZ"
  );
  const token = await CommunitiToken.connect(lawer).deploy(10000);

  await token.deployed();
  const balance = await token.balanceOf(lawer.address);
  console.log(token.address, balance);
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
