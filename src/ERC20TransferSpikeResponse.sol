// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ERC20TransferSpikeResponse {
    event TransferVolumeSpiked(
        address indexed token,
        uint256 previousVolume,
        uint256 currentVolume
    );

    function respondWithERC20VolumeContext(
        address token,
        uint256 previousVolume,
        uint256 currentVolume
    ) external {
        emit TransferVolumeSpiked(token, previousVolume, currentVolume);
    }
}
