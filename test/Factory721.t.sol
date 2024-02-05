// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Factory721.sol";
import "../src/Custom721.sol";

contract Factory721Test is Test {
    Factory721 public factoryToken;

    address deployer = makeAddr("Deployer");
    address alice = makeAddr("Alice");
    address bob = makeAddr("Bob");
    address charlie = makeAddr("Charlie");
    address daniel = makeAddr("Daniel");

    function setUp() public {
        factoryToken = new Factory721();
    }

    function testCreateNewToken() public {
        vm.startPrank(bob);
        address newToken = factoryToken.create(
            bob,
            alice,
            charlie,
            "SonicNFT",
            "SNFT",
            "1"
        );
        assertNotEq(newToken, address(0));
        vm.stopPrank();

        Custom721 tok = Custom721(newToken);
        assertEq(tok.name(), "SonicNFT");
        assertEq(tok.symbol(), "SNFT");

        assertTrue(tok.hasRole(tok.DEFAULT_ADMIN_ROLE(), bob));
        assertTrue(tok.hasRole(tok.PAUSER_ROLE(), alice));
        assertTrue(tok.hasRole(tok.MINTER_ROLE(), charlie));
    }
}
