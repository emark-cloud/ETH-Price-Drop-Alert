// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ✅ Forge standard testing utilities
import "forge-std/Test.sol";

// ✅ Our contracts
import "../src/MintSpikeTrap.sol";
import "./MintableToken.sol";

contract MintSpikeTrapTest is Test {
    MintableToken token;
    MintSpikeTrap trap;
    MintSpikeResponse response;

    address alice = address(0x123);

    function setUp() public {
        token = new MintableToken();

        // threshold = 1000 tokens
        trap = new MintSpikeTrap(address(token), 1000 ether);
        response = new MintSpikeResponse();
    }

    function testSmallMintDoesNotTrigger() public {
        // encode mint(alice, 100 ether)
        bytes memory data = abi.encodeWithSelector(
            token.mint.selector, alice, 100 ether
        );

        bool triggered = trap.checkTx(address(this), alice, data);
        assertFalse(triggered, "Trap should NOT trigger for small mints");
    }

    function testLargeMintTriggers() public {
        uint256 bigAmount = 2000 ether;

        // encode mint(alice, bigAmount)
        bytes memory data = abi.encodeWithSelector(
            token.mint.selector, alice, bigAmount
        );

        bool triggered = trap.checkTx(address(this), alice, data);
        assertTrue(triggered, "Trap SHOULD trigger for large mints");

        // decode the response data stored by the trap
        bytes memory encoded = trap.getLastResponseData();
        response.decode(encoded);

        assertEq(response.lastEvent().to, alice, "Wrong recipient");
        assertEq(response.lastEvent().amount, bigAmount, "Wrong mint amount");
        assertEq(
            response.lastEvent().newTotalSupply,
            bigAmount,
            "Wrong total supply"
        );
    }
}
