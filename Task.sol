// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./ERC1155.sol";
import "./ERC721A.sol";
import "./ERC20.sol";


contract TokenMinter is Ownable {
    // ERC721 Token
    KaiERC721 public erc721Token;
    // ERC1155 Token
    KaiERC1155 public erc1155Token;
    // ERC20 Token
    KaGEToken public erc20Token;
    uint256 public nftSuplly = 0;
    constructor() {
        erc20Token = new KaGEToken();
        erc721Token = new KaiERC721();
        erc1155Token = new KaiERC1155();
    }
    // 1 kaGE token == 0.001 ETH
    function buyErc721(uint256 quantity) public  payable 
    {
        require (msg.value == (quantity*1000000000000000),"The price of KaGE token is 0.001ETH");
        erc20Token.mint(msg.sender,quantity);
    }
    //minting of One NFT Cost == 2 erc20 token
    function mintERC721NFT(uint256 quantity)public {
        require (erc20Token.balanceOf(msg.sender)>= quantity*2,"Insufficient tokens to mint all");
        require(erc20Token.transferFrom(msg.sender,address(this),quantity*2),"Unable to get ERC20 tokens kindly aprove the contract");
        erc721Token.mint(msg.sender,quantity);
    }
    //Owner can withdraw His ERC20 tokens
    function withDrawERC20Tokens () public onlyOwner
    {   
        uint256 balance = erc20Token.balanceOf(address(this));
        require(balance!=0,"Contract has no tokens to withdraw");
          address _owner = owner();
        erc20Token.transfer(_owner,balance);
    }
    //function Burn the ERC721 nft
    function BurnERC721NFT(uint256 tokenId,uint256 quantity)public {
        require(erc721Token.ownerOf(tokenId)==msg.sender,"Only Owner of NFT can Burn the Token");
        erc721Token.burn(tokenId);
      
        erc1155Token.mint(msg.sender,tokenId,quantity);
    }
    function withDrawEth() public onlyOwner 
    {
         require(address(this).balance >= 0, "Insufficient balance");
        payable(owner()).transfer(address(this).balance);
    }
   
    
}
