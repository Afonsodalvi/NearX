# Documentação do Contrato Inteligente `ExemploOperadores`

## Visão Geral
Este contrato em Solidity exemplifica o uso de operadores matemáticos e lógicos básicos. As funções implementadas demonstram operações como cálculo de médias, multiplicações, e comparações lógicas, que são essenciais para entender o controle de fluxo e a lógica em contratos inteligentes.

## Variáveis de Estado

- `uint256 valor`
  - Variável de estado que armazena um valor numérico, podendo ser ajustado com base em condições específicas dentro do contrato.

## Funções

### calcularMedia
- `function calcularMedia(uint256 a, uint256 b) public pure returns (uint256)`
  - Calcula e retorna a média de dois números. A operação é realizada somando os dois valores fornecidos e dividindo o resultado por 2.

### calcularMultiplicar
- `function calcularMultiplicar(uint256 a, uint256 b) public pure returns (uint256)`
  - Retorna o dobro da soma de dois números. Isso é útil para demonstrações de operações aritméticas em Solidity.

### verificarVerdadeiro
- `function verificarVerdadeiro(bool a, bool b) public pure returns (bool)`
  - Avalia e retorna o resultado lógico AND de dois valores booleanos. Retorna verdadeiro apenas se ambos os valores forem verdadeiros.

### verificarCondicional
- `function verificarCondicional(bool a, bool b) public pure returns (bool)`
  - Avalia e retorna o resultado lógico OR de dois valores booleanos. Retorna verdadeiro se pelo menos um dos valores for verdadeiro.

### verificarMaior
- `function verificarMaior(uint256 a, uint256 b) public pure returns (bool)`
  - Compara dois números e retorna verdadeiro se o primeiro número for maior que o segundo.

### verificarSeIgual
- `function verificarSeIgual(uint256 a, uint256 b) public pure returns (bool)`
  - Compara dois números e retorna verdadeiro se os números forem iguais.

### verificarSeDiferente
- `function verificarSeDiferente(uint256 a, uint256 b) public pure returns (bool)`
  - Compara dois números e retorna verdadeiro se os números forem diferentes.

### setValor
- `function setValor(uint256 novoValor) public`
  - Define o valor da variável de estado `valor` baseado numa condição: se o novo valor for maior ou igual a 10, o valor é atualizado; caso contrário, é ajustado para zero.

### getValor
- `function getValor() public view returns (uint256)`
  - Retorna o valor atual armazenado na variável de estado `valor`.

## Uso
Este contrato é uma ferramenta educativa para entender como diferentes operadores funcionam em Solidity e como eles podem ser usados para manipular dados e controlar o fluxo de execução dentro de um contrato inteligente.
