// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

//reparem que tudo que vamos fazer agora é atribuir uma variável que indica a outra, como se fosse um dicionário

contract NovaTurmaMapping {
    //entendimento básico de mapping
    mapping(string => string) public dicionario;

    //definindo estrutura que o nome do aluno indica o numero da presença
    mapping(string => uint256) public presencaNumero;

    //definindo estrutura que o endereço indica uma booliana se esteve presente ou não (true e false)
    mapping(address => bool) public presenca;

    //definindo estrutura que vai indicar outro mapping de um endereço que definem um numero
    mapping(address => mapping(address => uint256)) public NotaProfAluno;

    //Atualizando o nosso dicionário
    function setarPalavrasAoDicio(string memory _palavra, string memory _significado) external {
        dicionario[_palavra] = _significado;
    }

    //Atualizando a estrutura do mapping de acordo com o nome
    function setarNumpresenca(uint256 _numeroChegada, string memory _nomedoAluno) external {
        presencaNumero[_nomedoAluno] = _numeroChegada;
    }

    //definindo estrutura que vai indicar outro mapping de um endereço que definem um numero
    function setarPresenca() external {
        presenca[msg.sender] = true;
    }

    //definindo estrutura do endereço do professor setando a nota do endereço do aluno
    function setarNotaAluno(address _aluno, uint256 _nota) external {
        NotaProfAluno[msg.sender][_aluno] = _nota;
    }
}
