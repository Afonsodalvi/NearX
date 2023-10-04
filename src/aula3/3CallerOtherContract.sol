// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//formas de se chamar outros contratos e modificar variaveis e enviar valores

contract Callee {
    uint public x;
    uint public value;

//setar valor de x na variavel global
    function setX(uint _x) public returns (uint) {
        x = _x;
        return x;
    }

//enviar valor de x e enviar Ether
    function setXandSendEther(uint _x) public payable returns (uint, uint) {
        x = _x;
        value = msg.value;

        return (x, value);
    }
}


//novo contrato que vamos chamar as funcoes do outro contrato e setar informacoes
contract CallerFunctions {
    function setX(Callee _callee, uint _x) public {
        uint x = _callee.setX(_x);
    }

    function setXFromAddress(address _addr, uint _x) public {
        Callee callee = Callee(_addr);
        callee.setX(_x);
    }

    function setXandSendEther(Callee _callee, uint _x) public payable {
        (uint x, uint value) = _callee.setXandSendEther{value: msg.value}(_x);
    }
}
