// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "erc721a/contracts/ERC721A.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "openzeppelin-contracts/contracts/security/Pausable.sol";
import "openzeppelin-contracts/contracts/utils/Strings.sol";
import "openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";

contract Collection is
    ERC721A,
    Ownable //na versao nova Ownable(msg.sender)
{
    using Strings for uint256;

    error MintPriceNotPaid();
    error MaxSupply();
    error MaxUser();
    error NonExistentTokenURI();
    error WithdrawTransfer();

    //boolianas para vendas
    bool publicSale;
    bool preSale;

    //limite de compras por carteira e total supply e whitelist
    mapping(address => uint256) mintWallet;
    mapping(address => bool) public whitelist;

    uint256 limitPerWallet; //limite de transacao por wallet
    uint256 limitQuantity; //limite de quantidade de NFTs por wallet

    uint256 public TOTALSUPPLY;
    uint256 immutable MINT_PRICE;

    string public baseURI;
    string public collectionCover = "https://ipfs.io/ipfs/bafkreiespnaevk72m7j2xugzyjvzbhaosttlb2dwmfawkb6pfyrjnmlafm/";

    constructor(
        uint256 _TOTALSUPPLY,
        uint256 _limitPerWallet,
        uint256 _limitQuantity,
        uint256 _MINT_PRICE,
        string memory _baseURI
    )
        ERC721A("Azuki", "AZUKI")
    {
        TOTALSUPPLY = _TOTALSUPPLY;
        limitPerWallet = _limitPerWallet; //limite de executar a funcao mint por wallet
        limitQuantity = _limitQuantity;
        MINT_PRICE = _MINT_PRICE;
        baseURI = _baseURI;
        whitelist[msg.sender] = true; //inserindo o endereco de deploy na whitelist
    }

    function mintPublic(uint256 quantity) external payable supplyMax(quantity) limitUser(quantity) {
        require(publicSale == true, "publicSale close");
        require(msg.value == MINT_PRICE * quantity, "mint price not correct");
        mintWallet[msg.sender] += quantity; //vai somar com o que ele ja tem
        // `_mint`'s second argument now takes in a `quantity`, not a `tokenId`.
        _mint(msg.sender, quantity);
    }

    function mintPresale(uint256 quantity) external payable supplyMax(quantity) limitUser(quantity) {
        whitelistFunc();
        require(preSale == true, "preSale close");
        require(msg.value == MINT_PRICE * quantity, "mint price not correct");
        mintWallet[msg.sender] += quantity;
        // `_mint`'s second argument now takes in a `quantity`, not a `tokenId`.
        _mint(msg.sender, quantity);
    }

    function contractURI() //collection cover -- desse jeito o Opensea Reconhece a capa da coleção
        external
        view
        returns (string memory)
    {
        return string(abi.encodePacked(collectionCover)); 
        //set in the folder of the files the file named as collection
    }


    function addToWhitelist(address toAddAddresses) external onlyOwner {
        whitelist[toAddAddresses] = true;
    }

    /**
     * @notice Remove from whitelist
     */
    function removeFromWhitelist(address toRemoveAddresses) external onlyOwner {
        whitelist[toRemoveAddresses] = false;
    }

    function publicSaleActive() external onlyOwner {
        publicSale = true;
    }

    function preSaleActive() external onlyOwner {
        preSale = true;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(ownerOf(tokenId) != address(0), "ERC721Metadata: URI query for nonexistent token");
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString())) : "";
    }

    function withdraw() public payable onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No ether left to withdraw");
        (bool success,) = (msg.sender).call{ value: balance }("");
        require(success, "Transfer failed.");
    }

    //podemos usar uma funcao fazendo o mesmo papel de um modifier, por exemplo:

    function whitelistFunc() internal view {
        require(whitelist[msg.sender], "NOT_IN_WHITELIST");

        // Do some useful stuff
    }

    modifier supplyMax(uint256 _quantity) {
        if (_quantity >= TOTALSUPPLY) revert MaxSupply();
        _;
    }

    modifier limitUser(uint256 _quantity) {
        if (mintWallet[msg.sender] >= limitPerWallet) revert MaxUser();
        if (_quantity >= limitQuantity) revert MaxUser();
        _;
    }
}
