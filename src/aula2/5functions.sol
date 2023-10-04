// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


contract funcoesExemplo{
    //variaveis globais publicas
    uint public numero; //armazenando o numero dividido por dois
    string public nome;
    string public mensagem;

    //variaveis nao publicas para acessarmos via funções
    uint valor; //repare que não é visivel no seu Remix

//funções externas são as que só podem ser chamadas por contas EOAS endereços de contas
    function setNomeNum(string memory _meunome, uint _numero)external {
        nome = _meunome;
        subNum(_numero);
        setMsg("chamou pelo contrato");
    }

//funcao interna só pode ser chamada pelo contrato
    function subNum(uint _numeroSub)internal{ 
    uint subNumero = _numeroSub / 2;
    numero = subNumero;
    }

//funcao publica pode ser chamada por conta EOAS ou contrato
    function setMsg(string memory _msg)public {
        mensagem = _msg;
    }

//funcoes com view, pure e payable

//vamos setar aqui o valor
    function setValor(uint _valor)external{
        valor = _valor;
    }

//Retorna o valor setado acima o view não modifica o estado do contrato, ou seja, não altera nada nas variáveis de armazenamento
    function getValor()external view returns(uint){
        return valor;
    }

//O pure ela nem le e nem escreve no estado do contrato
function multiplicar(uint x, uint y) external pure returns(uint){
uint valorMultiplicacao = x * y;
return valorMultiplicacao;
}

//função que permite enviarmos valores para o contrato
function payEther()payable external{
}

}