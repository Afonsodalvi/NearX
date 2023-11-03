// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "openzeppelin-contracts/contracts/utils/Counters.sol"; //biblioteca de contagem 

contract whileTest is ERC721 { 
    //Entendimento de contagem para NFTs:
    using Counters for Counters.Counter; //falamos que o Counters será usadondo a biblioteca de contagem 

    Counters.Counter private supply; //a Contagem será o supply (quantidade mintada) do NFT

    //----------------------------------//
    //entendimento do loop com exemplo de bolo
    uint256 numeroDePecas = 12; //numero de pedacos de cada bolo criado

    uint public somaBolo; //quantidade de de bolos -- sempre soma de 12 em 12. Sendo cada bolo 12 pedacos
    uint farinha=2; //imagine que sao 2kilos
    uint acucar=1; //imagine que e 1kilo

    mapping(address => uint256) public totaldeKilos; //cada bolo criado pelo usuario deve tera 3 kilos
    address[] public Donosbolos;

    //--------------------///

    //como funciona na pratica em colecoes:



    constructor() ERC721("Mycollection", "Symbol") { 
        //obrigatoriamente devemos colocar por conta de impportarmos e definirmos como uma coleção
    }


function bolo() public returns (string memory novoBolo){ 
    for (uint256 i = 0; i < numeroDePecas; i++) { // condição e incremento que cada bolo de 12 pedacos tem
    // código a ser repetido -- ele pega 12 como condição inicial
    farinha;//ele repete a quantidade de farinha
    acucar;//de bolo
    somaBolo++; // e soma mais um bolo
    totaldeKilos[msg.sender]= farinha + acucar; //adciona a quantidade de kilos vinculado ao endereco na criacao do bolo
}
Donosbolos.push(msg.sender); //adiciona na array a conta dono de bolo
return novoBolo = "mais um bolo pronto";
}


//--colecao------->

// Mint function
    function mint(address _receiver,uint256 _mintAmount)
        public
        payable //aqui para aceitar pagamentos
    {
        for (uint256 i = 0; i < _mintAmount; i++) {//pega a quantidade
            supply.increment(); //incrementa e sendo o ID novo
            _safeMint(_receiver, supply.current());//pega o id corrent que seria o de cima
            //e repete o mint na quantidade inserida no mintAmount
        }
    }

}