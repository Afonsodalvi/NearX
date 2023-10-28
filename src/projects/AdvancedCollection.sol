// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {ERC4907Rent} from "./ERC4907/ERC4907.sol";


error MintPriceNotPaid();
error MaxSupply();
error NonExistentTokenURI();
error WithdrawTransfer();

/// omnes-tech - afonsod.eth
contract BRfraternity is ERC4907Rent, Pausable, Ownable {

    using Strings for uint256;
    string public generalURI;
    string public baseURI;
    string public collectionCover;
    uint256 public currentTokenId;
    uint256 public TOTAL_SUPPLY;

    //omnes protocol
    uint256 public price;
    uint256 public maxDiscount;

    //acess rules 
    uint256 public monthlyFee;
    uint256 public timeForpay;
    uint256 constant limitRent = 3;
    struct Infopayment{
        uint256 timepay;
        uint256 valuepay;
    }

    mapping(uint256 => Infopayment) public monthlyPayment;
    mapping(address => uint256) limitRentcont;
    mapping(address => bool) lifetimeAcess;
    event MonthlyPayment(uint256 indexed tokenId, address indexed user, uint256 time);
    event Accessdate(address indexed user, uint256 time);
    


    constructor(
        string memory _name,
        string memory _symbol,
        string memory _generalURI,
        string memory _collectionCover,
        uint256 totalsupply
    ) ERC4907Rent(_name, _symbol) {
        generalURI = _generalURI;
        collectionCover = _collectionCover;// set ipfs/CID/collection.json
        TOTAL_SUPPLY = totalsupply;
    }

    function mint() external payable whenNotPaused returns (uint256){
        // `_mint`'s second argument now takes in a `quantity`, not a `tokenId`
        if (msg.value < price - ((price * maxDiscount) / 10000)) {
            revert MintPriceNotPaid();
        }
        uint256 newTokenId = _nextTokenId() + 1;
        require(newTokenId <= TOTAL_SUPPLY, "Max supply reached");
        _safeMint(msg.sender, 1);
        return newTokenId;
    }

    function mintTo(address recipient) public payable whenNotPaused returns (uint256) {
        if (msg.value < price - ((price * maxDiscount) / 10000)) {
            revert MintPriceNotPaid();
        }
        uint256 newTokenId = _nextTokenId() + 1;
        require(newTokenId  <= TOTAL_SUPPLY, "Max supply reached");
        _safeMint(recipient, 1);
        return newTokenId;
    }

    function mintOwner(address _to) external payable onlyOwner returns (uint256){
        uint256 newTokenId = _nextTokenId() + 1;
        require(newTokenId <= TOTAL_SUPPLY, "Max supply reached");
        _safeMint(_to, 1);
        return newTokenId;
    }

    //acess rules

    function acessPlatform(uint tokenId) external returns(bool){
        require(ownerOf(tokenId) == msg.sender || 
        userOf(tokenId) == msg.sender || lifetimeAcess[msg.sender] == true,
        "you do not have access NFTs or your term to use has expired");
        require(block.timestamp <= monthlyPayment[tokenId].timepay + timeForpay 
        && monthlyPayment[tokenId].valuepay > monthlyFee
        || lifetimeAcess[msg.sender] == true, 
        "It is only possible to access the platform by paying the monthly fee our LifetTimeAcess.");
        emit Accessdate(msg.sender,block.timestamp);

        return true;
    }

    function payMonthlyFee(uint tokenId) payable external returns(bool){
        require(_exists(tokenId));
        require(msg.value >= monthlyFee, "monthly fee is not correct");
        monthlyPayment[tokenId] =  Infopayment({
            timepay: block.timestamp,
            valuepay: msg.value
        });
        limitRentcont[msg.sender] = 0;

        emit MonthlyPayment(tokenId,msg.sender,block.timestamp);

        return true;
    }

    function setUser(uint256 tokenId, address user, uint64 expires) public override {
        require(limitRentcont[msg.sender] <= limitRent, "rent limit is 3");
        super.setUser(tokenId, user, expires);
        limitRentcont[msg.sender]++;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        if (ownerOf(tokenId) == address(0)) {
            revert NonExistentTokenURI();
        }
        return
            bytes(baseURI).length > 0
                ? string(abi.encodePacked(baseURI, tokenId.toString()))
                : generalURI;
    }

    function setPrice(uint256 _price) external onlyOwner {
        price = _price;
    }

    function setmonthlyFee(uint256 _monthlyFee) external onlyOwner {
        monthlyFee = _monthlyFee;
    }

    function setLifeTime(address _user, bool _lifetime) external onlyOwner {
        lifetimeAcess[_user] = _lifetime;
    }

    function setMaxdiscont(uint256 _maxDiscont) external onlyOwner {
        maxDiscount = _maxDiscont;
    }

    function setTimeforpay(uint256 _timeforpay) external onlyOwner {
        timeForpay = _timeforpay;
    }

    function setGeneralURI(string memory _generalURI) external onlyOwner {
        generalURI = _generalURI;
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    function setCollectionURI(string memory _collectionCover) external onlyOwner{ ///set ipfs/CID/collection.json
        collectionCover = _collectionCover;
    }

    function withdrawPayments(address payable payee) external onlyOwner {
        uint256 balance = address(this).balance;
        (bool transferTx, ) = payee.call{ value: balance }("");
        if (!transferTx) {
            revert WithdrawTransfer();
        }
    }

     function contractURI() //collection cover
        external
        view
        returns (string memory)
    {
        return string(abi.encodePacked(collectionCover)); 
        //set in the folder of the files the file named as collection
    }


 }