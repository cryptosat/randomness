import '@nomiclabs/hardhat-ethers'
import '@nomiclabs/hardhat-truffle5'
import 'hardhat-abi-exporter'

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  abiExporter: {
    path: './abi',
  },
  paths: {
    sources: './contracts',
    tests: './test',
    cache: './cache',
    artifacts: './artifacts',
  },
  solidity: {
    // The latest version supported by hardhat is 0.8.9.
    // https://hardhat.org/reference/solidity-support#supported-versions
    version: '0.8.9',
  },
}
