// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { ITrap } from "drosera-contracts/interfaces/ITrap.sol";

contract ERC20TransferSpikeTrap is ITrap {
    address public constant trackedToken = 0xF38eED066703d093B20Be0A9D9fcC8684F64cdc4;
    uint256 public constant TRANSFER_THRESHOLD = 1000 * 1e18;

    function collect() external view override returns (bytes memory) {
        uint256 mockTransferVolume = block.timestamp % 2 == 0 ? 500 * 1e18 : 3000 * 1e18;
        return abi.encode(trackedToken, mockTransferVolume);
    }

    function shouldRespond(bytes[] calldata data) external pure override returns (bool, bytes memory) {
        if (data.length < 2) return (false, "");

        (address token0, uint256 volume0) = abi.decode(data[0], (address, uint256));
        (, uint256 volume1) = abi.decode(data[1], (address, uint256));

        uint256 delta = volume1 > volume0 ? volume1 - volume0 : volume0 - volume1;

        if (delta > TRANSFER_THRESHOLD) {
            return (true, abi.encode(token0, volume0, volume1));
        }

        return (false, "");
    }
}
