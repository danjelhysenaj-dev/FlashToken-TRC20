pragma solidity ^0.8.0;

contract Pausable {
    address public owner;
    bool public paused = false;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not contract owner");
        _;
    }

    modifier whenNotPaused() {
        require(!paused, "Token is paused");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function pause() public onlyOwner {
        paused = true;
    }

    function unpause() public onlyOwner {
        paused = false;
    }
}
