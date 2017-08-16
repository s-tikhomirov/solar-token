pragma solidity ^0.4.13;

// This is just a simple example of a coin-like contract.
// It is not standards compatible and cannot be expected to talk to other
// coin/token contracts. If you want to create a standards-compliant
// token, see: https://github.com/ConsenSys/Tokens. Cheers!

import "./ERC223/ERC223BasicToken.sol";

contract MetaCoin is ERC223BasicToken {

	function MetaCoin() { }

	function sendCoin(address receiver, uint amount) returns(bool sufficient) {
		transfer(receiver, amount);
		return true;
	}

	function getBalance(address addr) returns(uint) {
		return balanceOf(addr);
	}
}
