// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {TreeToken} from "../src/TreeToken.sol";

contract DeployTreeToken is Script {
    function run() public returns (TreeToken) {
        vm.startBroadcast();
        TreeToken token = new TreeToken();
        vm.stopBroadcast();
        return token;
    }
} 