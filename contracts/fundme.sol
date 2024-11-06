// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";



error NOTowner();

contract Fundme {

    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }
    function GetPrice() public view returns(uint256) {
        AggregatorV3Interface PriceFeed = AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF);
        (, int256 price, , ,) = PriceFeed.latestRoundData();
        return uint256(price * 1e10);
    }

    function GetConversionRate(uint256 ethAmount) public view returns(uint256) {
        uint256 ethPrice = GetPrice();
        uint256 ethPriceinUSD = (ethPrice * ethAmount) / 1e18;
        return ethPriceinUSD;
    }

    function GetVersion() public view returns(uint256) {
        return AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF).version();
    }
    uint256 public constant minimumUSD = 5 * 1e18;
    address[] public Funders;
    mapping (address funder => uint256 Amount) AmountSentByFunder;

    function fund() public payable {
        require(GetConversionRate(msg.value) >= minimumUSD, "didn't send enough");
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
        // require(msg.sender == i_owner, "sender is NOT Onwer");
        if (msg.sender != i_owner) {
            revert NOTowner();
        }
        _;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable { 
        fund();
    }
    
}