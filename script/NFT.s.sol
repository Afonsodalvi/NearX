// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.21 <0.9.0;

import { Collection } from "../src/projects/Collection.sol";

import { HelperConfig } from "../../../script/HelperConfig.s.sol";
import {Script, console} from "forge-std/Script.sol";

/// @dev See the Solidity Scripting tutorial: https://book.getfoundry.sh/tutorials/solidity-scripting
contract Deploy is Script {
    HelperConfig public config;

    uint256 _TOTALSUPPLY = 100_000;
    uint256 _limitPerWallet = 10;
    uint256 _limitQuantity = 100;
    uint256 _MINT_PRICE = 1 ether;
    string _baseURI = "URL";

    function run() public returns (Collection token) {
        config = new HelperConfig();
        (uint256 key) = config.activeNetworkConfig();

         vm.startBroadcast(vm.rememberKey(key));
        
        token = new Collection(_TOTALSUPPLY, _limitPerWallet,
        _limitQuantity,
        _MINT_PRICE,
        _baseURI); // PARAMETROS DO CONTRUCTOR
        console.log("Meu NFT:", address(token));
    }
}
