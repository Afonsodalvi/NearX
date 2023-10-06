// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

//O mapeamento no Solidity não é iterável, ou seja, ele não armazena em sequência
//a menos que você armazene internamente todas as chaves que foram inseridas.

contract mappingwithArray {
    mapping(address => uint256) public balances; //saldo das chaves
    mapping(address => bool) public inserido; //controle das chaves inseridas
    address[] public contas;

    function set(address _conta, uint256 _val) external {
        balances[_conta] = _val; //armazenando o endereço chave e o valor atrelado a chave.
        inserido[_conta] = true; //atualizando que o endereço foi inserido
        //mapping é uma forma de armazenar dados onde um dado chave indica outro dado/variável
        //Assim, nesse exemplo o endereço indicará um valor
        contas.push(_conta); //adiciona na array a conta
    }

    function getSize() external view returns (uint256) {
        return contas.length; //tamanho da array com as contas armazenadas
    }

    function first() external view returns (uint256) {
        return balances[contas[0]]; //retornando o saldo do primeiro endereço armazenado na array
            //Aqui temos uma alternativa usada na prática onde queremos armazenar todas as contas e acessar pela sua
                // alocação na array
    }

    function last() external view returns (uint256) {
        return balances[contas[contas.length - 1]]; //forma de acessar o saldo da ultima conta.
            // sendo que a contagem começa com 1 e mas na lista da a array o primeiro endereço sera armazenado no
                // indice 0
            //dessa forma temos que diminuir 1 do tamanho para pegar o endereço armazenado no indice 0 e retornar seu
                // saldo
    }
}
