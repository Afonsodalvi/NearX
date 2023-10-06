// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//interface e uma forma de padronizar o uso de funcoes de um contrato. Assim, facilitando o acesso a elas por outros contratos.
//interface e' usada em inumeros padroes e no exemplo abaixo vamos pegar dos contratos da Uniswap.
//Dessa forma, conseguimos interagir com as determinadas funcoes do contrato ja deployado anteriormente

contract Counter { //esse e o contrato que sempre que executamos a funcao increment ele imcrementa mais 1 na variavel count
    uint256 public count;

    function increment() external {
        count += 1;
    }
}

interface ICounter { //interface 
    function count() external view returns (uint256); //obrigatoriamente devemos declarar externas e nao precisamos abrir chaves {}

    function increment() external;
}

contract MyContract { //como nesse contrato nao declaramos "is" nao somos obrigados a repetir as funcoes, mas podemos chamar elas 
    function incrementCounter(address _counter) external {
        ICounter(_counter).increment();
    }

    function getCount(address _counter) external view returns (uint256) {
        return ICounter(_counter).count();
    }
}

// Uniswap example -- colocar no Remix Mainnet fork para funcionar
interface UniswapV2Factory {
    function getPair(address tokenA, address tokenB) external view returns (address pair);
}

interface UniswapV2Pair {
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
}

contract UniswapExample {
    address private factory = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
    address private dai = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address private weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    function getTokenReserves() external view returns (uint256, uint256) {
        address pair = UniswapV2Factory(factory).getPair(dai, weth);
        (uint256 reserve0, uint256 reserve1,) = UniswapV2Pair(pair).getReserves();
        return (reserve0, reserve1);
    }
}
