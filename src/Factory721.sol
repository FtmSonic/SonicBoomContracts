// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Custom721.sol";

contract Factory721 {
    event Deployed(address indexed deployer, address indexed newToken);

    constructor() {}

    function create(
        address defaultAdmin,
        address pauser,
        address minter,
        string calldata name,
        string calldata symbol,
        string memory version
    ) external returns (address) {
        address newToken = address(
            new Custom721(
                defaultAdmin,
                pauser,
                minter,
                name,
                symbol,
                version
            )
        );
        emit Deployed(msg.sender, newToken);
        return newToken;
    }
}
