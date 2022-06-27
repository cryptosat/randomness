// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@cryptosat/randomness/contracts/interfaces/SpaceRandomBeaconInterface.sol";
import "@cryptosat/randomness/contracts/SignatureVerifier.sol";

contract ClientContract {
  SpaceRandomBeaconInterface beacon;

  constructor(address beaconAddr) {
    beacon = SpaceRandomBeaconInterface(beaconAddr);
  }

  address public signer;
  bytes32 public randomness;
  bytes public signature;

  function getRandom() external {
    address _signer;
    bytes32 _randomness;
    bytes memory _signature;
    (_signer, _randomness, _signature) = beacon.getRandom();
    require(SignatureVerifier.verify(_signer, _randomness, _signature), "Invalid signature");
    signer = _signer;
    randomness = _randomness;
    signature = _signature;
  }
}
