// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/chiru-labs/ERC721A/blob/main/contracts/ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract KaiERC721 is ERC721A, Ownable {

    
     constructor(
       
       ) ERC721A("KaiGen", "KaGE") {
        transferOwnership(msg.sender);
        }    
    function _baseURI() internal pure override returns (string memory) {
        return 'https://boredapeyachtclub.com/api/mutants/';
    }

    function tokenURI(uint256 tokenId) public view  override returns (string memory) {
        if (!_exists(tokenId)) _revert(URIQueryForNonexistentToken.selector);

        string memory baseURI = _baseURI();
        return bytes(baseURI).length != 0 ? string(abi.encodePacked(baseURI, _toString(tokenId))) : '';
    }

    function mint(
        address to,
        uint256 quantity
    ) public onlyOwner{
       _mint(to, quantity);
              
    }
    function burn(uint256 tokenId) public onlyOwner returns (string memory) {
        _burn(tokenId);
        return "Token burned";
    }
}
   