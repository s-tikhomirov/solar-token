//var ConvertLib = artifacts.require("./ConvertLib.sol");
var MetaCoin = artifacts.require("./MetaCoin.sol");

module.exports = function(deployer) {
  //deployer.deploy(ConvertLib);
  //deployer.link(ConvertLib, MetaCoin);
  // Arguments: not in browser-solidity mode; 10*10 tokens for pre-allocation; 100 wei cap; 600 sec deadline
  //deployer.deploy(MetaCoin, false, 10, 1000, 600);
  deployer.deploy(MetaCoin);
};
