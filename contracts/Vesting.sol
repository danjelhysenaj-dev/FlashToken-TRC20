pragma solidity ^0.8.0;

interface IToken {
    function transfer(address to, uint256 amount) external returns (bool);
}

contract TokenVesting {
    address public beneficiary;
    uint256 public start;
    uint256 public duration;
    uint256 public released;
    IToken public token;

    constructor(
        address _beneficiary,
        uint256 _start,
        uint256 _duration,
        address _token
    ) public {
        beneficiary = _beneficiary;
        start = _start;
        duration = _duration;
        token = IToken(_token);
    }

    function release() public {
        require(now >= start, "Vesting hasn't started yet");

        uint256 vested = vestedAmount();
        uint256 unreleased = vested - released;
        require(unreleased > 0, "No tokens to release");

        released += unreleased;
        token.transfer(beneficiary, unreleased);
    }

    function vestedAmount() public view returns (uint256) {
        uint256 balance = tokenBalance();
        if (now >= start + duration) {
            return balance;
        } else {
            return (balance * (now - start)) / duration;
        }
    }

    function tokenBalance() internal view returns (uint256) {
        return token.balanceOf(address(this));
    }
}
