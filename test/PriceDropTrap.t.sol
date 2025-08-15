// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/PriceDropTrap.sol";

contract PriceDropTrapTest is Test {
    PriceDropTrap trap;

    // Set up runs before each test
    function setUp() public {
        // Deploy the trap with example constructor args
        trap = new PriceDropTrap(
            /* chainlinkFeed= */ 0x0000000000000000000000000000000000000000, 
            /* dropThreshold= */ 5e16 // 5% drop threshold
        );
    }

    function testCollectAndShouldRespondTrue() public {
        // Simulate collecting trap data
        bytes memory collected = trap.collect();

        // Pack it into a bytes[] array
        bytes ;
        arr[0] = collected;

        // Call shouldRespond with the collected data
        (bool should, bytes memory resp) = trap.shouldRespond(arr);

        // Example expectations (adjust to match your trap logic)
        assertTrue(should, "Trap should trigger");
        assertGt(resp.length, 0, "Response should not be empty");
    }

    function testCollectAndShouldRespondFalse() public {
        // Manipulate state so trap shouldn't trigger
        // (Adjust this to your trap logic, e.g., no price drop)
        vm.warp(block.timestamp + 1 days); 

        bytes memory collected = trap.collect();

        bytes ;
        arr[0] = collected;

        (bool should, ) = trap.shouldRespond(arr);
        assertFalse(should, "Trap should not trigger");
    }
}

