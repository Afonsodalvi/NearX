// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


contract ExercicioLoja{

    enum Status{ //inserindo o status do usuario
        PENDING,//0
        LOGGED, //1
        PURCHASE, //2
        RECEIVE //3
    }

    Status public status; //status da compra
    uint idadeDezoito = 18;//idade minima
    mapping(address => bool) public approved;//registra a aprovacao no login
    mapping(address => uint256) balance; //saldo do cliente no contrato 

    address payable constant appleStore = payable(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4); //endereco permanente da Apple

    uint256 minimumValue = 1 ether;
    string[] Product = ["Iphone 15","MacBook","AppleWatch"]; //os produtos da loja


    function get() external view returns(Status){ //retorna em qual status esta
        return status;
    }

    function login(uint _idade)external returns (bool notLegaAge){
        if(_idade < idadeDezoito){
            status = Status.LOGGED;
            revert ("Your not legal Age in Brazil");
        } else {
            approved[msg.sender] = true; //salva como aprovado
            return notLegaAge; //retorna verdadeiro ou falso 
            //falso se ele e maior de idade e passa a funcao
        }
    }

    function loginTernario(uint _idade)external view returns (bool notLegalAge){
        //maneira abreviada de escrever a instrução if/else
         // o "?" operador é chamado de operador ternário
        return _idade < idadeDezoito ? true : false;
    }

    //Helpers -- vai checar se a string de a encodada vai ser a de b.
    function compareStrings(string memory a, string memory b) internal pure returns(bool){
        return (keccak256(abi.encodePacked(a)) ==  keccak256(abi.encodePacked(b)));
    }

    function executePurchase(string memory opcaoNum)external payable checkProduct(opcaoNum){
        if(!approved[msg.sender]) revert("not approved");
        if(compareStrings(opcaoNum, Product[0])){
            require(msg.value == 1 ether, "incorrect iphone value");
            balance[msg.sender] += msg.value;
            status = Status.PURCHASE;
        }if (compareStrings(opcaoNum, Product[1])){
            require(msg.value == 2 ether, "incorrect MacBook value");
            balance[msg.sender] += msg.value;
            status = Status.PURCHASE;
        }if (compareStrings(opcaoNum, Product[2])){
            require(msg.value ==  5000000000000000000 wei, "incorrect AppleWatch value");//https://eth-converter.com/
            //equivalente a 0.5 ether
            balance[msg.sender] += msg.value;
            status = Status.PURCHASE;
        }  

    }

    function receiveOrnot(bool _receive)external {
        if(!approved[msg.sender]) revert("not approved");
        if(_receive == true){
            payable(appleStore).transfer(address(this).balance);
            status = Status.RECEIVE;
        } else {
            payable(msg.sender).transfer(balance[msg.sender]);
        }
    }


    modifier checkProduct(string memory opcao){
        require(compareStrings(opcao, Product[0]) ||
        compareStrings(opcao, Product[1]) || 
        compareStrings(opcao, Product[2]), "dont have product");
        _;
    }


}