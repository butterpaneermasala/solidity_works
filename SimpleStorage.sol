// SPDX-License-Identifier: MIT
pragma solidity 0.8.28; // solidity version, "pragma defines the solidity version that is going to be used"

contract SimpleStorage {
    struct Person {
        string Name;
        uint256 favoriteNumber;
    }
    Person[] public listOfPeople;
    function AddPeople(string memory _Name, uint256 _favoriteNumber) public {
        Person memory Newperson = Person({Name : _Name,favoriteNumber: _favoriteNumber});
        listOfPeople.push(Newperson);
    }

    function retriveData(string memory _Name) public view returns(uint256) {
        for (uint256 i = 0; i < listOfPeople.length; i++) {
            if (keccak256(bytes(listOfPeople[i].Name)) == keccak256(bytes(_Name))) {
                return listOfPeople[i].favoriteNumber;
            }
        }
        revert("person NOT found");
    }
}