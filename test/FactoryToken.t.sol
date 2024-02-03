// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/FactoryToken.sol";
import "../src/CustomToken.sol";

contract FactoryTokenTest is Test {
    FactoryToken public factoryToken;

    address deployer = makeAddr("Deployer");
    address alice = makeAddr("Alice");
    address bob = makeAddr("Bob");
    address charlie = makeAddr("Charlie");
    address daniel = makeAddr("Daniel");

    function setUp() public {
        factoryToken = new FactoryToken();
    }

    function testCreateNewToken() public {
        vm.startPrank(bob);
        address newToken = factoryToken.create(
            bob,
            alice,
            charlie,
            "Sonic",
            "S",
            6
        );
        assertNotEq(newToken, address(0));
        vm.stopPrank();

        CustomToken tok = CustomToken(newToken);
        assertEq(tok.decimals(), 6);
        assertEq(tok.name(), "Sonic");
        assertEq(tok.symbol(), "S");

        assertTrue(tok.hasRole(tok.DEFAULT_ADMIN_ROLE(), bob));
        assertTrue(tok.hasRole(tok.PAUSER_ROLE(), alice));
        assertTrue(tok.hasRole(tok.MINTER_ROLE(), charlie));
    }
}
