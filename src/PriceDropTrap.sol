// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { ITrap } from "drosera-contracts/interfaces/ITrap.sol";


contract PriceDropTrap is ITrap {
    int256 private lastPrice;

    constructor() {
        // Start with a dummy price of $2000 (8 decimals assumed)
        lastPrice = 2000 * 1e8;
    }

    // This is called periodically by Drosera to collect data
    function collect() external override returns (bytes memory) {
        // Instead of fetching from Chainlink, simulate a drop for testing
        int256 fakePrice = lastPrice - int256(100 * 1e8); // Drop $100 each collect
        lastPrice = fakePrice;
        return abi.encode(fakePrice);
    }

    // Decide if we should respond based on collected data
    function shouldRespond(bytes[] calldata collectedData)
        external
        override
        returns (bool, bytes memory)
    {
        // Expecting the most recent collected data at index 0
        int256 currentPrice = abi.decode(collectedData[0], (int256));

        // Trigger if drop is more than $50 from lastPrice
        bool trigger = (lastPrice - currentPrice) > int256(50 * 1e8);

        return (trigger, abi.encode(currentPrice));
    }
}
