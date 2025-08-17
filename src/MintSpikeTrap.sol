// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {DroseraTrap} from "drosera-contracts/trap/DroseraTrap.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IMintableToken is IERC20 {
    function mint(address to, uint256 amount) external;
    function totalSupply() external view returns (uint256);
}

contract MintSpikeTrap is DroseraTrap {
    IMintableToken public token;
    uint256 public mintThreshold;

    constructor(address _token, uint256 _mintThreshold) {
        token = IMintableToken(_token);
        mintThreshold = _mintThreshold;
    }

    /// @notice Drosera runtime calls this per tx
    function checkTx(
        address,
        address to,
        bytes calldata data
    ) external override returns (bool) {
        bytes4 selector = bytes4(data[:4]);

        if (selector == token.mint.selector) {
            (, uint256 amount) = abi.decode(data[4:], (address, uint256));

            if (amount > mintThreshold) {
                recordResponseData(
                    abi.encode(to, amount, token.totalSupply() + amount)
                );
                return true;
            }
        }
        return false;
    }
}
