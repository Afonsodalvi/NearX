// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract DadosemBytes {
    string private meusDados;
    address public EnderecoDonoDados;
    bool public DadosTrueFalse;
    uint256 public QuantidadeUsuarios;

    function setDadosString(string memory _dados) public returns (bytes memory) {
        EnderecoDonoDados = msg.sender;
        meusDados = _dados;
        DadosTrueFalse = true;
        QuantidadeUsuarios++;
        bytes memory meusDadosBytes = bytes(_dados);
        return meusDadosBytes;
    }
    //pq ensinando isso? armazenar ums string em solidity economiza gas e assim temos menos custos

    function converterBytesParaString(bytes memory _meusDadosemBytes)
        public
        returns (string memory)
    {
        DadosTrueFalse = false;
        return string(_meusDadosemBytes);
    }

    
}