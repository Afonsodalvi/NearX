// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./exerc/oracleRealstate.sol";
import "./exerc/interfaceReal.sol";
import "../aula4/1LibraryMath.sol";

contract RealStateCorporate is interfaceReal{ //se eu implemento o contrato que tem constructor eu tenho que implementar ele
   
    using Math for uint256; //vamos usar a library para fazer alguns calculos da regra do negócio

     oracleRealstate[] public oraclesRealstates; //criamos oraculos de imobiliarias
     mapping(address => bool)approved;

    //  constructor(address _owner, string memory _model,
    // uint _valueRealEstate, address _broker, uint _commission, uint _timepay) 
    // oracleRealstate(_owner, _model,_valueRealEstate, _broker, _commission, _timepay){
    //     oracleRealstate realstate = new oracleRealstate(_owner, _model,_valueRealEstate, _broker, _commission, _timepay);
    //     oraclesRealstates.push(realstate); //zero addr

    //  }

    function createNewOracle( address _owner, string memory _model,
    uint _valueRealEstate, address _broker, uint _commission, uint _timepay)external {
        oracleRealstate realstate = new oracleRealstate(_owner, _model,_valueRealEstate, _broker, _commission, _timepay);
       oraclesRealstates.push(realstate);
       //emit realstateAddr(realstate);

    }

     function getReal( //pegar todas as informações  do contrato Oracle Real state pelo indice da array
        uint _index
     )public
        view
        returns (address owner, string memory model, uint valueRealEstate, 
        address broker, uint commission, address RealestateAddr, uint balance)
    {
        oracleRealstate realstate = oraclesRealstates[_index];

        return (realstate.owner(), realstate.model(), realstate.valueRealEstate(), 
        realstate.broker(), realstate.commission(), realstate.RealestateAddr(), address(realstate).balance);
        //vamos retornar o saldo que esta no contrato
    }

    function getTime(uint _index)public view returns(uint256){
        oracleRealstate realstate = oraclesRealstates[_index];
        return realstate.timepay();
    }


    function payTransfer(
        address user, //cliente que vai ser pago
        uint _index)external payable{
            oracleRealstate realstate = oraclesRealstates[_index];
            require(msg.value == realstate.valueRealEstate() 
            && approved[msg.sender] 
            && approved[user], "value is not correct or client not approved"); //tem que ser tudo verdadeiro
            //somente cliente aprovado e tem que ser o valor acordado no contrato criado

            //regra de negocio para pagamento de comissao
            if(getTime(_index) <= block.timestamp){
                address brokerAddr = realstate.broker();
                uint commission = msg.value*realstate.commission()/100; //calcular o percentual ----
                uint commissionDoble = commission*2; //se ele vender no tempo menor que o estipulado ele ganha o dobro de comissao
                uint payment = msg.value - commissionDoble;
                payable(user).transfer(payment);
                payable(brokerAddr).transfer(commissionDoble);
            } else {
                address brokerAddr = realstate.broker();
                uint commission = msg.value*realstate.commission()/100;
                uint payment = msg.value - commission;
                payable(user).transfer(payment);
                payable(brokerAddr).transfer(commission);
            }
            emit paySucess(msg.value, block.timestamp);

        }


    function approveClient(
        uint _index,address client, bool approve
    )external {
        oracleRealstate realstate = oraclesRealstates[_index];
        require(msg.sender == realstate.broker(), "only broker approve");
        approved[client]=approve;
    }

}


 