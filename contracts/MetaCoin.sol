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
		testAddresses[0] = 0x0120fe6e3aa2c936e6d2f88062b266c46c408f98;
		testAddresses[1] = 0xa8fc189694dc8ba03c027d470b77c09b7d13471e;
		testAddresses[2] = 0xdbf73038f3e4a5d27e38004c36dc6ce82165794f;
		testAddresses[3] = 0x692b50dc6d0021a73ec50fcd3ad78d3c121be360;
		testAddresses[4] = 0xc396dfc357c849c5e4fbbe1f130eb469675af895;
		testAddresses[5] = 0x07efc80760137f58a43e44a9bede15da8053d730;
		testAddresses[6] = 0xfe8699b505180f51966e56f118e66544dea311bd;
		testAddresses[7] = 0x276ae02aa2710bebc571f3647d64d9b440f998d6;
		testAddresses[8] = 0x43882f2be5ccf7ba1cf848e202683385d5fb93bb;
		testAddresses[9] = 0x76c780eb591481c086e1a0574b16c4f52e5aa352;
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
