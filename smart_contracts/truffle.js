
var HDWalletProvider = require("truffle-hdwallet-provider");
var mnemonic = "follow gloom sell picnic mad soap fringe humble mention nature avocado auto";  //from metamask

// https://rinkeby.etherscan.io/address/0xd299cae6bb8ff03b3b4b4dddbc757c2ddb7c4d26   (rinkeby faucet)

module.exports = {
  networks: { 
    development: {
      host: '127.0.0.1',
      port: 8080,
      network_id: "*"
    }, 
    rinkeby: {
      provider: function() { 
        return new HDWalletProvider(mnemonic, 'https://rinkeby.infura.io/v3/a331a94331134e898c682da22bd49487') 
      },
      network_id: 4,
      gas: 4500000,
      gasPrice: 10000000000,
    }
  }
};

// URL of contract creation TX
// https://rinkeby.etherscan.io/tx/0x4b04e56feb79fbd8493056cfb1ecae5ce64d1511696b3caf0f20be5dfe2077a3

// Contract page on Etherscan
// https://rinkeby.etherscan.io/address/0x4b54e06131884604cc75501bfc30b44e0d0d70f9

// Link to Token Tracker
// https://rinkeby.etherscan.io/token/0x4b54e06131884604cc75501bfc30b44e0d0d70f9