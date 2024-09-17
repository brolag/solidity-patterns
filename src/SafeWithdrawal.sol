// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SafeWithdrawal {
    mapping(address => uint) public balances;

    // Función para depositar Ether en el contrato
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    // Función para retiro, siguiendo el patrón de Chequeo-Efectos-Interacción
    function withdraw(uint _amount) public {
        // Chequeo: Verifica si remitente tiene suficiente balance para retirar
        require(balances[msg.sender] >= _amount, "Saldo insuficiente");

        // Efecto: Actualiza el balance antes de la interacción
        balances[msg.sender] -= _amount;

        // Interacción: Transfiere Ether al remitente
        (bool sent, ) = msg.sender.call{value: _amount}("");
        require(sent, "Fallo al enviar Ether");
    }

    // Función para consultar el balance del contrato
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}