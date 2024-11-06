// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
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
}