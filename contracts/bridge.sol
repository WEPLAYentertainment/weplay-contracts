pragma solidity ^0.4.24;

import "./own.sol";

contract Bridge is Ownable {

	uint256 private k_in;
	uint256 private k_out;

	function () payable public {
		transIn();
	}

	function transIn() public pure{
		// user tx
	}

	function transOut() public pure{
		// oracles tx
	}

}