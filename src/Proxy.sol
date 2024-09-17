// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Contrato de Implementación
contract LogicContractV1 {
    uint public counter;

    function increment() public {
        counter += 1;
    }
}

// Contrato Proxy
contract Proxy {
    address public implementation;

    constructor(address _logic) {
        implementation = _logic;
    }

    function upgrade(address _newImplementation) external {
        implementation = _newImplementation;
    }

    fallback() external payable {
        address _impl = implementation;
        require(_impl != address(0));
        assembly {
            let ptr := mload(0x40)
            calldatacopy(ptr, 0, calldatasize())
            let result := delegatecall(gas(), _impl, ptr, calldatasize(), 0, 0)
            let size := returndatasize()
            returndatacopy(ptr, 0, size)
            switch result
            case 0 { revert(ptr, size) }
            default { return(ptr, size) }
        }
    }
}