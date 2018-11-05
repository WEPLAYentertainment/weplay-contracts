pragma solidity ^0.4.24;

import "./erc20token.sol";

contract ERC20NameToken is ERC20Token {

  string private _name;
  string private _symbol;
  uint8 private _decimals; // 18 by default

  //uint256 public constant INITIAL_SUPPLY = 1000000 * (10 ** uint256(18));

  constructor(string name, string symbol, uint8 decimals, uint256 initial_supply) public {
    _name = name;
    _symbol = symbol;
    _decimals = decimals;
    mint(msg.sender,initial_supply);
  }

  function name() public view returns(string) {
    return _name;
  }

  function symbol() public view returns(string) {
    return _symbol;
  }

  function decimals() public view returns(uint8) {
    return _decimals;
  }
}

