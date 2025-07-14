pragma solidity ^0.8.0;

import "./Pausable.sol";

contract FlashToken is Pausable {
    string public name = "Flash";
    string public symbol = "FLASH";
    uint8 public decimals = 6;
    uint256 private _totalSupply = 1000000000 * (10 ** uint256(decimals));
    mapping(address => uint256) private _balances;

    constructor() public {
        _balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    event Transfer(address indexed from, address indexed to, uint256 value);

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public whenNotPaused returns (bool) {
        require(recipient != address(0), "Cannot send to zero address");
        require(_balances[msg.sender] >= amount, "Insufficient balance");

        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }
}
