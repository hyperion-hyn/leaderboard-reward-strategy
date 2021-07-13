//SPDX-License-Identifier: MIT License
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/utils/introspection/IERC165.sol";

interface IRewardStrategy is IERC165 {
    function onPoiChangeOwnership(
        address from,
        address to,
        uint256 tokenId
    ) external;

    function onUpdateReward(uint256 tokenId, address account) external;

    function onUpdateRewardRate(uint256 tokenId) external;

    function initialize(uint256 initalRewardAmount, bytes calldata data) external;
}
