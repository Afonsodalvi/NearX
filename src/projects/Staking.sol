// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "openzeppelin-contracts/contracts/token/ERC1155/IERC1155.sol";
import "openzeppelin-contracts/contracts/token/ERC1155/utils/ERC1155Receiver.sol";

contract NftStaker {
    IERC1155 public parentNFT; //o contrato que iremos exportar a interface será chamado de parentNFT

    struct Stake {
        //estrutura que vai armazenar todas as informacoes de staking
        uint256 tokenId;
        uint256 amount;
        uint256 timestamp;
    }

    //mappping staker address para o stake detalhado
    mapping(address => Stake) public stakes;

    //mapping staker to total staking time
    mapping(address => uint256) public stakingTime;

    constructor(address contrato) {
        parentNFT = IERC1155(contrato /*ENDEREÇO DO CONTRATO DEPLOYADO*/ );
    }

    function stake(uint256 _tokenId, uint256 _amount) public {
        stakes[msg.sender] = Stake(_tokenId, _amount, block.timestamp); //endereço de quem ta interagindo vamos
            // armazenar na estrutura
        //basicamente estamos armazenando as informações do NFT da conta que está interagindo
        address contractNFT = address(this);
        parentNFT.safeTransferFrom(msg.sender, address(this), _tokenId, _amount, "0x00");
        //na função acima estamos transferindo o NFT para o endereço desse contrato
    }
    //Observação muito importante é que deve ser feito a aprovação do contrato principal para executar a função acima
    //Vá no contrato principal do NFT na função setApprovalForAll e no operador coloque o endereço desse contrato
    // deployado e em approved converta para true
    //depois de aprovar faça o teste de stake com alguns Tokens NFTs stakados

    function unstake() public {
        //tirando o NFT do stake
        parentNFT.safeTransferFrom(
            address(this), msg.sender, stakes[msg.sender].tokenId, stakes[msg.sender].amount, "0x00"
        );
        stakingTime[msg.sender] += (block.timestamp - stakes[msg.sender].timestamp); //toda vez que retirar do stake
            // vamos saber quanto tempo ficou stekado
        //acima somassse o tempo de stake
        delete stakes[msg.sender];
    }

    //Sempre que deixar em stake verifique no contrato de NFT principal a conta que deixou o NFT em stake nesse contrato
    //na função "balanceOf" insira a account e o id do NFT que deixou em stake e vai retornar o valor com a diminuiçao
    // dos NFTs stakados

    function onERC1155Received(
        address operator,
        address from,
        uint256 id,
        uint256 value,
        bytes calldata data
    )
        external
        returns (bytes4)
    {
        return bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"));
    }
}
