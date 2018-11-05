pragma solidity ^0.4.24;

import "./own.sol";
import "./lib.sol";

contract ID is Ownable{
  struct IDInfo{
  	bytes pub_key; // 03a619ae948151ed7d950fffe29b5903a13d812d3402e7811c647e602df661fd8b
  	bytes name; // John_Johnson
  	bytes details; // I'm a producer with some cute skills!
  	bytes tags; // producer star business
  	
  	bytes email; // john@johnson.com
    
    bytes[] links; // links to resources
  	bytes[] proofs; // proofs of resource ownership 

  	bytes kyc_proof; // kyc proof 

    uint256 created_at;
    uint256 updated_at; 
  }	

  mapping (address => IDInfo) private infos;

  uint32 public constant minPubKeyLen = 33; // check it
  uint32 public constant maxPubKeyLen = 1024; // check it

  uint32 public constant maxNameLen = 128;
  uint32 public constant minNameLen = 8;

  uint32 public constant maxDetailsLen = 1024;
  uint32 public constant minDetailsLen = 16;

//  uint32 public constant maxTagLen = 20;
//  uint32 public constant minTagLen = 2;

  uint32 public constant maxTagNum = 10;

  
  constructor() public{
  }

  function setNewIDInfo(bytes pub_key,bytes name,bytes details,bytes tags,bytes email) public {
  	address who=msg.sender;
  	require(infos[who].created_at==0);
  	//require(infos[who].name.length>=minNameLen);
  	//require(pub_key.length>=minPubKeyLen && pub_key.length<=maxPubKeyLen);
  	//require(name.length>=minNameLen && name.length<=maxNameLen);
  	//require(details.length>=minDetailsLen && details.length<=maxDetailsLen);
  	// add more req

  	infos[who].pub_key=pub_key;
  	infos[who].name=name;
  	infos[who].details=details;
  	infos[who].tags=tags;
  	infos[who].email=email;
  	infos[who].created_at=now;
  	infos[who].updated_at=now;  	
  }

  function getIdInfo(address who) public view returns(
  	bytes,
  	bytes,
  	bytes, // pub_key,name,details,
  	bytes, // tags
  	bytes, // email
  	uint256,uint256){
  	IDInfo memory ii=infos[who];
  	return (
  		ii.pub_key,
  		ii.name,
  		ii.details,
  		ii.tags,
  		ii.email,
  		ii.created_at,
  		ii.updated_at
  	);
  }  

  function setIDInfoDetails(bytes details) public {
  	address who=msg.sender;
  	require(details.length>=minDetailsLen && details.length<=maxDetailsLen);
  	if(infos[who].details.length==0){
  		infos[who].created_at=now;
  	}
  	infos[who].details=details;
	  infos[who].updated_at=now;
  }  


}