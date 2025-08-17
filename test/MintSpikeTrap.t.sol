// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/MintSpikeTrap.sol";
import "../src/MintSpikeResponse.sol";
import "./MintableToken.sol";

contract MintSpikeTrapTest is Test {
    MintableToken token;
    MintSpikeTrap trap;
    MintSpikeResponse response;

    address alice = address(0x123);

    function setUp() public {
        token = new MintableToken();
        trap = new MintSpikeTrap(address(token), 1000 ether);
        response = new MintSpikeResponse();
    }

    function testSmallMintDoesNotTrigger() public {
        bytes memory data = abi.encodeWithSelector(
            token.mint.selector, alice, 100 ether
        );

        bool triggered = trap.checkTx(address(this), alice, data);
        assertFalse(triggered, "Trap should not trigger for small mints");
    }

    function testLargeMintTriggers() public {
        uint256 bigAmount = 2000 ether;

        bytes memory data = abi.encodeWithSelector(
            token.mint.selector, alice, bigAmount
        );

        bool triggered = trap.checkTx(address(this), alice, data);
        assertTrue(triggered, "Trap should trigger for large mints");

        // Decode response
        bytes memory encoded = trap.getLastResponseData();
        response.decode(encoded);

        assertEq(response.lastEvent().to, alice);
        assertEq(response.lastEvent().amount, bigAmount);
        assertEq(response.lastEvent().newTotalSupply, bigAmount);
    }
}
