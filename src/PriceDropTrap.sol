// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { ITrap } from "drosera-contracts/interfaces/ITrap.sol";


interface IAggregatorV3 {
    function latestRoundData()
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );
}

/// @notice A simple Drosera Trap that triggers when ETH/USD price falls below a threshold
/// @dev Uses Chainlink-style price feeds with 8 decimals on answer
contract PriceDropTrap is ITrap {
    // Hardcoded for Drosera (no constructor args)
    address public constant PRICE_FEED = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419; // <- replace with real Chainlink feed
    int256  public constant MIN_PRICE  = 1500e8; // $1,500 with 8 decimals

    struct CollectOutput {
        int256 price;
    }

    /// @notice Collect latest price from the feed
    function collect() external view returns (bytes memory) {
        (, int256 answer, , , ) = IAggregatorV3(PRICE_FEED).latestRoundData();
        return abi.encode(CollectOutput({price: answer}));
    }

    /// @notice Decide if we should respond based on the most recent collect data
    /// @param data expects at least 1 element, with the most recent collect at data[0]
    function shouldRespond(bytes[] calldata data) external pure returns (bool, bytes memory) {
        require(data.length > 0, "No data");
        CollectOutput memory latest = abi.decode(data[0], (CollectOutput));
        if (latest.price < MIN_PRICE) {
            // Return the price so the response contract can log it
            return (true, abi.encode(latest.price));
        }
        return (false, bytes(""));
    }
}

