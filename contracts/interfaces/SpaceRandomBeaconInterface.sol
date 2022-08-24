// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface SpaceRandomBeaconInterface {
  /**
   * @notice Request a random beacon
   * @return requestId - A unique identifier for the request
   */
  function requestRandomBeacon() external returns (uint256 requestId);
}
