// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuctionStateMachine {
    enum Stages {
        AcceptingBlindBids,
        RevealBids,
        Finished
    }

    // Variable para almacenar el estado actual del contrato
    Stages public stage = Stages.AcceptingBlindBids;

    // Variable para almacenar el tiempo en el que el contrato avanza al siguiente estado
    uint public nextStageTime = block.timestamp + 1 days;

    // Modificador para controlar el acceso a funciones según el estado actual
    modifier atStage(Stages _stage) {
        require(stage == _stage, "Función no permitida en el estado actual.");
        _;
    }

    // Modificador para avanzar al siguiente estado basado en el tiempo
    modifier transitionNext() {
        if (block.timestamp >= nextStageTime) {
            nextStage();
        }
        _;
    }

    // Función para avanzar al siguiente estado
    function nextStage() internal {
        stage = Stages(uint(stage) + 1);
        nextStageTime = block.timestamp + 1 days;
    }

    // Ejemplo de función que puede ser llamada en un estado específico
    function acceptBlindBid() public atStage(Stages.AcceptingBlindBids) transitionNext {
        // Lógica para aceptar una puja a ciegas
    }

    function revealBids() public atStage(Stages.RevealBids) transitionNext {
        // Lógica para revelar las pujas
    }

    // Lógica para finalizar la subasta, se puede implementar en el cambio a `Finished`
}