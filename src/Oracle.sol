// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract PriceConsumerV3 {

    AggregatorV3Interface internal priceFeed;

    /**
     * Network: Ethereum Mainnet
     * Aggregator: ETH/USD
     * Address: 0x... (Dirección del contrato de Chainlink para ETH/USD)
     */
    constructor() {
        priceFeed = AggregatorV3Interface(0x...); // Dirección del oráculo de Chainlink para ETH/USD
    }

    /**
     * Retorna el precio más reciente de ETH/USD
     */
    function getLatestPrice() public view returns (int) {
        (
            /* uint80 roundID */,
            int price,
            /* uint startedAt */,
            /* uint timeStamp */,
            /* uint80 answeredInRound */
        ) = priceFeed.latestRoundData();
        return price; // El precio se devuelve con 8 decimales
    }
}