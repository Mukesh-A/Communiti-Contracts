require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-etherscan");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    goerli: {
      url: process.env.PRIVATE_KEY,
      accounts: [,],
    },
  },
  etherscan: {
    apiKey: process.env.API_KEY,
  },
};
