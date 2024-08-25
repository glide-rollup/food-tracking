require("@nomicfoundation/hardhat-toolbox");

const GLIDE_PRIVATE_KEY = "0x000000000000000000000000000000000000000000000000000";
const GLIDE_RPC_URL = "xxxxxxxxxxxxxxxx";

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  networks: {
    glide: {
      url: GLIDE_RPC_URL,
      chainId: 901,
      gasPrice: "auto",
      accounts: [GLIDE_PRIVATE_KEY],
    },
  },

  solidity: {
    version: "0.8.26",
    settings: {
      viaIR: true,
      optimizer: {
        enabled: true,
        runs: 200
      },
    }
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  },
  etherscan: {
    apiKey: {
      'glide': 'empty'
    },
    customChains: [
      {
        network: "glide",
        chainId: 901,
        urls: {
          apiURL: "",
          browserURL: ""
        }
      }
    ]
  }
};
