// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "forge-std/Test.sol";
import "../src/MintSpikeTrap.sol";

contract MintSpikeTrapTest is Test {
    MintSpikeTrap trap;
    address token = address(0x123);
    address user1 = address(0x456);
    address user2 = address(0x789);

    function setUp() public {
        trap = new MintSpikeTrap(token, user1, user2);
    }

    function testCollect() public {
        bytes memory data = trap.collect();
        (address _token, address _user1, address _user2) = abi.decode(
            data,
            (address, address, address)
        );

        assertEq(_token, token);
        assertEq(_user1, user1);
        assertEq(_user2, user2);
    }

    function testShouldRespondTrue() public {
        // Correctly declare and initialize the input array
        bytes ;
        input[0] = abi.encodePacked("hello");

        (bool triggered, bytes memory response) = trap.shouldRespond(input);

        assertTrue(triggered, "shouldRespond should trigger on data");
        assertEq(response, input[0], "shouldRespond should return matching data");
    }

    function testShouldRespondFalse() public {
        // Empty input array
        bytes ;

        (bool triggered, bytes memory response) = trap.shouldRespond(input);

        assertFalse(triggered, "shouldRespond should not trigger with no data");
        assertEq(response.length, 0, "Response should be empty");
    }
}
