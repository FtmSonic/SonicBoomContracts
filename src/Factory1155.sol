// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Custom1155.sol";

contract Factory1155 {
    event Deployed(address indexed deployer, address indexed newToken);

    constructor() {}

    function create(
        address defaultAdmin,
        address pauser,
        address minter,
        string calldata uri
    ) external returns (address) {
        address newToken = address(
            new Custom1155(defaultAdmin, pauser, minter, uri)
        );
        emit Deployed(msg.sender, newToken);
        return newToken;
    }
}
