// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract liguidityExpli{

}
//Tokenomics da nossa Liquidity Pool

//Vamos usar a UniswapV3

///teremos dois tokens nosso um utility e outra modelo stablecoin (lembrando simulaçao dela)

//nome e simbolo do nosso Utility Token:
//AfonsoCoin -- AFOC

//nossa stalecoin Emitida por uma empresa conceituada no mercado Web3:
//Emitido pela Lumx, nome e simbolo:
// LumxUSD - LUSD

//--------------->

/* 
Lógica das moedas:

As duas tem 1 milhão no total emitidas.

Vamos criar um tokenomics:
Nosso projeto vai deixar 50% (500k) em Liquidity Pool da paridade Utility e StableCoin, 
deixando um capital razoavel para o mercado e tendo liquidez o suficiente.
O restante vamos dividir para quem trabalha no projeto: Fundadores 20%, Desenvolvedores 15% e marketing 15%


1. Preço atual dos Tokens:
AFOC = LUSD

Vamos montar nossa liquidity Pool sendo o range/faixa: 
Vai ser o preço minimo: 0.01 LUSD
Preço máximo: 30 LUSD

Assim, vamos montar nossa posição para ganharmos 0,3% 
No sistema atual, a Uniswap dá aos LPs 0,3% para cada transação, 
dependendo de sua participação no pool. 
Isso é uma adição de 0,05% sobre as transações, reduzindo 
os rendimentos da LP de 0,3% para 0,25%, sujeito às mudança de governança por voto.

A taxa cobrada pela Uniswap é de 3%

*/
