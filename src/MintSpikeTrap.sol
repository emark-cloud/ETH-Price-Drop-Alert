// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ITrap} from "drosera-contracts/interfaces/ITrap.sol";

/// @title MintSpikeTrap
/// @notice A simple Drosera trap that monitors mint spikes in an ERC20 token
/// @dev Implements the ITrap interface
contract MintSpikeTrap is ITrap {
    /// @notice The ERC20 token being monitored
    address public immutable token;

    /// @notice The threshold amount for detecting a mint spike
    uint256 public immutable mintThreshold;

    /// @param _token The ERC20 token to monitor
    /// @param _mintThreshold The threshold at which a mint spike is flagged
    constructor(address _token, uint256 _mintThreshold) {
        token = _token;
        mintThreshold = _mintThreshold;
    }

    // ---------------------------
    // ITrap interface
    // ---------------------------

    /// @inheritdoc ITrap
    function check(bytes calldata data) external view override returns (bool triggered, bytes memory responseData) {
        // Example logic (to replace with your own):
        // data might include the amount minted (from offchain monitor or hook)
        if (data.length == 32) {
            uint256 mintedAmount = abi.decode(data, (uint256));
            if (mintedAmount >= mintThreshold) {
                return (true, abi.encode(mintedAmount));
            }
        }

        // Default: no trigger
        return (false, bytes(""));
    }

    /// @inheritdoc ITrap
    function name() external pure override returns (string memory) {
        return "MintSpikeTrap";
    }

    /// @inheritdoc ITrap
    function version() external pure override returns (string memory) {
        return "1.0.0";
    }
}
