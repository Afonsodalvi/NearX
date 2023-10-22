// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

//NÃO PRECISO OBRIGATORIAMENTE IMPLEMENTAR AS FUNÇÕES NO CONTRATO FILHO
abstract contract Dados { //nao conseguimos implementar esse contrato abstrato e nem modificar suas variaveis pelas
        // funcoes de outro contrato
    //posso inserir variáveis
    string public name; //nome
    uint256 public age; //idade

    // só pode por EOAS
    function setName(string memory _name) external virtual {
        name = _name;
    }

    //Qualquer conta, podendo ser contrato ou EOAS
    function setAge(uint256 _age) public virtual {
        age = _age;
    }

    function getDados() public view virtual returns (string memory, uint256) {
        return (name, (age));
    }
}

contract Setinformation is Dados {
    Dados public dados;

    function setAgeinDados(uint256 _age) external {
        dados.setAge(_age);
        //mesmo que tenha variáveis e funções que as modifiquem --->
        // NÃO conseguimos modificar uma variável e um estado do contrato abstrato
    }

    //mas não somos obrigados a implementar as funções acima

    function getDadosforAbs() external view returns (string memory, uint256) {
        return getDados();
    }
}
