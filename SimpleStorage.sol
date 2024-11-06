// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24; // solidity version, "pragma defines the solidity version that is going to be used"

contract SimpleStorage {
    uint256 myFavoriteNumber;
    function store(uint256 _myFavoreiteNumber) public virtual {
        myFavoriteNumber = _myFavoreiteNumber;
    }
    function seeMyFavoriteNumber() public view returns (uint256){
        return myFavoriteNumber;
    }
    struct Person {
        string Name;
        uint256 favoriteNumber;
    }
    mapping(string => uint256) public stringToFavoriteNumber; // mapping people to their favorite numbers
    Person[] public listOfPeople;
    function AddPeople(string memory _Name, uint256 _favoriteNumber) public {
        Person memory Newperson = Person({Name : _Name,favoriteNumber: _favoriteNumber});
        listOfPeople.push(Newperson);
        stringToFavoriteNumber[_Name] = _favoriteNumber;
    }

    function retreiveData(string memory _Name) public view returns(uint256) {
        return stringToFavoriteNumber[_Name];
    }
}