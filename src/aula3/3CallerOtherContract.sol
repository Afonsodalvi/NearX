// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//formas de se chamar outros contratos e modificar variaveis e enviar valores

contract Callee {
    uint256 public x;
    uint256 public value;

    //setar valor de x na variavel global
    function setX(uint256 _x) public returns (uint256) {
        x = _x;
        return x;
    }

    //enviar valor de x e enviar Ether
    function setXandSendEther(uint256 _x) public payable returns (uint256, uint256) {
        x = _x;
        value = msg.value;

        return (x, value);
    }
}

//novo contrato que vamos chamar as funcoes do outro contrato e setar informacoes
contract CallerFunctions {
    function setX(Callee _callee, uint256 _x) public {
        uint256 x = _callee.setX(_x);
    }

    function setXFromAddress(address _addr, uint256 _x) public {
        Callee callee = Callee(_addr);
        callee.setX(_x);
    }

    function setXandSendEther(Callee _callee, uint256 _x) public payable {
        (uint256 x, uint256 value) = _callee.setXandSendEther{ value: msg.value }(_x);
    }
}
