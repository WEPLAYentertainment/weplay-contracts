pragma solidity ^0.4.24;

import "./erc20nametoken.sol";
//import "own.sol";

contract WPL is ERC20NameToken {

  constructor(uint256 initial_supply) public 
    ERC20NameToken("weplay","WPL",18,initial_supply){
  }

}

