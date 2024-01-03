pragma solidity ^0.8.1;

contract VulnerableContract {
    mapping(address => uint) private userBalances;

    function deposit() public payable {
        require(msg.value > 0, "Deposit amount should be greater than 0");
        userBalances[msg.sender] += msg.value;
    }

    function withdraw(uint _amount) public {
        require(_amount > 0 && _amount <= userBalances[msg.sender], "Invalid amount to withdraw");
        
        (bool success, ) = msg.sender.call{value: _amount}("");
        require(success, "Transfer failed");

        userBalances[msg.sender] -= _amount;
    }

    function getBalance() public view returns (uint) {
        return userBalances[msg.sender];
    }
}
