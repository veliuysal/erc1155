// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

import "./interfaces/IERC2981.sol";

abstract contract ERC2981Collection is IERC2981 {

  // ERC165
  // _setRoyalties(address,uint256) => 0x40a04a5a
  // royaltyInfo(uint256,uint256) => 0x2a55205a
  // ERC2981Collection => 0x6af56a00

  address private royaltyAddress;
  uint256 private royaltyPercent;

  // Set to be internal function _setRoyalties
  // _setRoyalties(address,uint256) => 0x40a04a5a
  function _setRoyalties(address _receiver, uint256 _percentage) internal {
    royaltyAddress = _receiver;
    royaltyPercent = _percentage;
  }

  // Override for royaltyInfo(uint256, uint256)
  // royaltyInfo(uint256,uint256) => 0x2a55205a
  function royaltyInfo(
    uint256 _tokenId,
    uint256 _salePrice
  ) external view override(IERC2981) returns (
    address receiver,
    uint256 royaltyAmount
  ) {
    receiver = royaltyAddress;

    // This sets percentages by price * percentage / 100
    royaltyAmount = _salePrice * royaltyPercent / 100;
  }
}