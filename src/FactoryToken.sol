// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./CustomToken.sol";

contract FactoryToken {
    event Deployed(address indexed deployer, address indexed newToken);

    constructor() {}

    function create(
        address defaultAdmin,
        address pauser,
        address minter,
        string calldata name,
        string calldata symbol,
        uint8 decimals
    ) external returns (address) {
        address newToken = address(
            new CustomToken(
                defaultAdmin,
                pauser,
                minter,
                name,
                symbol,
                decimals
            )
        );
        emit Deployed(msg.sender, newToken);
        return newToken;
    }
}
