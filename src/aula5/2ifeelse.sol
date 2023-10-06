// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ifElse {
    uint256 idadeDezoito = 18;
    mapping(address => bool) public approved;

    function login(uint256 _idade) external returns (bool notLegaAge) {
        if (_idade < idadeDezoito) {
            revert("menor de dezoito");
        } else {
            approved[msg.sender] = true; //salva como aprovado
            return notLegaAge; //retorna verdadeiro ou falso
                //falso se ele e maior de idade e passa a funcao
        }
    }

    function loginTernario(uint256 _idade) external view returns (bool notLegalAge) {
        //maneira abreviada de escrever a instrução if/else
        // o "?" operador é chamado de operador ternário
        return _idade < idadeDezoito ? true : false;
    }
}
