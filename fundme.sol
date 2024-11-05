// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./GetConversionRate.sol";

contract Fundme {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    using PriceConverter for uint256;
    uint256 public minimumUSD = 5 * 1e18;
    address[] public Funders;
    mapping (address funder => uint256 Amount) AmountSentByFunder;
    function fund() public payable {
        require(msg.value.GetConversionRate() >= minimumUSD, "didn't send enough");
        Funders.push(msg.sender);
        AmountSentByFunder[msg.sender] = AmountSentByFunder[msg.sender] + msg.value;
    }

    function Withdraw() public OnlyOwner {
        for (uint256 funderIndex = 0; funderIndex < Funders.length; funderIndex++) {
            address currentFunder = Funders[funderIndex];
            AmountSentByFunder[currentFunder] = 0;
        }
        Funders = new address[](0);

        // //tranfser
        // payable(msg.sender).transfer(address(this).balance);

        // //send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "send failed");

        //call
        (bool callSuccess, ) = msg.sender.call{value: address(this).balance}("");
        require(callSuccess, "call failed");
    }

    modifier OnlyOwner {
        require(msg.sender == owner, "sender is NOT Onwer");
        _;
    }
    
}