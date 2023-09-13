// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract KaGEToken is ERC20, Ownable {
    constructor( ) ERC20("KaiGen", "KaGE") {
        _transferOwnership(msg.sender); 
    }

   function mint(
        address to,
        uint256 quantity
    ) public onlyOwner{
       _mint(to, quantity);
              
    }
}