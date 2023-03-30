//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.9;

import {IAster} from "./interfaces/IAster.sol";

import "hardhat/console.sol";


//Interstellar Development Environment.
contract AsterIDE is IAster {

  uint256 private _softwareIds = 1;

  //locked
  mapping(bytes32 => bool) public lockedHashes;
  //already programmed forever.
  mapping(bytes32 => bool) public programmedHashes;
  mapping(bytes32 => LockSymbols) public lockedSymbols;

  mapping(uint256 => InterstellarSoftware) public softwares;


  error SymbolsAlreadyLocked();
  error SymbolsAlreadyProgrammed();

  /*
  function lockSymbols(uint256[] calldata symbolIds, address programmer) internal returns (bool) {


    bytes32 symbolsHash = keccak256(abi.encodedPacked(symbolIds));

    if(programmedHashes[symbolsHash]) revert SymbolsAlreadyProgrammed();
    if(lockedHashes[symbolsHash]) revert SymbolsAlreadyLocked();

    LockSymbols memory ls = LockSymbols({
      symbolIds: symbolIds,
      unlockDate: block.timestamp + 7 days,
      programmer: programmer
    });

    lockedSymbols[symbolsHash] = ls;
    lockedHashes[symbolsHash] = true;
  }
  */

  function programmingSymbolsV1(InterstellarSoftware calldata soft) public returns (bool) {
    bytes32 symbolsHash = keccak256(abi.encodePacked(soft.symbols));

    if(programmedHashes[symbolsHash]) revert SymbolsAlreadyProgrammed();

    softwares[++_softwareIds] = soft;

    return true;
  }

  /*
  function programmingSymbolsV2(uint8 symbol1, uint8 symbol2, uint8 symbol3, uint8 symbol4, uint256[] calldata values1, uint256[] calldata values2, uint256[] calldata values3, uint256[] calldata values4) public returns (bool) {
    return true;
  }
  */
}
