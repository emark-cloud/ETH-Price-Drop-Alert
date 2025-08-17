// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/token/ERC20/ERC20.sol";

contract MintableToken is ERC20 {
    constructor() ERC20("Mintable", "MINT") {}

    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }
}
