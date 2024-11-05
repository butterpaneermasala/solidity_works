// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./GetConversionRate.sol";

contract Fundme {

    using PriceConverter for uint256;
    uint256 public minimumUSD = 5 * 1e18;
    address[] public Funders;
    mapping (address funder => uint256 Amount) AmountSentByFunder;
    function fund() public payable {
        require(msg.value.GetConversionRate() >= minimumUSD, "didn't send enough");
        Funders.push(msg.sender);
        AmountSentByFunder[msg.sender] = AmountSentByFunder[msg.sender] + msg.value;
    }

    
}