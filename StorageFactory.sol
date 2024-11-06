// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {SimpleStorage} from "./SimpleStorage.sol";
contract Storagefactory {
    SimpleStorage[] public listOfSimplestorgaeContracts;
    function CreateSimpleStorageContract() public {
        SimpleStorage simpleStorageContract = new SimpleStorage();
        listOfSimplestorgaeContracts.push(simpleStorageContract);
    }
}