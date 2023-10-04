// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract FuncoesModifier {
    address public owner; //vamos armazenar o endereco do dono
    uint public x = 10; //o valor armazenado na variavel para usarmos no decrement e evitar o ataque de rentrada
    bool public locked;//booliana que trava o ataque

    constructor() {
        owner = msg.sender;//quem deploya é o dono
    }

    // Modificador para verificar se o chamador é o proprietário do
     // o contrato.
    modifier onlyOwner() { //na prática vamos ver muito o uso desse modifier
        require(msg.sender == owner, "Not owner");
        // Underscore é um caractere especial usado apenas dentro
         // um modificador de função e diz ao Solidity para
         //executa o resto do código.
        _;
    }

    // Modifier que checa se o endereço passado não é zero
    modifier validAddress(address _addr) {
        require(_addr != address(0), "Not valid address");
        _;
    }

//função de mudar o endereço do dono onde implementamos os dois modifiers acima
    function changeOwner(address _newOwner) public onlyOwner validAddress(_newOwner) {
        owner = _newOwner;
    }

    // Modificadores podem ser chamados antes e/ou depois de uma função.
     // Este modificador impede que uma função seja chamada enquanto
     // ainda está em execução.
    modifier noReentrancy() {
        require(!locked, "No reentrancy");

        locked = true;
        _;
        locked = false;
    }

    function decrement(uint i) public noReentrancy {
        x -= i; //pega o valor de atual de x e subtrai o valor de i

        if (i > 1) { //se o valor de é maior que 1 continua e executa novamente a mesma função
            decrement(i - 1); //so que aqui atualiza
        }
    }
}
