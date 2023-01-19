//SPDX-Licese-Identifier: MIT
pragma solidity ^0.7.5;
//written for solidity version 0.4.18 and above that doesn't break functionality 
contract Voting
{
    address owner;
    constructor()
    {
        owner=msg.sender;
    }
    modifier onlyOwner
    {
        require(msg.sender == owner);
        _;
    }

    struct voter
    {
        uint candidateIDVote;
        bool hasVoted;
        bool isAuthorized;
    }
    struct CandidateProfile
    {
        string name;
        string party;
        uint noOFVOTES;
        bool doesExist;
    }

//state variables used to keep track fo the number of candidates and voters

    uint numCandidates;
    uint numOFVOTERS;
    uint TOTnumOFVOTES;

//these mappings will hold the candidates and voters respectively by making a connection

    mapping(uint => CandidateProfile) candidates;
    mapping(address => voter) voters;

//these following functions perform transactions and edit the mappings
//AddCandidate function can be accessed only by the owner of the contract

    function AddCandidate(string memory name, string memory party) onlyOwner public
    {
        uint candidateID = numCandidates++;
        candidates[candidateID] = CandidateProfile(name,party,0,true);

    }

//this function can be accessed by voters authorized by the owner of the contract and also cannot vote twice

    function vote(uint candidateID) public
    {
        require(!voters[msg.sender].hasVoted);
        require(voters[msg.sender].isAuthorized);
        if(candidates[candidateID].doesExist == true)
        {
            voters[msg.sender] = voter(candidateID, true,true);
            candidates[candidateID].noOFVOTES++;
            numOFVOTERS++;
            TOTnumOFVOTES++;
        }
    }

    function Authorize(address _voter) onlyOwner public
    {
        //updating the boolean value of the voter structure by passing the key 
        voters[_voter].isAuthorized = true;
    } 

    /**********************GETTER FUNCTIONS**********************/

    function totalVotes(uint candidateID) view public returns(uint)
    {
        return candidates[candidateID].noOFVOTES;
    }

    function getNumOfCandidates() public view returns(uint)
    {
        return numCandidates;
    }

    function getNumOfVoters() public view returns(uint)
    {
        return TOTnumOFVOTES;
    }

//returning cadidate information,including its ID, name and party

    function getCandidate(uint candidateID) public view returns(uint,string memory,string memory,uint)
    {
        return(candidateID, candidates[candidateID].name, candidates[candidateID].party,candidates[candidateID].noOFVOTES);
    }


}