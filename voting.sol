// SPDX-License-Identifier:UNLICENSED

pragma solidity ^0.4.21;



contract Election{
  struct Candidate{
    string name;
    uint voteCount;

  }
  struct Voter{
    bool authorized;
    bool voted;
    uint vote;
  }
  address public owner;
  string public electionName;
  mapping(address=>Voter)public voters;
  Candidate[] public candidates;
  uint public totalVotes;

  modifier ownerOnly(){
    require(msg.sender== owner);//checks condition
    _;// execute remaining code
  }
  function Election(string _name1)public {
    owner=msg.sender;
    electionName =_name1;

  }
  

  function getNumCandidate()public view returns(uint){
    return candidates.length;
  }

  function addCandidate(string _name1)ownerOnly public{
     candidates.push(Candidate(_name1,0));
  }

  function authorize(address person1)ownerOnly public{
   voters[person1].authorized = true; 
  }
  function vote(uint voteindex1)public{
    require(!voters[msg.sender].voted);
    require(voters[msg.sender].authorized);


    voters[msg.sender].vote = voteindex1;
    voters[msg.sender].voted=true;

    candidates[voteindex1].voteCount+=1;
    totalVotes+=1;
  }

  function end()ownerOnly public{
    selfdestruct(owner);
  }
}
