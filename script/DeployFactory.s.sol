// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/FactoryToken.sol";
import "../src/Factory721.sol";
import "../src/Factory1155.sol";

contract DeployBridgeScript is Script {
    uint256 private deployerPrivateKey;

    function setUp() public {}

    function run() public {
        deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);
        address deployer = vm.addr(deployerPrivateKey);

        FactoryToken factoryToken = new FactoryToken();

        console.logString(
            string.concat(
                "factoryToken deployed at: ",
                vm.toString(address(factoryToken))
            )
        );

        Factory1155 factory1155 = new Factory1155();

        console.logString(
            string.concat(
                "factory1155 deployed at: ",
                vm.toString(address(factory1155))
            )
        );

        Factory721 factory721 = new Factory721();

        console.logString(
            string.concat(
                "factory721 deployed at: ",
                vm.toString(address(factory721))
            )
        );

        vm.stopBroadcast();
    }
}
