//SPDX-License-Identifier: MIT License
pragma solidity ^0.8.6;

import "hardhat/console.sol";

import "../IRewardStrategy.sol";

import "@openzeppelin/contracts/utils/introspection/ERC165Checker.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";

contract NormalRewardStrategy is IRewardStrategy, ERC165 {
    using ERC165Checker for address;

    function onPoiChangeOwnership(
        address from,
        address to,
        uint256 tokenId
    ) external override {
        console.log(
            "RewardStrategyMock: onPoiChangeOwnership",
            from,
            to,
            tokenId
        );
    }

    function onUpdateReward(uint256 tokenId, address account)
        external
        override
    {
        console.log("RewardStrategyMock: onUpdateReward", tokenId, account);
    }

    function onUpdateRewardRate(uint256 tokenId) external override {
        console.log("RewardStrategyMock: onUpdateRewardRate", tokenId);
    }

    function initialize(uint256 initalRewardAmount, bytes calldata data)
        external
        override
    {
        console.log("RewardStrategyMock: initialize", initalRewardAmount, address(this));

        (uint256 endData, uint256 rewardPoiCount) = abi.decode(
            data,
            (uint256, uint256)
        );
        console.log("endData", endData);
        console.log("rewardPoiCount", rewardPoiCount);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC165, IERC165)
        returns (bool)
    {
        return
            interfaceId == type(IRewardStrategy).interfaceId ||
            super.supportsInterface(interfaceId);
    }
}
