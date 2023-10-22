// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.21 <0.9.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import { console2 } from "forge-std/console2.sol";
import { NftStaker } from "../src/projects/Staking.sol";
import "./Mock/MockERC1155.sol";
import "openzeppelin-contracts/contracts/token/ERC1155/IERC1155Receiver.sol";

contract StakingTest is Test {
    NftStaker public nftstaking;
    MockERC1155 public nft;

    //address owner = makeAddr("owner");
    address owner;
    uint256 ownerPrivateKey;
    address user;
    uint256 userPrivateKey;

    function setUp() public {
        (owner, ownerPrivateKey) = makeAddrAndKey("owner");
        (user, userPrivateKey) = makeAddrAndKey("user");

        vm.startPrank(owner);
        nft = new MockERC1155(); //comece pela collection
        nftstaking = new NftStaker(address(nft));
        vm.stopPrank();
    }

    function testStaking() public {
        //Receiver receiver = new Receiver();
        vm.prank(owner);
        nft.mint(user, 1, 100);

        vm.prank(user);
        nft.balanceOf(user, 1);

        vm.prank(user); //o usu[ario tem que aprovar o contrato de staking pegar os ativos dele]
        nft.setApprovalForAll(address(nftstaking), true);

        vm.warp(block.timestamp);
        emit log_uint(block.timestamp);
        vm.prank(user);
        nftstaking.stake(1, 10);

        vm.prank(user);
        uint256 balanceUpdate = nft.balanceOf(user, 1);
        emit log_uint(balanceUpdate);

        //unstake
        vm.prank(user);
        nftstaking.unstake();

        vm.prank(user);
        uint256 balanceUpdate2 = nft.balanceOf(user, 1);
        emit log_uint(balanceUpdate2);
    }
}
