// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract ExemplosArrays {
    string[4] public Alunos; //0,1,2,3,4 -- esse é o limite
    string[] public DisciplinaNome; //dinamica 0,1,2....
    string[][] private MatrizesDiscProf; //

    //inserir nome da disciplina...
    function definirDisciplina(string memory nomeD) external {
        DisciplinaNome.push(nomeD);
    }

    //Excluir nome da disciplina...
    function deletarElemento(uint256 numeroD) external {
        delete DisciplinaNome[numeroD];
    }

    //Definir nome de aluno e por número...
    function definirAluno(uint8 num, string memory novoAluno) external {
        Alunos[num] = novoAluno;
    }

    //Definir multidimenções para diciplina do professor
    //linha 0 coluna 0 -- será a disciplina
    //linha 0 coluna 1 -- será o professor

    //Assim, a gaveta 0 está guardando as dimensões de disciplina e professor

    //nova gaveta 1:
    //linha 1 coluna 0 --- outra disciplina
    //linha 1 coluna 1 -- outro professor

    //exemplo inserir a disciplina geografia na primeira interação ela ficará armazenado na casa 0 e inserindo o
    // professor Joao ele ficará no 1 da segunda array
    //Assim, se buscarmos no retorno os dois valores zeros ele só retorna a disciplina e se inserirmos o 0 e o 1 ele
    // retorna o professor da disciplina zero
    function definirProfeDiciplina(string memory disciplina, string memory professor) external {
        MatrizesDiscProf.push([disciplina, professor]);
    }

    //retornar multidimenções
    //
    function RetornarProfIndiceDisci(
        uint256 Indicedisciplina,
        uint256 IndiceProf
    )
        external
        view
        returns (string memory)
    {
        return MatrizesDiscProf[Indicedisciplina][IndiceProf];
    }
    //indice [0] -- nessa (primeira linha da matriz) caixa vai guardar a disciplinas
    //       [1] -- na segunda dimensão vai guardar os professores
}
