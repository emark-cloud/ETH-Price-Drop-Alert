// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import {ITrap} from "drosera-contracts/interfaces/ITrap.sol";

contract MintSpikeTrap is ITrap {
    address public token;
    address public user1;
    address public user2;

    constructor(address _token, address _user1, address _user2) {
        token = _token;
        user1 = _user1;
        user2 = _user2;
    }

    /// @notice Collect trap data
    function collect() external view override returns (bytes memory) {
        return abi.encode(token, user1, user2);
    }

    /// @notice Decide if trap should respond
    function shouldRespond(bytes[] calldata data) external pure override returns (bool, bytes memory) {
        // very basic example: always respond with first item if present
        if (data.length > 0) {
            return (true, data[0]);
        }
        return (false, "");
    }
}
