// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.21 <0.9.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import { console2 } from "forge-std/console2.sol";
import "../src/projects/Collection.sol";
import "openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol";

contract CollectionTest is Test {
    Collection public nft;
    uint256 totalsupply = 10_000;
    uint256 totalperwallet = 1;

    //address owner = makeAddr("owner");
    address owner;
    uint256 ownerPrivateKey;
    address user;
    uint256 userPrivateKey;

    function setUp() public {
        (owner, ownerPrivateKey) = makeAddrAndKey("owner");
        (user, userPrivateKey) = makeAddrAndKey("user");

        vm.startPrank(owner);
        nft = new Collection(100, 1, 10, 1 ether, "base");
        vm.stopPrank();
    }

    function testMintandPublicSale() public {
        vm.prank(owner);
        nft.publicSaleActive();

        vm.prank(owner);
        vm.deal(owner, 5 ether); //colocando ether na carteira
        nft.mintPublic{ value: 2 ether }(2); //vc pode mintar so uma vez mas a quantidade que quiser
    }

    function testMaxMint() public {
        vm.prank(owner);
        nft.preSaleActive();

        vm.prank(user);
        vm.deal(user, 5 ether);
        nft.mintPresale{ value: 1 ether }(1);

        vm.prank(user);
        vm.expectRevert(); //esperamos que reverta
        nft.mintPresale{ value: 1 ether }(1); //ele nao consegue mais
    }

    function testLimtMint() public {
        vm.prank(owner);
        nft.preSaleActive();

        vm.prank(user);
        vm.expectRevert(); //espermaos que reverta
        nft.mintPresale(11); //erro MaxUser
    }
}
