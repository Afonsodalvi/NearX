
pragma solidity ^0.8.4;

import "erc721a/ERC721A.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "openzeppelin-contracts/contracts/security/Pausable.sol";
import "openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";


contract Azuki is ERC721A, Ownable{

    error MintPriceNotPaid();
    error MaxSupply();
    error MaxUser();
    error NonExistentTokenURI();
    error WithdrawTransfer();

    //boolianas para vendas 
        bool publicSale;
        bool preSale;

        //limite de compras por carteira e total supply
        mapping(address => uint256) mintWallet;
        uint256 limitPerWallet;
        uint256 public TOTALSUPPLY;
    constructor(uint256 _TOTALSUPPLY, uint256 _limitPerWallet) ERC721A("Azuki", "AZUKI") {
        TOTALSUPPLY = _TOTALSUPPLY;
        limitPerWallet = _limitPerWallet;
    }

    

    function mintPublic(uint256 quantity) external payable supplyMax(quantity) limitUser(quantity){
         require(publicSale == true, "publicSale close");
         mintWallet[msg.sender]+=quantity;
        // `_mint`'s second argument now takes in a `quantity`, not a `tokenId`.
        _mint(msg.sender, quantity);
    }

     function mintPresale(uint256 quantity) external payable supplyMax(quantity) limitUser(quantity){
        require(preSale == true, "preSale close");
        mintWallet[msg.sender]+=quantity;
        // `_mint`'s second argument now takes in a `quantity`, not a `tokenId`.
        _mint(msg.sender, quantity);
    }

    function publicSaleActive()external onlyOwner{
        publicSale = true;
    }

    function preSaleActive()external onlyOwner{
        preSale = true;
    }


    modifier supplyMax(uint _quantity){
        if(_quantity >= TOTALSUPPLY) revert MaxSupply();
        _; 
    }

    modifier limitUser(uint _quantity){
        if(mintWallet[msg.sender] >= limitPerWallet) revert MaxUser();
        _; 
    }


}
