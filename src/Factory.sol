// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Contrato hijo que nuestra fábrica producirá
contract ChildContract {
    uint public number;

    // Constructor que inicializa el contrato con un número específico
    constructor(uint _number) {
        number = _number;
    }
}