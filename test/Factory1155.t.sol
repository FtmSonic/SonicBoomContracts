// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Factory1155.sol";
import "../src/Custom1155.sol";

contract Factory1155Test is Test {
    Factory1155 public factoryToken;

    address deployer = makeAddr("Deployer");
    address alice = makeAddr("Alice");
    address bob = makeAddr("Bob");
    address charlie = makeAddr("Charlie");
    address daniel = makeAddr("Daniel");

    function setUp() public {
        factoryToken = new Factory1155();
    }

    function testCreateNewToken() public {
        vm.startPrank(bob);
        address newToken = factoryToken.create(
            bob,
            alice,
            charlie,
            "http://Sonic"
        );
        assertNotEq(newToken, address(0));
        vm.stopPrank();

        Custom1155 tok = Custom1155(newToken);
        assertEq(tok.uri(1), "http://Sonic");

        assertTrue(tok.hasRole(tok.DEFAULT_ADMIN_ROLE(), bob));
        assertTrue(tok.hasRole(tok.PAUSER_ROLE(), alice));
        assertTrue(tok.hasRole(tok.MINTER_ROLE(), charlie));
    }
}
