// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.21 <0.9.0;

import "forge-std/Test.sol";
import "../src/projects/gastest/OpenZeppelinNft.sol";
import "openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol";

contract OpenZeppelinNftTests is Test {
    using stdStorage for StdStorage;

    OpenZeppelinNft private nft;

    address owner;
    uint256 ownerPrivateKey;
    address user;
    uint256 userPrivateKey;

    function setUp() public {
        (owner, ownerPrivateKey) = makeAddrAndKey("owner");
        (user, userPrivateKey) = makeAddrAndKey("user");

        // Deploy NFT contract
        vm.prank(owner);
        nft = new OpenZeppelinNft("baseUri");
    }

    function testreserveNFT() public {
        vm.prank(owner);
        nft.reserveNFTs();
    }

    function testMintPricePaid() public {
        vm.prank(user);
        vm.deal(user, 5 ether); //colocando ether na carteira
        nft.mintTo{ value: 0.01 ether }(user);
        vm.prank(user);
        nft.balanceOf(user);

        vm.deal(user, 5 ether); //colocando ether na carteira
        nft.mintTo{ value: 0.01 ether }(user);
        vm.prank(user);
        nft.balanceOf(user);
    }

    function testMintAmount() public {
        vm.prank(user);
        vm.deal(user, 5 ether); //colocando ether na carteira
        nft.mintNFTs{ value: 0.16 ether }(2);

        vm.prank(user);
        nft.balanceOf(user);
    }

    // function testFailMaxSupplyReached() public {
    //     uint256 slot = stdstore.target(address(nft)).sig("currentTokenId()").find();
    //     bytes32 loc = bytes32(slot);
    //     bytes32 mockedCurrentTokenId = bytes32(abi.encode(10000));
    //     vm.store(address(nft), loc, mockedCurrentTokenId);
    //     nft.mintTo{value: 0.08 ether}(owner);
    // }

    function testFailMintToZeroAddress() public {
        nft.mintTo{ value: 0.08 ether }(address(0));
    }
}
