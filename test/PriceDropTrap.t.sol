pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/PriceDropTrap.sol";

contract PriceDropTrapTest is Test {
    PriceDropTrap trap;

    function setUp() public {
        trap = new PriceDropTrap();
        // Set an initial lastPrice so drop detection works
        trap.setLastPrice(2000 * 1e8); // Example: $2000
    }

    function testShouldRespondOnPriceDrop() public {
        // Encode the new price into bytes
        int256 newPrice = 1900 * 1e8; // Example: $1900, drop of $100
        bytes memory collected = abi.encode(newPrice);

        // Create bytes[] array with one element
        bytes ;
        arr[0] = collected;

        // Call shouldRespond
        (bool should, bytes memory resp) = trap.shouldRespond(arr);

        assertTrue(should, "Should trigger on $100 drop");
        assertEq(abi.decode(resp, (int256)), newPrice);
    }

    function testShouldNotRespondOnSmallDrop() public {
        // Encode the new price into bytes
        int256 newPrice = 1980 * 1e8; // Example: $1980, drop of $20
        bytes memory collected = abi.encode(newPrice);

        // Create bytes[] array with one element
        bytes ;
        arr[0] = collected;

        // Call shouldRespond
        (bool should, ) = trap.shouldRespond(arr);

        assertFalse(should, "Should not trigger on small drop");
    }
}
