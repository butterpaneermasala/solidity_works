// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {SimpleStorage} from "./SimpleStorage.sol";

contract Addplusseven is SimpleStorage {
    function store(uint256 _myFavoreiteNumber) public override {
        myFavoriteNumber = _myFavoreiteNumber + 7;
    }
}
