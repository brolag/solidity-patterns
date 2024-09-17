// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EmergencyStopExample {
    address private owner;
    bool private paused;

    modifier onlyOwner() {
        require(msg.sender == owner, "No eres el propietario");
        _;
    }

    modifier whenPaused() {
        require(paused, "El contrato no está pausado");
        _;
    }

    event Paused();
    event Unpaused();
		event FundsWithdrawn(address owner, uint amount);
		
    constructor() {
        owner = msg.sender;
        paused = false;
    }

    function pause() public onlyOwner {
        paused = true;
        emit Paused();
    }

    function unpause() public onlyOwner {
        paused = false;
        emit Unpaused();
    }

    function emergencyWithdraw() public onlyOwner whenPaused {
        // Suponiendo que esta función retira todos los fondos del contrato a la dirección del propietario
        uint balance = address(this).balance;
        (bool sent, ) = owner.call{value: balance}("");
        require(sent, "Fallo al enviar Ether");
        emit FundsWithdrawn(owner, balance);
    }

    // Otras funciones del contrato deben también verificar el estado de `paused` usando el modificador `whenNotPaused`
}