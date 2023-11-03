// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../projects/ERC20.sol"; //importando o contrato de token

contract ExercicioLoja2 is ERC20{
    
    ///contrato com programa de cashback com tokens


    uint256 idadeDezoito = 18; //idade minima
    mapping(address => bool) public approved; //registra a aprovacao no login
    mapping(address => uint256) balance; //saldo do cliente no contrato

    address payable constant appleStore = payable(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4); //endereco permanente da
        // Apple

    uint256 minimumValue = 1 ether;
    string[] Product = ["Iphone 15", "MacBook", "AppleWatch"]; //os produtos da loja
    
    ///estrutura dos produtos
    struct iphone{
        uint iphoneSolds;
        uint stock;
    }

    iphone public Iphone;

    struct mac{
        uint macSolds;
        uint stock;
    }

    mac public Mac;

    struct watch{
        uint watchSolds;
        uint stock;
    }

    watch public Watch;

    constructor(uint _stockIphone, uint _stockWacth, uint _stockMac) { //definimos as quantidades maximas no estoque
        Iphone.stock = _stockIphone;
        Mac.stock = _stockMac;
        Watch.stock = _stockWacth;
        mintTo(address(this), 100000000);
    }

    function get() external view returns (uint) {
        //retorna em qual status esta
        return balanceOf[msg.sender];
    }

    function login(uint256 _idade) external returns (bool notLegaAge) {
        if (_idade < idadeDezoito) {
            revert("Your not legal Age in Brazil");
        } else {
            approved[msg.sender] = true; //salva como aprovado
            return notLegaAge; //retorna verdadeiro ou falso
                //falso se ele e maior de idade e passa a funcao
        }
    }

    function loginTernario(uint256 _idade) external view returns (bool notLegalAge) {
        //maneira abreviada de escrever a instrução if/else
        // o "?" operador é chamado de operador ternário
        return _idade < idadeDezoito ? true : false;
    }

    //Helpers -- vai checar se a string de a encodada vai ser a de b.
    function compareStrings(string memory a, string memory b) internal pure returns (bool) {
        return (keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b)));
    }

    function executePurchase(string memory opcaoNum) external payable checkProduct(opcaoNum) {
        if (!approved[msg.sender]) revert("not approved");

        if (compareStrings(opcaoNum, Product[0])) {
            require(msg.value == 1 ether, "incorrect iphone value");
            require(Iphone.iphoneSolds+1 <= Iphone.stock, "acabou");
            for (uint256 i = 0; i < 1; i++) {//pega a quantidade
            Iphone.iphoneSolds++; //incrementa e sendo o ID novo
        }
            balanceOf[msg.sender] = 10;//saldo do token
            balance[msg.sender] += msg.value;
            
        }
        if (compareStrings(opcaoNum, Product[1])) {
            require(msg.value == 2 ether, "incorrect MacBook value");
            require(Mac.macSolds+1 <= Mac.stock, "acabou");
            for (uint256 i = 0; i < 1; i++) {//pega a quantidade
            Mac.macSolds++; //incrementa e sendo o ID novo
            }
            balanceOf[msg.sender] = 20;
            balance[msg.sender] += msg.value;
            

        }
        if (compareStrings(opcaoNum, Product[2])) {
            require(msg.value == 5_000_000_000_000_000_000 wei, "incorrect AppleWatch value"); //https://eth-converter.com/
            //equivalente a 0.5 ether
            require(Watch.watchSolds+1 <= Watch.stock, "acabou");
            for (uint256 i = 0; i < 1; i++) {//pega a quantidade
            Watch.watchSolds++; //incrementa e sendo o ID novo
            }
            balanceOf[msg.sender] = 5;
            balance[msg.sender] += msg.value;
           
        }
    }

//approve(address spender, uint256 amount) -- sempre devemos dar o approve
    function rewardsCash(uint _amount) payable external returns(string memory){
        require(balanceOf[msg.sender] >= _amount, "dont have utility token");
        if(_amount >= 10){
            IERC20(address(this)).transferFrom(msg.sender, appleStore, _amount);
            balanceOf[msg.sender]-=_amount; //ele diminui a quantidade
            return "seu premio foi um spa";
        } if (_amount < 10) {
            IERC20(address(this)).transferFrom(msg.sender, appleStore, _amount);
            balanceOf[msg.sender]-=_amount;
            return "seu premio foi um chaveiro";
         } return "";
        
    }

    function receiveOrnot(bool _receive) external {
        if (!approved[msg.sender]) revert("not approved");
        if (_receive == true) {
            payable(appleStore).transfer(address(this).balance);
        } if (_receive == false) {
            payable(msg.sender).transfer(balance[msg.sender]);
        }
    }

    modifier checkProduct(string memory opcao) {
        require(
            compareStrings(opcao, Product[0]) || compareStrings(opcao, Product[1]) || compareStrings(opcao, Product[2]),
            "dont have product"
        );
        _;
    }
}


