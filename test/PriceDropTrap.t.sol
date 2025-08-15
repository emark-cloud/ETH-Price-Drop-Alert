// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/PriceDropTrap.sol";

/// @dev Minimal mock with the same ABI as Chainlink's aggregator (we'll etch it to the feed address)
contract MockPriceFeed {
    // Slot 0: price (int256)
    int256 public price;

    function latestRoundData()
        external
        view
        returns (uint80, int256, uint256, uint256, uint80)
    {
        return (0, price, 0, block.timestamp, 0);
    }
}

contract PriceDropTrapTest is Test {
    PriceDropTrap trap;
    MockPriceFeed mock;

    // Must match the constant in PriceDropTrap
    address constant FEED = 0x1234567890123456789012345678901234567890;

    function setUp() public {
        trap = new PriceDropTrap();
        mock = new MockPriceFeed();

        // Put the mock's code at the feed address so trap.collect() calls our mock
        vm.etch(FEED, address(mock).code);

        // Initialize price above threshold: $2,000 * 1e8
        _setFeedPrice(2_000e8);
    }

    function test_NoTrigger_AboveThreshold() public {
        _setFeedPrice(1_600e8);

        bytes memory collected = trap.collect();
        bytes;
        arr[0] = collected;

        (bool should, ) = trap.shouldRespond(arr);
        assertFalse(should, "Should NOT trigger when price above threshold");
    }

    function test_Trigger_BelowThreshold() public {
        _setFeedPrice(1_400e8);

        bytes memory collected = trap.collect();
        bytes;
        arr[0] = collected;

        (bool should, bytes memory resp) = trap.shouldRespond(arr);
        assertTrue(should, "Should trigger when price below threshold");

        int256 p = abi.decode(resp, (int256));
        assertEq(p, 1_400e8);
    }

    /// @dev Helper to write the price into slot 0 of the feed address (since we etched the mock code there)
    function _setFeedPrice(int256 newPrice) internal {
        // Storage slot 0 stores `price`
        vm.store(FEED, bytes32(uint256(0)), bytes32(uint256(int256(newPrice))));
    }
}
