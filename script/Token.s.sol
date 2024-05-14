// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.21 <0.9.0;

import { AFOC } from "../src/projects/StableCoin.sol";


import { HelperConfig } from "../../../script/HelperConfig.s.sol";
import {Script, console} from "forge-std/Script.sol";

/// @dev See the Solidity Scripting tutorial: https://book.getfoundry.sh/tutorials/solidity-scripting
contract Deploy is Script {
    HelperConfig public config;

    string utilityName = "AfonsoCoin";
    string utilitySymbol = "AFOC";

    string USDName = "LumxUSD";
    string USDSymbol = "LUSD";

    function run() public returns (AFOC token) {
        config = new HelperConfig();
        (uint256 key) = config.activeNetworkConfig();

         vm.startBroadcast(vm.rememberKey(key));
        token = new AFOC(USDName, USDSymbol); //
    }
}
