// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


interface interfaceReal{
    
    function getTime(uint _index)external returns(uint256); //pegar o tempo para calcular 

    function payTransfer(
        address user,
        uint _index)external payable; //pagamento da transferencia

    function approveClient(
        uint _index,address client, bool approve
    )external;//retorna se o endereço ta na blacklist

    function getReal( //pegar todas as informações  do contrato Oracle Real state pelo indice da array
        uint _index
     )external
        view
        returns (address owner, string memory model, uint valueRealEstate, 
        address broker, uint commission, address RealestateAddr, uint balance);

    event realstateAddr(address _idAddress);
    event paySucess(uint _value, uint time);
}