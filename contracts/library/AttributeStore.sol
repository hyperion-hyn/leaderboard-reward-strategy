//SPDX-License-Identifier: MIT License
pragma solidity ^0.8.6;

library AttributeStore {
    struct Data {
        mapping(bytes32 => uint256) store;
    }

    function getAttribute(
        Data storage self,
        bytes32 uuid,
        string memory _attrName
    ) internal view returns (uint256) {
        bytes32 key = keccak256(abi.encodePacked(uuid, _attrName));
        return self.store[key];
    }

    function setAttribute(
        Data storage self,
        bytes32 uuid,
        string memory _attrName,
        uint256 _attrVal
    ) internal {
        bytes32 key = keccak256(abi.encodePacked(uuid, _attrName));
        self.store[key] = _attrVal;
    }
}
