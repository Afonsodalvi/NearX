// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Base contract X
contract X {
    string public name;
    uint256 immutable idade; //aqui declaramos essa variável como imutável depois de setada
    // temos duas variáveis que não podem ser modificadas em solidity, a immutável que pode ser setada no contructor
    //e temos a constant que já é definida globalmente e nunca mais pode ser alterada.
    address constant owner = 0xAaa7cCF1627aFDeddcDc2093f078C3F173C46cA4;

    constructor(string memory _name, uint256 _idade) {
        //no contrutor, já construmios o contrato declarando as variáveis.
        name = _name;
        idade = _idade;
    }

    function setNome(string memory _newName) external {
        require(msg.sender == owner, "Somente o dono pode alterar o nome");
        name = _newName;
    }
}
