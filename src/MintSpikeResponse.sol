// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ✅ Corrected import path for DroseraResponse
import {DroseraResponse} from "drosera-contracts/runtime/DroseraResponse.sol";

contract MintSpikeResponse is DroseraResponse {
    struct MintEvent {
        address to;
        uint256 amount;
        uint256 newTotalSupply;
    }

    MintEvent public lastEvent;

    function decode(bytes calldata data) external override {
        (address to, uint256 amount, uint256 newTotalSupply) =
            abi.decode(data, (address, uint256, uint256));

        lastEvent = MintEvent(to, amount, newTotalSupply);
    }
}
