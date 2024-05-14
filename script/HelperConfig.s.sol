// SPDX-License-Identifier: MIT
/* solhint-disable compiler-version */
pragma solidity ^0.8.18;

//  ██████╗ ███╗   ███╗███╗   ██╗███████╗███████╗
// ██╔═══██╗████╗ ████║████╗  ██║██╔════╝██╔════╝
// ██║   ██║██╔████╔██║██╔██╗ ██║█████╗  ███████╗
// ██║   ██║██║╚██╔╝██║██║╚██╗██║██╔══╝  ╚════██║
// ╚██████╔╝██║ ╚═╝ ██║██║ ╚████║███████╗███████║
//  ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝

/// -----------------------------------------------------------------------
/// Imports
/// -----------------------------------------------------------------------

import { Script } from "forge-std/Script.sol";

/// -----------------------------------------------------------------------
/// Contract (script)
/// -----------------------------------------------------------------------

/**
 * @title Script for configuration settings.
 * @author Eduardo W. da Cunha (@EWCunha).
 * @dev Useful for testing and deployment.
 */
contract HelperConfig is Script {
    /// -----------------------------------------------------------------------
    /// Type declarations
    /// -----------------------------------------------------------------------

    struct NetworkConfig {
        uint256 key;
    }

    /// -----------------------------------------------------------------------
    /// State variables
    /// -----------------------------------------------------------------------

    NetworkConfig public activeNetworkConfig;

    uint256 public constant ANVIL_KEY = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;

    /// -----------------------------------------------------------------------
    /// Constructor logic
    /// -----------------------------------------------------------------------

    /// @notice Checks chain ID and calls proper function to set configurations.
    constructor() {
        if (
            block.chainid == 1 || // Ethereum - mainnet
            block.chainid == 17_000 || // Holesky - testnet
            block.chainid == 11_155_111 || // Sepolia - testnet
            block.chainid == 137 || // Polygon - mainnet
            block.chainid == 80_001 || // Mumbai - testnet
            block.chainid == 80_002 || // Mumbai - Amoy
            block.chainid == 1287 || // Moonbase - testnet
            block.chainid == 59_140  //linea - testnet
        ) {
            activeNetworkConfig = getPublicConfig();
        } else {
            activeNetworkConfig = getAnvilConfig();
        }
    }

    /// -----------------------------------------------------------------------
    /// View public/external functions
    /// -----------------------------------------------------------------------

    /**
     * @notice Sets configurations for public networks.
     * @return {NetworkConfig} object.
     */
    function getPublicConfig() public view returns (NetworkConfig memory) {
        return NetworkConfig({ key: vm.envUint("PRIVATE_KEY") });
    }

    /**
     * @notice Sets configurations for Anvil network.
     * @return {NetworkConfig} object.
     */
    function getAnvilConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({ key: ANVIL_KEY });
    }
}
