// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


contract oracleRealstate {

    address public owner; //dono do contrato oráculo e incorporadora/contrutora
    string public model; //modelo do imóvel
    uint public valueRealEstate; //valor do imóvel
    address public broker; //endereço do corretor 
    uint public immutable commission; //comissão do corretor
    uint public timepay; // a data que é para pagar a compra

    address public RealestateAddr;

    constructor(address _owner, string memory _model,
    uint _valueRealEstate, address _broker, uint _commission, uint _timepay) payable {
        owner = _owner;
        model = _model;
        broker = _broker;
        valueRealEstate = _valueRealEstate;
        timepay = _timepay;
        commission = _commission;

        RealestateAddr = address(this);
    }

    function newTimepay(uint _newtimepay) external onlyOwner{
        timepay = _newtimepay;
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "not owner");
        _;
    }


   
}