// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract funcoesExemplo {
    //variaveis globais publicas
    uint256 public numero; //armazenando o numero dividido por dois
    string public nome;
    string public mensagem;

    //variaveis nao publicas para acessarmos via funções
    uint256 valor; //repare que não é visivel no seu Remix

    //funções externas são as que só podem ser chamadas por contas EOAS endereços de contas
    function setNomeNum(string memory _meunome, uint256 _numero) external {
        nome = _meunome;
        subNum(_numero);
        setMsg("chamou pelo contrato");
    }

    //funcao interna só pode ser chamada pelo contrato
    function subNum(uint256 _numeroSub) internal {
        uint256 subNumero = _numeroSub / 2;
        numero = subNumero;
    }

    //funcao publica pode ser chamada por conta EOAS ou contrato
    function setMsg(string memory _msg) public {
        mensagem = _msg;
    }

    //funcoes com view, pure e payable

    //vamos setar aqui o valor
    function setValor(uint256 _valor) external {
        valor = _valor;
    }

    //Retorna o valor setado acima o view não modifica o estado do contrato, ou seja, não altera nada nas variáveis
    // de armazenamento
    function getValor() external view returns (uint256) {
        return valor;
    }

    //O pure ela nem le e nem escreve no estado do contrato
    function multiplicar(uint256 x, uint256 y) external pure returns (uint256) {
        uint256 valorMultiplicacao = x * y;
        return valorMultiplicacao;
    }

    //função que permite enviarmos valores para o contrato
    function payEther() external payable { }
}
