// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ITrap} from "drosera-contracts/interfaces/ITrap.sol";

contract MintSpikeTrap is ITrap {
    // Store whether a spike has been detected
    bool private spikeTriggered;

    constructor() {
        spikeTriggered = false;
    }

    /// @notice Called by Drosera to check conditions
    function check(bytes calldata data)
        external
        view
        override
        returns (bool triggered, bytes memory responseData)
    {
        // For now, just decode a bool from `data`
        bool condition = abi.decode(data, (bool));
        return (condition, abi.encode(condition));
    }

    /// @notice Return any data collected by the trap
    function collect() external view override returns (bytes memory) {
        return abi.encode(spikeTriggered);
    }

    /// @notice Decide whether to respond based on an array of data
    function shouldRespond(bytes[] calldata data)
        external
        pure
        override
        returns (bool, bytes memory)
    {
        // Simple logic: respond if any data entry decodes to true
        for (uint i = 0; i < data.length; i++) {
            bool condition = abi.decode(data[i], (bool));
            if (condition) {
                return (true, abi.encode(condition));
            }
        }
        return (false, abi.encode(false));
    }

    function name() external pure override returns (string memory) {
        return "MintSpikeTrap";
    }

    function version() external pure override returns (string memory) {
        return "1.0.0";
    }
}
