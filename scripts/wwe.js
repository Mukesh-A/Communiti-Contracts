const hre = require("hardhat");

async function main() {
  //  const lockedAmount = hre.ethers.utils.parseEther("1");

  const [lawer] = await hre.ethers.getSigners();
  console.log("mukesh", lawer);

  const WWE = await hre.ethers.getContractFactory("WWE");
  const token = await WWE.connect(lawer).deploy("WWE", "wwe");

  await token.deployed();
  console.log("success, contract deployed ", token.address);
  const nft = await token.mint(
    "https://ipfs.io/ipfs/QmPKuQpYTEmjosTHVfWLh9UNdhnEyvBk7K6VWJokRcJnxX"
  );
  console.log(nft);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
