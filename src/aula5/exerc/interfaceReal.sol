// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface interfaceReal {
    function getTime(uint256 _index) external returns (uint256); //pegar o tempo para calcular

    function payTransfer(address user, uint256 _index) external payable; //pagamento da transferencia

    function approveClient(uint256 _index, address client, bool approve) external; //retorna se o endereço ta na
        // blacklist

    function getReal( //pegar todas as informações  do contrato Oracle Real state pelo indice da array
    uint256 _index)
        external
        view
        returns (
            address owner,
            string memory model,
            uint256 valueRealEstate,
            address broker,
            uint256 commission,
            address RealestateAddr,
            uint256 balance
        );

    event realstateAddr(address _idAddress);
    event paySucess(uint256 _value, uint256 time);
}
