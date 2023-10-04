// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// contrato base X --filho
contract X {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

// contrato base Y -- filho
contract Y {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

// Existem 2 maneiras de inicializar o contrato pai com parâmetros.

// Passe os parâmetros aqui na lista de herança. contrato pai herda os filhos
contract B is X("Input to X"), Y("Input to Y") {

}

contract C is X, Y {
    //Passe os parâmetros aqui no construtor,
    // semelhante aos modificadores de função.
    constructor(string memory _name, string memory _text) X(_name) Y(_text) {}
}

// Os construtores pais são sempre chamados na ordem de herança
// independentemente da ordem dos contratos pai listados no
// construtor do contrato filho.

// Ordem dos construtores chamados:
//1.X
//2.Y
//3.D
contract D is X, Y {
    constructor() X("X foi chamado") Y("Y foi chamado") {}
}



// Solidity oferece suporte a herança múltipla. Os contratos podem herdar outro contrato usando a palavra-chave "is" como vemos acima.

// A função que será substituída por um contrato filho deve ser declarada como virtual.

// A função que irá substituir uma função pai deve usar a palavra-chave override.

// A ordem da herança é importante.

// Você deve listar os contratos-pai na ordem do “mais básico” ao “mais derivado”.

/* Arvore da heranca
    A
   / \
  F   O
 / \ /
L  J,Z

*/


contract A {// usaremos virtual => 
    function foo() public pure virtual returns (string memory) {
        return "A";
    }
}


contract F is A { //usaremos o ovveride para subistituir o virtual acima
    // Override A.foo()
    function foo() public pure virtual override returns (string memory) {
        return "F";
    }
    //falar do exemplo pratico que usamos no NFT quando usamos Metadado URI.
}

contract O is A {
    // Override A.foo()
    function foo() public pure virtual override returns (string memory) {
        return "O";
    }
}

contract J is F, O { //ordem de esquerda oara a direita ==> retorna o ultimo valor herdado do contrato da sua direita
    // J.foo() returns "0"
    // já que O é o contrato pai mais à direita com a função foo()
    function foo() public pure override(F, O) returns (string memory) {
        return super.foo();
    }
}

contract Z is O, F {
    // Z.foo() returns "F"
    // já que F é o contrato pai mais à direita com a função foo()
    function foo() public pure override(O, F) returns (string memory) {
        return super.foo();
    }
}

// A herança deve ser ordenada de “mais semelhante a base” para “mais derivada”.
// Trocar a ordem de A e F gerará um erro de compilação.
// torque para L is F, A ==> error
contract L is A, F{
    function foo() public pure override(A, F) returns (string memory) {
        return super.foo();
    }
}


