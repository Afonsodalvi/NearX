// SPDX-License-Identifier: MIT LICENSE


/*


*/

pragma solidity ^0.8.4;
import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "openzeppelin-contracts/contracts/utils/math/SafeMath.sol";
import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract AFOC is ERC20, ERC20Burnable, Ownable {
  using SafeMath for uint256;

  mapping(address => uint256) private _balances;
  mapping(address => bool) controllers;

  uint256 private _totalSupply;
  uint256 private MAXSUP;
  uint256 constant MAXIMUMSUPPLY=1000000*10**18;//poderiamos aumentar o máximo que podem emitir

  constructor() ERC20("AfonsoCoin", "AFOC") { 
      _mint(msg.sender, 1000000 * 10 ** 18);

  }

  function mint(address to, uint256 amount) external {
    require(controllers[msg.sender], "Only controllers can mint");//somente controladores podem mintar
    require((MAXSUP+amount)<=MAXIMUMSUPPLY,"Maximum supply has been reached");//aqui limita a emissão de tokens em 1 milhão
    _totalSupply = _totalSupply.add(amount);
    MAXSUP=MAXSUP.add(amount);
    _balances[to] = _balances[to].add(amount);
    _mint(to, amount);
  }

  function burnFrom(address account, uint256 amount) public override { //queimar os tokens
      if (controllers[msg.sender]) { //se for controlador ele pode queimar
          _burn(account, amount);
      }
      else {
          super.burnFrom(account, amount);
      }
  }

  function addController(address controller) external onlyOwner {
    controllers[controller] = true; ///função de adicionar novos controladores do token
  }

  function removeController(address controller) external onlyOwner {
    controllers[controller] = false; //remover controlador
  }
  
  function totalSupply() public override view returns (uint256) { //override da função delimitada no ERC20
    return _totalSupply; //retorna o total emitido
  }

  function maxSupply() public  pure returns (uint256) {
    return MAXIMUMSUPPLY; //Retorna o máximo que pode ser emitido
  }

}