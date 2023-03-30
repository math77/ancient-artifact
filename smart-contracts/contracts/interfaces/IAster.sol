//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.9;

interface IAster {
  struct Symbol {
    uint id;
    string svg;
    string name;
  }

  struct LockSymbols {
    uint256[4] symbolIds;
    uint256 unlockDate;
    address programmer;
  }

  struct InterstellarSoftware {
    uint8[] symbols;
    uint32[] values1;
    uint32[] values2;
    uint32[] values3;
    uint32[] values4;
    address keyTokenAddress;
    bool useStellarClock;
  }
}
