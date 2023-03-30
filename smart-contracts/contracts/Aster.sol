//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.9;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';
import {ReentrancyGuard} from '@openzeppelin/contracts/security/ReentrancyGuard.sol';
import {IAsterMetadata} from "./interfaces/IAsterMetadata.sol";
import {Factory} from "./Factory.sol";
import {CollectionBase} from "./CollectionBase.sol";
import {AncientData} from "./AncientData.sol";

import {AsterIDE} from "./AsterIDE.sol";
import {IAster} from "./interfaces/IAster.sol";

import "hardhat/console.sol";

//Used to mint the artifact.
contract Aster is ERC721, Ownable, ReentrancyGuard {
  uint256 private _tokenId = 1;

  address[] private results;

  address immutable factoryAddress;
  address immutable metadataAddress;
  address immutable dataAFactory;
  address immutable asterIDEAddress;

  error MetadataAddressNotSetted();
  error MaxSupplyReached();
  error PaymentAmountInvalid();
  error NotDeviceOwner();

  /*
  modifier onlyInEclipseDate() {
  }

  modifier onlyPaymentAmountIsValid(uint256 amount) {
  }

  modifier onlyIfMaxSupplyNotReached() {
  }

  modifier onlyDeviceOwner(address addr) {
  }
  */


  constructor(address factory, address dataA, address asterIDE, address metadata) ERC721("Aster", "AC") Ownable() {
    factoryAddress = factory;
    dataAFactory = dataA;
    metadataAddress = metadata;
    asterIDEAddress = asterIDE;
  }

  function claim() payable external {

    //require(block.timestamp > AncientData(dataAFactory).getDate(0) && block.timestamp < AncientData(dataAFactory).getDate(0) + 24 hours, "time passed.");

    unchecked {
      _safeMint(msg.sender, _tokenId++);
    }
  }

  function programmingV1(IAster.InterstellarSoftware calldata soft) external {
    AsterIDE(asterIDEAddress).programmingSymbolsV1(soft);
  }

  /*
  function programmingV2(uint8 symbol1, uint8 symbol2, uint8 symbol3, uint8 symbol4, uint256[] calldata values1, uint256[] calldata values2, uint256[] calldata values3, uint256[] calldata values4) external {
    AsterIDE(asterIDEAddress).programmingSymbolsV2(symbol1, symbol2, symbol3, symbol4, values1, values2, values3, values4);
  }
  */

  function nextToken() external view returns(uint256) {
    return _tokenId;
  }

  function getToken() payable external {
    CollectionBase(results[0]).mint(msg.sender);
  }

  //how generate "dynamically"?
  function newComb() payable external {
    address res = Factory(factoryAddress).createToken("CollA", "CLA");

    results.push(res);
  }

  function getResults() public view returns(address[] memory) {
    return results;
  }

  function tokenURI(uint256 tokenId) public view override returns (string memory) {
    if(metadataAddress == address(0)) revert MetadataAddressNotSetted();
    return IAsterMetadata(metadataAddress).tokenURI(tokenId);
  }
  /*
  function tokenHTML(uint256 tokenId) public view returns (string memory) {
    return IAsterMetadata(metadataAddress).tokenHTML(tokenId);
  }

  function tokenSVG(uint256 tokenId) public view returns (string memory) {
    return IAsterMetadata(metadataAddress).tokenSVG(tokenId);
  }
  */

  function withdrawAll() external onlyOwner nonReentrant {
    payable(owner()).transfer(address(this).balance);
  }

  function withdrawAllERC20(IERC20 erc20Token) external onlyOwner nonReentrant {
    erc20Token.transfer(owner(), erc20Token.balanceOf(address(this)));
  }

}
