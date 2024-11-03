// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {SimpleStorage} from "./SimpleStorage.sol";
contract Storagefactory {
    SimpleStorage public simpleStorage;
    function CreateSimpleStorageContract() public {
        simpleStorage = new SimpleStorage();
    }
}