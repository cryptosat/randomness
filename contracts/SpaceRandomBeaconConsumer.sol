// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract SpaceRandomBeaconConsumer {
  error OnlySpaceRandomBeaconCanFulfill(address sender, address allowed);

  // The address of the SpaceRandomBeacon contract
  address private immutable randomBeacon;

  constructor(address _randomBeacon) {
    randomBeacon = _randomBeacon;
  }

  // In Solidity, functions marked internal can only be called
  // internally or by derived contracts. No external calls
  // can be made.
  // Contracts which want to consume random values will need to
  // override this function to include their own logic to use
  // returned random value.
  function fulfillRandomBeacon(
    uint256 requestId,
    uint256 random,
    bytes memory signature
  ) internal virtual;

  function rawFulfillRandomBeacon(
    uint256 requestId,
    uint256 random,
    bytes memory signature
  ) external {
    // This function can be called by the space random beacon
    // address that was specified when this contract was
    // initially deployed.
    if (msg.sender != randomBeacon) {
      revert OnlySpaceRandomBeaconCanFulfill(msg.sender, randomBeacon);
    }
    fulfillRandomBeacon(requestId, random, signature);
  }
}
