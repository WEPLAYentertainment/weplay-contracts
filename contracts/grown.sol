pragma solidity ^0.4.24;

import "./own.sol";

contract GroupOwnable is Ownable {

  mapping (address => bool) private owners;

  event onAddGroupOwner(address owner);

 constructor() public {
  }

 modifier onlyGroupOwners() {
    require(owners[msg.sender]);
    _;
  }


 function isGroupOwner(address owner) public view returns(bool) {
    return owners[owner];
 }

 function addGroupOwner(address owner) public onlyOwner{
 	require(address(0)!=owner);
 	require(!owners[msg.sender]);
 	owners[owner]=true;
 	emit onAddGroupOwner(owner);
 }

}
