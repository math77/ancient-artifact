//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/proxy/Clones.sol";
import "./CollectionBase.sol";

contract Factory {
    address immutable tokenImplementation;

    constructor() public {
      tokenImplementation = address(new CollectionBase());
    }

    function createToken(string calldata name, string calldata symbol) public returns (address) {
      address clone = Clones.clone(tokenImplementation);
      CollectionBase(clone).initialize(name, symbol, msg.sender);
      return clone;
    }
}
