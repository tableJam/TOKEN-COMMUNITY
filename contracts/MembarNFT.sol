// SPDX-License-Identifier: MIT

pragma solidity  ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MemberNFT is ERC721Enumerable, ERC721URIStorage ,Ownable{
    
    using Counters for Counters.Counter;
    Counters.Counter private tokenIDs;

    constructor() ERC721("MemberNFT","MEMN"){}

    event tokenURIchange(address indexed to, uint256 tokenID, string uri);

    /**
     * - @dev
     * permitted is only Owner;
     */
    function mintNFT(address to, string calldata uri) external onlyOwner {
       tokenIDs.increment();
       uint newTokenId = tokenIDs.current();
       _mint(to, newTokenId);
       _setTokenURI(newTokenId, uri);
       emit tokenURIchange(to, newTokenId, uri);
    }
    /**
     * - @dev
     * override
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721,ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }
    
    /**
     * - @dev
     * override
     */
    function _burn(uint256 tokenId) internal override(ERC721,ERC721URIStorage) {
        super._burn(tokenId);
    }

    /**
     * - @dev
     * override
     */
    function supportsInterface(bytes4 interfaceId) public view override(ERC721,ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    /**
     * - @dev
     * override
     */
    function tokenURI(uint256 tokenId) public view override(ERC721,ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }
}