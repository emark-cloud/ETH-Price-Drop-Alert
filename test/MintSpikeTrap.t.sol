// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/MintSpikeTrap.sol";

contract MintSpikeTrapTest is Test {
    MintSpikeTrap trap;

    function setUp() public {
        trap = new MintSpikeTrap();
    }

    function testCheckReturnsFalseInitially() public {
        // pass `false` encoded
        bytes memory input = abi.encode(false);
        (bool triggered, bytes memory resp) = trap.check(input);

        assertFalse(triggered, "Trap should not trigger with false input");

        bool decoded = abi.decode(resp, (bool));
        assertFalse(decoded, "Response should also be false");
    }

    function testCheckTriggersAfterMint() public {
        // pass `true` encoded
        bytes memory input = abi.encode(true);
        (bool triggered, bytes memory resp) = trap.check(input);

        assertTrue(triggered, "Trap should trigger with true input");

        bool decoded = abi.decode(resp, (bool));
        assertTrue(decoded, "Response should also be true");
    }
}
