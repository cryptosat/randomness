// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@cryptosat/randomness/contracts/SpaceRandomBeaconConsumer.sol";
import "@cryptosat/randomness/contracts/interfaces/SpaceRandomBeaconInterface.sol";
import "@cryptosat/randomness/contracts/SignatureVerifier.sol";

contract ClientContract is SpaceRandomBeaconConsumer {
  SpaceRandomBeaconInterface SpaceRandomBeacon;

  bytes public signature;
  uint256 public random;
  uint256 public requestId;
  address owner;

  constructor(address randomBeacon) SpaceRandomBeaconConsumer(randomBeacon) {
    SpaceRandomBeacon = SpaceRandomBeaconInterface(randomBeacon);
    owner = msg.sender;
  }

  function fulfillRandomBeacon(
    uint256 /* requestId */,
    uint256 _random,
    bytes memory _signature
  ) internal override {
    random = _random;
    signature = _signature;
  }

  function requestRandomWords() external {
    require(msg.sender == owner, "Sender not equal to owner");
    requestId = SpaceRandomBeacon.requestRandomBeacon();
  }

  function verify(address signer) public view returns (bool) {
    return SignatureVerifier.verify(signer, bytes32(random), signature);
  }
}
