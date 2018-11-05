pragma solidity ^0.4.24;

import "./erc20i.sol";
import "./own.sol";
import "./SafeMath.sol";

contract ERC20Token is ERC20I,Ownable {
  using SafeMath for uint256;

  mapping (address => uint256) private balances;
  mapping (address => mapping (address => uint256)) private allowed;
  uint256 private _totalSupply;

  function totalSupply() public view returns (uint256) {
    return _totalSupply;
  }

  function balanceOf(address owner) public view returns (uint256) {
    return balances[owner];
  }

  function allowance(address owner,address spender) public view returns (uint256) {
    return allowed[owner][spender];
  }

  function transfer(address to, uint256 value) public returns (bool) {
    require(value <= balances[msg.sender]);
    require(to != address(0));
    balances[msg.sender] = balances[msg.sender].sub(value);
    balances[to] = balances[to].add(value);
    emit Transfer(msg.sender, to, value);
    return true;
  }

  function approve(address spender, uint256 value) public returns (bool) {
    require(spender != address(0));
    allowed[msg.sender][spender] = value;
    emit Approval(msg.sender, spender, value);
    return true;
  }

  function transferFrom(address from,address to, uint256 value)public returns (bool) {
    require(value <= balances[from]);
    require(value <= allowed[from][msg.sender]);
    require(to != address(0));
    balances[from] = balances[from].sub(value);
    balances[to] = balances[to].add(value);
    allowed[from][msg.sender] = allowed[from][msg.sender].sub(value);
    emit Transfer(from, to, value);
    return true;
  }


  function burn(address account,uint256 amount) public onlyOwner returns(bool) {
    require(amount <= balances[account]);
    _totalSupply = _totalSupply.sub(amount);
    balances[account] = balances[account].sub(amount);
    emit Transfer(account, address(0), amount);
    return true;
  }

  function mint(address to, uint256 amount) public onlyOwner returns(bool)  {
    require(to != 0);
    balances[to] = balances[to].add(amount);
    _totalSupply = _totalSupply.add(amount);
    emit Transfer(address(0), to, amount);
    return true;
  }



}
