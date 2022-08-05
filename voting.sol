// SPDX-License-Identifier:UNLICENSED

pragma solidity ^0.4.21;



contract vote{
  struct candidate{
    string name;
    uint votecount;

  }
  struct voter{
    bool authorized;
    bool voted;
    uint vote;
  }
  address public owner;
  string public electionname;
  mapping(address=>voter)public voters;
  candidate[] public candidates;
  uint public totalvotes;

  modifier owneronly(){
    require(msg.sender== owner);//checks condition
    _;// execute remaining code
  }
  function vote(string _name1)public {
    owner=msg.sender;
    electionname =_name1;

  }
  function addcandidate(string name1)owneronly view  public{
     candidates.push(candidate(name1,0));
  }

  function getNumcandidate()public view returns(uint){
    return candidates.length;
  }

  function authorize(address person1)owneronly public{
   voters[person1].authorized==true; 
  }
  function vote1(uint voteindex1)public{
    require(!voters[msg.sender].voted);
    require(voters[msg.sender].authorized);
    voters[msg.sender].vote=-voteindex1;
    voters[msg.sender].voted=true;
    candidates[voteindex1].votecount==1;
    totalvotes+=1;
  }
  function end()owneronly public{
    selfdestruct(owner);
  }
}