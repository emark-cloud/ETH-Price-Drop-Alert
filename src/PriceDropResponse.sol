// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @notice Minimal response contract that just emits the price
contract PriceDropResponse {
    event PriceAlert(int256 price);

    function onIncident(int256 price) external {
        emit PriceAlert(price);
    }
}
