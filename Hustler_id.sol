// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract HustlerIdentity is ERC721Enumerable, Ownable {
    using Strings for uint256;

    mapping(uint256 => uint256) public playerRank; 
    mapping(uint256 => string) public rankTitles;

    constructor() ERC721("Serpent Hustler", "HUSTL") Ownable(msg.sender) {
        rankTitles[0] = "Maestro Alumni";
        rankTitles[1] = "Intern";
        rankTitles[2] = "Jr Developer";
        rankTitles[3] = "Sr Developer";
        rankTitles[4] = "Legend";
        rankTitles[5] = "Myth";
        rankTitles[6] = "Supreme Architect";
    }

    function mintIdentity() external {
        uint256 tokenId = totalSupply() + 1;
        _safeMint(msg.sender, tokenId);
        playerRank[tokenId] = 0; // Starts as Maestro Alumni
    }

    function setRank(uint256 tokenId, uint256 newRank) external onlyOwner {
        require(newRank <= 6, "Rank out of bounds");
        playerRank[tokenId] = newRank;
    }

    // This function will eventually point to your Python-driven Metadata Server
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireOwned(tokenId);
        return string(abi.encodePacked("https://api.sophiaserpent.com/metadata/", tokenId.toString()));
    }
}
