require("@nomiclabs/hardhat-waffle");
require("hardhat-gas-reporter");
require("@openzeppelin/hardhat-upgrades");
require('hardhat-contract-sizer');
require('dotenv').config();

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async () => {
  const accounts = await ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: {
    compilers: [{version: "0.8.3"}]
  },
  networks: {
    localhost: {
      url: "http://127.0.0.1:8545",
      mining: {
        auto: true,
        interval: 1000
      }
    },
    hardhat: {
      loggingEnabled: false,
      mining: {
        auto: true,
        interval: 1000
      },
      accounts: {mnemonic: process.env.ADMIN_MNENOMIC},
      blockGasLimit: 12450000
    },
    testnet: {
      url: "https://http-testnet.hecochain.com/",
      chainId: 256,
      gas: 8000000,
      gasPrice: 10000000000,
      accounts: {mnemonic: process.env.TESTNET_ADMIN_MNENOMIC},
    },
    mainnet: {
      url: "https://http-mainnet-node.huobichain.com/",
      chainId: 128,
      gasPrice: 20000000000,
      accounts: {mnemonic: process.env.TESTNET_ADMIN_MNENOMIC},
    }
  },
  mocha: {
    timeout: 2000000
  },
  // etherscan: {
  //   // Your API key for Etherscan
  //   // Obtain one at https://etherscan.io/
  //   apiKey: process.env.ether_scan_api
  // },
  settings: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  }
};

