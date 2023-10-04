// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract ExerciVariaveis{
    uint idade = 18; //numero que vamos setar em uma funcao
    bool sucess; //o numero que setarmos deve ser igual

    string nome;//nome do usuario
    address endereco; //armazenando seu endereco ao entrar na plataforma
    uint private senha; //armazenando a senha gerada aleatoriamente

function confereNumber(uint _idade) view internal { //inserimos o view pq nao modificaremos nada na blockchain e o internal e de função que somente pode ser lida no contrato
    require(_idade >=  idade, "nao e permitido");
}


function EntraPlataform(string memory _nome, uint _idade) external returns(bool){ //conta EOA poderá interagir
confereNumber(_idade);
nome = _nome;
sucess = true;
return sucess;
}


function gerarSenha()external  returns(uint256){
    uint256 randomness = uint(keccak256(abi.encodePacked(msg.sender, block.difficulty, block.timestamp)));
    senha = randomness;      ////                     endereco   -  dificuldade para minera o bloco   - tempo atual
    return randomness;

    //uint256 randomNumber = block.prevrandao; // entrará no lugar do block.difficulty
}


function entreComsenha(uint256 _senha)external view returns(string memory){
    require(senha == _senha, "sua senha esta incorreta");
    return("sucesso no login");
}


}
