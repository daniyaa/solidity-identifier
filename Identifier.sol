//SPDX-License-Identifier: GLP-3.0

pragma solidity ^0.8.0;

contract identity
{
    string name;
    uint age;

    constructor()
    {
        name = "Daniya";
        age = 21;
    }

    function getName() view public returns(string memory)
    {
        return name;
    }
    function getAge() view public returns(uint)
    {
        return age;
    }
    function setAge() public
    {
        age = age + 1;
    }
}