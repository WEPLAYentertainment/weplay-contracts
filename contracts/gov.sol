pragma solidity ^0.4.24;

import "./own.sol";

contract Gov is Ownable {

  mapping (address => uint32) private m;
  uint32[] private v;

  uint32  private memberCount; 
  uint32  private voteCount; 
  uint256 private endTime; 

  constructor (address[] group) public
  {
      voteCount = 1;
      for (uint i = 0; i < group.length; i++)
      {
        address member = group[i];
        m[member] = voteCount;
      }
      memberCount=uint32(group.length);
      v.length = 2;
  }

  function add(address member) public {
    require(!isVoting());
    require(m[member]==0);
    m[member] = voteCount;
    memberCount++;
  }

  function del(address member) public {
    require(!isVoting());
    require(m[member]!=0);
    m[member] = 0;
    memberCount--;
  }


  function vote(address member, uint32 i) public {
    require(isVoting());
    require(m[member]==voteCount);
    require(i<v.length);
    v[i]++;
  }


  function restart(uint32 vT,uint8 varNum) public onlyOwner{
    require(varNum>=2);
    v.length=varNum;
    for(uint32 i=0;i<varNum;i++){
      v[i]=0;
    }
    endTime=now+vT;    
  }

  function isVoting() private view returns(bool){
    return endTime>now;
  }

}