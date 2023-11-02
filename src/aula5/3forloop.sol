// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract whileTest { 
      

    uint256 numeroDePecas = 12; //numero de pedacos de cada bolo criado

    uint public somaBolo; //quantidade de de bolos -- sempre soma de 12 em 12. Sendo cada bolo 12 pedacos
    uint farinha=2; //imagine que sao 2kilos
    uint acucar=1; //imagine que e 1kilo

    mapping(address => uint256) public totaldeKilos; //cada bolo criado pelo usuario deve tera 3 kilos
    address[] public Donosbolos;
    //como funciona na pratica em colecoes:


function bolo() public returns (string memory novoBolo){ 
    for (uint256 i = 0; i < numeroDePecas; i++) { // condição e incremento que cada bolo de 12 pedacos tem
    // código a ser repetido
    farinha;//ele repete a quantidade de farinha
    acucar;//de bolo
    somaBolo++; // e soma mais um bolo
    totaldeKilos[msg.sender]= farinha + acucar; //adciona a quantidade de kilos vinculado ao endereco na criacao do bolo
}
Donosbolos.push(msg.sender); //adiciona na array a conta dono de bolo
return novoBolo = "mais um bolo pronto";
}


}