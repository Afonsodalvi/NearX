// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.21 <0.9.0;

import { AFOC } from "../src/projects/StableCoin.sol";

import { BaseScript } from "./Base.s.sol";

/// @dev See the Solidity Scripting tutorial: https://book.getfoundry.sh/tutorials/solidity-scripting
contract Deploy is BaseScript {
    string utilityName = "AfonsoCoin";
    string utilitySymbol = "AFOC";

    string USDName = "LumxUSD";
    string USDSymbol = "LUSD";

    function run() public broadcast returns (AFOC token) {
        token = new AFOC(USDName, USDSymbol); //
    }
}
