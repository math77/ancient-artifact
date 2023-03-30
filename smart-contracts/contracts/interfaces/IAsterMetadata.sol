//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.9;

interface IAsterMetadata {
  function tokenURI(uint256 tokenId) external view returns (string memory);
  //function tokenHTML(uint256 tokenId) external view returns (string memory);
  //function tokenSVG(uint256 tokenId) external view returns (string memory);
}
