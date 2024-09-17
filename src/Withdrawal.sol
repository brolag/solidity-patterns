// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WithdrawalContract {
    mapping(address => uint) public balances;

    function withdraw() public {
        uint amount = balances[msg.sender];
        require(amount > 0);

        balances[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success);
    }
}