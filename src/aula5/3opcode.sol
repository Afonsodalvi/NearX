// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

/*
Yul é uma fina camada de abstração na linguagem opcode EVM que pode ser usada 
em um arquivo de contrato Yul autônomo ou em um arquivo de contrato Solidity 
por meio de um assembly bloco.

Entendimento de gas e a importancia da eficiencia
*/

contract OpcodeGas {
    
    function somaEmsolidity(uint256 a, uint256 b) external pure returns (uint256){
        uint256 soma = a + b;
        return soma;// 954 gas
    }

    function somaemOpcodeYul(uint256 a, uint256 b) external pure returns (uint256 result) {
        assembly {
            result := add(a, b)
            } 
        return result; // 781 gas
    }


}

contract gasGolf{

    uint total;

    //jeito sem optmizacao: [10,20,3] 55113 gas
    function somaSeforPareMenorque50(uint[] memory nums) external{
         for (uint i = 0; i < nums.length; i += 1) {
            //realizamos dois checks aqui
            bool ePar = nums[i] % 2 == 0;
            bool eMenorQue50 = nums[i] < 50;
            if (ePar && eMenorQue50) { //as duas tem que ser verdadeiro para termos a soma abaixo
                total += nums[i];
            }
        }
    }

    //jeito com optmizacao:
    //calldata reduz significamente
    //[10,20,3] 32884 gas
    function somaSeforPareMenorque50opmize(uint[] calldata nums) external{
        uint _total = total;
        uint len = nums.length; //so de declararmos aqui as variaveis no incio ja gera reducao

         for (uint i = 0; i < len; i += 1) {
            uint num = nums[i]; //pegamos todos os numeros inseridos
            if (num % 2 == 0 && num < 50) { 
                //verifica se o numero e dividivel por dois e se o num e menor que 50
                //as duas tem que ser verdadeiro para termos a soma abaixo
                _total += nums[i];
            }
            unchecked {
                ++i;
            }
        }
        total = _total;
    }
}

//Vamos rodar o teste dos contratos abaixo para entendermos a diferenca de custo:

//https://github.com/omnes-tech/Gastest