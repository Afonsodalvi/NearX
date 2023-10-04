// SPDX-License MIT

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract ExemplosUIntInt {
    //primeira exemplo de variáveis:
    uint8 public maxPermit = 255;
    uint8 public testLimit;
    int256 public negativo = -1;
    uint256 public numero;
    int256 public numeroNegativo;

    //segundo exemplo:
    bool permissao;
    address public contaRegistrada;
    string public nome;
    bytes public Meusbytes;

    // inserir 256 que irá reverter --
    function inserirMaxUint(uint8 _numero) external {
        testLimit = _numero;
    }

    function inserirNum(uint256 _numero) external {
        numero = _numero;
    }

    function testNegatvo(int256 _numero) external view returns (int256) {
        int256 NumNegativo = _numero; //variável interna, com essa declaração a interação fica mais barata.
        //                       -1          -3  = negativo com negativo o resultado é positivo
        int256 somaDosNegativos = negativo - NumNegativo;
        return (somaDosNegativos);
    }

    function mudarpermissao(bool _trueOuFalse) external {
        permissao = _trueOuFalse;
    }

    function RegistrarEndereco(address _endereco) external {
        contaRegistrada = _endereco;
    }

    function RegistrarMeuEnderecoeNome(string memory _meunome) external {
        contaRegistrada = msg.sender;
        nome = _meunome;
    }

    function armazenarDados(bytes memory _dados) public {
        Meusbytes = _dados;
    }

    function convertStringBytes(string memory _minhafrase) external pure returns (bytes32) {
        bytes32 minhafrase = bytes32(bytes(_minhafrase));
        return minhafrase;
    }

    function obterTamanhoDados() public view returns (uint256) {
        return Meusbytes.length;
    }
}