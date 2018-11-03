pragma solidity ^0.4.24;

contract Ownable {

  address private owner;

  event onTransferOwnership(address oldOwner,address newOwner);

 constructor() public {
    owner = msg.sender;
  }

 modifier onlyOwner() {
    require(owner == msg.sender);
    _;
  }


 function getOwner() public view returns(address) {
    return owner;
 }

 function transferOwnership(address newOwner) public onlyOwner{
 	require(address(0)!=newOwner);
 	owner = newOwner;
 	emit onTransferOwnership(owner,newOwner);
 }

}
