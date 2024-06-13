# Documentação do Contrato Inteligente `ExemplosUIntInt`

## Visão Geral
Este contrato em Solidity demonstra o uso e manipulação de vários tipos de dados fundamentais em smart contracts. As variáveis de estado e as funções são projetadas para ilustrar como interações básicas e manipulações de dados podem ser implementadas em Solidity.

## Variáveis de Estado

- `uint8 public maxPermit = 255`
  - Inteiro sem sinal de 8 bits com valor inicial 255. Valor máximo para `uint8`.
  
- `uint8 public testLimit`
  - Variável `uint8` para testar o limite superior de valores uint8.

- `int256 public negativo = -1`
  - Inteiro com sinal de 256 bits, inicializado com -1.

- `uint256 public numero`
  - Inteiro sem sinal de 256 bits, inicializado como zero.

- `int256 public numeroNegativo`
  - Inteiro com sinal de 256 bits, inicialmente zero.

- `bool permissao`
  - Variável booleana, inicialmente `false`.

- `address public contaRegistrada`
  - Endereço Ethereum que pode ser registrado via funções do contrato.

- `string public nome`
  - Nome associado a um endereço.

- `bytes public Meusbytes`
  - Dados em bytes que podem ser armazenados e acessados.

## Funções

### inserirMaxUint
- `function inserirMaxUint(uint8 _numero) external`
  - Permite definir `testLimit`. Deve ser cuidadoso para não causar overflow com valores acima de 255.

### inserirNum
- `function inserirNum(uint256 _numero) external`
  - Permite a definição externa do valor de `numero`.

### testNegatvo
- `function testNegatvo(int256 _numero) external view returns (int256)`
  - Retorna a subtração de `-1` pelo valor de `_numero`, mostrando a manipulação de inteiros negativos.

### mudarpermissao
- `function mudarpermissao(bool _trueOuFalse) external`
  - Altera o estado da variável `permissao`.

### RegistrarEndereco
- `function RegistrarEndereco(address _endereco) external`
  - Permite registrar um endereço externo em `contaRegistrada`.

### RegistrarMeuEnderecoeNome
- `function RegistrarMeuEnderecoeNome(string memory _meunome) external`
  - Associa o `msg.sender` e um nome fornecido à conta registrada.

### armazenarDados
- `function armazenarDados(bytes memory _dados) public`
  - Armazena dados em bytes na variável `Meusbytes`.

### convertStringBytes
- `function convertStringBytes(string memory _minhafrase) external pure returns (bytes32)`
  - Converte uma string em `bytes32`.

### obterTamanhoDados
- `function obterTamanhoDados() public view returns (uint256)`
  - Retorna o comprimento dos dados armazenados em `Meusbytes`.

## Uso
Este contrato pode ser usado para fins educacionais ou como base para contratos mais complexos que exigem manipulação básica de tipos de dados em Solidity.
