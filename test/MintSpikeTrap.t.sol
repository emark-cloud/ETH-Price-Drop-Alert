// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/MintSpikeTrap.sol";

contract MintSpikeTrapTest is Test {
    MintSpikeTrap trap;

    address user1 = address(0x123);
    address user2 = address(0x456);

    function setUp() public {
        trap = new MintSpikeTrap();
    }

    function testCheckReturnsFalseInitially() public {
        bytes memory data = trap.check(user1, user2, "");
        bool triggered = abi.decode(data, (bool));
        assertFalse(triggered, "Trap should not trigger initially");
    }

    function testCheckTriggersAfterMint() public {
        // simulate a spike (just encode data manually for now)
        bytes memory fakeData = abi.encode(true);

        bytes memory result = trap.check(user1, user2, fakeData);
        bool triggered = abi.decode(result, (bool));
        assertTrue(triggered, "Trap should trigger after spike detected");
    }
}
