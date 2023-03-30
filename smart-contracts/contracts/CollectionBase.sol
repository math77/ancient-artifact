//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.9;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";

import { Base64 } from "./libraries/Base64.sol";


import "hardhat/console.sol";

contract CollectionBase is ERC721Upgradeable, OwnableUpgradeable {
  //address private deployer;
  uint256 private _tokenId = 1;
  string private cName;

  function initialize(string memory name, string memory symbol, address owner) initializer public {
    __Ownable_init();
    __ERC721_init(name, symbol);
    cName = name;
  }


  function mint(address minter) payable public {
    require(minter != address(0), "Wrong");

    unchecked {
      _safeMint(minter, ++_tokenId);
    }
  }

  function tokenURI(uint256 tokenId) public view override returns(string memory) {
    return string(
      abi.encodePacked(
        'data:application/json;base64,',
        Base64.encode(
          abi.encodePacked(
            '{"name":"', cName, '#',
            toString(tokenId),
            '","description": "Experiment."',
            '","image": "data:image/svg+xml;base64,',
            Base64.encode(abi.encodePacked("<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width='100%' height='100%' fill='green' /><text x='30' y='30' class='base'>EXPERIMENT</text></svg>")),
            '"}'
            ))));
  }

  function toString(uint256 value) internal pure returns (string memory) {
    // Inspired by OraclizeAPI's implementation - MIT license
    // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

    if (value == 0) {
      return "0";
    }

    uint256 temp = value;
    uint256 digits;
    while (temp != 0) {
      digits++;
      temp /= 10;
    }

    bytes memory buffer = new bytes(digits);
    while (value != 0) {
      digits -= 1;
      buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
      value /= 10;
    }

    return string(buffer);
  }

}
