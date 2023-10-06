// SPDX-License-Identifier: GPL-3.0

//aula operadores
pragma solidity ^0.8.0;

contract ExemploOperadores {
    uint256 valor;

    function calcularMedia(uint256 a, uint256 b) public pure returns (uint256) {
        uint256 media = (a + b) / 2; //divisão
        return media;
    }

    function calcularMultiplicar(uint256 a, uint256 b) public pure returns (uint256) {
        uint256 multiplicar = (a + b) * 2; //multiplicação da soma por 2
        return multiplicar;
    }

    function verificarVerdadeiro(bool a, bool b) public pure returns (bool) {
        bool resultado = a && b; //se um é falso sempre retorna falso, só retorna verdadeiro se os dois forem
        return resultado; //lógica AND, se "a" and (e) "b" forem true retorna true
    }

    function verificarCondicional(bool a, bool b) public pure returns (bool) {
        bool resultado = a || b; //se uma condição for verdadeira, retorna verdadeira
        return resultado;
    }

    function verificarMaior(uint256 a, uint256 b) public pure returns (bool) {
        bool resultado = a > b; //se "a" é maior que "b" retorna verdadeiro
        return resultado;
    }

    function verificarSeIgual(uint256 a, uint256 b) public pure returns (bool) {
        bool resultado = a == b; //se "a" é igual a "b" retorna verdadeiro
        return resultado;
    }

    function verificarSeDiferente(uint256 a, uint256 b) public pure returns (bool) {
        bool resultado = a != b; //se "a" é diferente de "b" retorna verdadeiro
        return resultado;
    }

    function setValor(uint256 novoValor) public {
        if (novoValor >= 10) {
            //se o valor inserido
            //for maior ou igual a 10
            valor = novoValor; //a varipavel global atualiza no valor
        } else {
            //se não for, o valor será zero
            valor = 0;
        }
    }

    function getValor() public view returns (uint256) {
        return valor; //verifique
    }
}
