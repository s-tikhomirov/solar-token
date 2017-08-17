pragma solidity ^0.4.13;

// This is just a simple example of a coin-like contract.
// It is not standards compatible and cannot be expected to talk to other
// coin/token contracts. If you want to create a standards-compliant
// token, see: https://github.com/ConsenSys/Tokens. Cheers!

import "./ERC223/ERC223BasicToken.sol";

contract MetaCoin is ERC223BasicToken {

	/*
		Testing addresses generated from seed.txt
	*/
    address[10] private testAddresses;
    uint private testBalance = 100;
    
    function assignTestAddresses() internal {
		testAddresses[0] = 0x00b35291d1844ceecf24ccb64d9d89df94c43393;
		testAddresses[1] = 0xf14ef8908770ee9edb567a8e30dfe7f35e0f9665;
		testAddresses[2] = 0x008b12c3bb5e83a99308fed2047777eca5eaac66;
		testAddresses[3] = 0x0d06d3207f4909ce883ab331273848f8e15a0f23;
		testAddresses[4] = 0xd0f38630e43b6f1d04944767b8ac0fd266b116d4;
		testAddresses[5] = 0x231fd5abf045fad239c115c36c20f9ec1e8d3cca;
		testAddresses[6] = 0x6cf26481d38988e3dbd7ef06834d56af8970c958;
		testAddresses[7] = 0xeef7e160a0d5313916d460ce86f90dc3530de0f0;
		testAddresses[8] = 0xd9ea475bc4f73307e9774c8ce0315b0e435d0490;
		testAddresses[9] = 0xecf3c1eb8cf920bd79a96a3a3f0c7cc689dd6be0;
    }

	function assignTestCoins(uint _testBalance) internal {
		for (uint8 i = 0; i < testAddresses.length; i++) {
			balances[testAddresses[i]] = _testBalance;
		}
	}
	
	function MetaCoin() {
		assignTestAddresses();
		assignTestCoins(testBalance);
	}
	
	function getBalance(address _addr) returns(uint) {
		return balances[_addr];
	}
	
	function sendCoin(address _to, uint _value) {
		transfer(_to, _value);
	}
	
	
}
