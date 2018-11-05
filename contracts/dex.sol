pragma solidity ^0.4.24;

import "./own.sol";

contract DEX is Ownable {

	struct OrderInfo{
		string from;
		uint256 value;
		string to;
	}

	mapping( address => OrderInfo) private om; 

	function () payable public{
		revert();
	}

	function order() payable public{
		// push order
	}

}