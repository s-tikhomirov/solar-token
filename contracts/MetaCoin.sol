pragma solidity ^0.4.13;

import "./ERC223/ERC223BasicToken.sol";

contract MetaCoin is ERC223BasicToken {
    
    // true means we are in browser-solidity, otherwise on RPC
    bool private DEBUG;
    
    string 	public name = "SolarToken";
	string 	public symbol = "SOL";
	//uint 	public decimals = 0;
	uint256  totalSupply = 10000;
	
	bool campaignOpen;
	bool goalReached;
	
	address public owner;
    uint public goal;
    uint public deadline;	// deadline = now + duration
    
    event BoughtTokens(address investor, uint amount);
    
    //uint public weiPerToken;

	//// TESTING ADDRESSES ////
	
    address[] private rpcTestAddresses;
    address[] private browserTestAddresses;
    uint public testBalance;
    
    function assignTestAddresses() internal {
		rpcTestAddresses.push(0x0120fe6e3aa2c936e6d2f88062b266c46c408f98);
		rpcTestAddresses.push(0xa8fc189694dc8ba03c027d470b77c09b7d13471e);
		rpcTestAddresses.push(0xdbf73038f3e4a5d27e38004c36dc6ce82165794f);
		rpcTestAddresses.push(0x692b50dc6d0021a73ec50fcd3ad78d3c121be360);
		rpcTestAddresses.push(0xc396dfc357c849c5e4fbbe1f130eb469675af895);
		rpcTestAddresses.push(0x07efc80760137f58a43e44a9bede15da8053d730);
		rpcTestAddresses.push(0xfe8699b505180f51966e56f118e66544dea311bd);
		rpcTestAddresses.push(0x276ae02aa2710bebc571f3647d64d9b440f998d6);
		rpcTestAddresses.push(0x43882f2be5ccf7ba1cf848e202683385d5fb93bb);
		rpcTestAddresses.push(0x76c780eb591481c086e1a0574b16c4f52e5aa352);
	
		browserTestAddresses.push(0xca35b7d915458ef540ade6068dfe2f44e8fa733c);
        browserTestAddresses.push(0x14723a09acff6d2a60dcdf7aa4aff308fddc160c);
        browserTestAddresses.push(0x4b0897b0513fdc7c541b6d9d7e929c4e5364d2db);
        browserTestAddresses.push(0x583031d1113ad414f02576bd6afabfb302140225);
        browserTestAddresses.push(0xdd870fa1b7c4700f2bd7f44238821c26f7392148);
    }
    
	function assignBalances(bool isRpc, uint _testBalance) internal {
	    assignTestAddresses();
	    var testAddresses = DEBUG ? browserTestAddresses : rpcTestAddresses;
		for (uint8 i = 0; i < testAddresses.length; i++) {
			balances[testAddresses[i]] = _testBalance;
		}
		balances[msg.sender] = totalSupply - testAddresses.length * testBalance;
	}
	
	//// CONSTRUCTOR ////
	
	function MetaCoin( bool _debug, uint _testBalance, uint _goal, uint _duration ) {
	    require(_goal > 0);
	    require(_duration > 0);
	    
		owner = msg.sender;
	    DEBUG = _debug;
	    goal = _goal;
		deadline = now + _duration * 1 seconds;
		
		campaignOpen = true;
		goalReached = false;
		
		// 10 test addresses get testBalance tokens each; msg.sender gets the rest
		testBalance = _testBalance;
		assignBalances(false, testBalance); // true = on RPC
	}
	

	function getMyBalance() constant returns (uint) {
	    return balanceOf(msg.sender);
	}
	
    function totalRaised() constant returns (uint) {
        return this.balance;
    }
    
    function weiToTokens(uint _wei) returns (uint tokens) {
        return _wei;
    }
	
    
    function () payable {
        
		require (now < deadline);
		require (campaignOpen);
		
		var tokens = weiToTokens(msg.value);
		
		// TODO: use SafeMath? sub() doesn't work, why?
		balances[owner] -= tokens;
		balances[msg.sender] += tokens;
		BoughtTokens(msg.sender, tokens);
		
		if (this.balance >= goal) {
			campaignOpen = false;
			goalReached = true;
		}
		
    }
    
    
	
}
