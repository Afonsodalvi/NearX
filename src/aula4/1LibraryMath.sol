// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (utils/math/Math.sol)

pragma solidity ^0.8.20;

// Bibliotecas (Librarys) são semelhantes a contratos, mas você não pode declarar nenhuma variável de estado e não pode enviar ether.

// Uma biblioteca será incorporada ao contrato se todas as funções da biblioteca forem internas.

// Caso contrário, a biblioteca deverá ser implantada e vinculada antes da implantação do contrato.

/**
 * @dev Standard math utilities missing in the Solidity language.
 */
library Math {
    

    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }


    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the largest of two numbers.
     */
    function max(uint256 a, uint256 b)internal pure returns (uint256) {
        return a > b ? a : b;
    }

    /**
     * @dev Returns the smallest of two numbers.
     */
    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        return a < b ? a : b;
    }

    
}

contract TestLibrary {
    using Math for uint256; 
    //devemos declarar que vamos usar a Library Math caso queira usar sem chamar ela em especifico como na primeira funcao
    uint public value = 10;

    function testDiv(uint256 a, uint256 b)external pure returns (bool, uint256){
        return Math.tryDiv(a,b); //devemos inserir o . e os returns devem ser iguais ao delimitados na library
    }

//Dessa forma abaixo e quando falamos que vamos usar a library para variaveis uint256 como na funcao abaixo
    function testMax(uint256 _value) external view returns(uint256){
        return value.min(_value);
    }

    //muito importante em projetos DeFi
}