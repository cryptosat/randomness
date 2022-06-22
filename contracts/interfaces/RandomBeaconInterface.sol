// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface RandomBeaconInterface {
  /**
   * @notice Request a random bytes32 value
   * @return signer - Address of the signer
   * @return random - Random value generated by Cryptosat Randomness Beacon.
   * @return signature - Signature generated by Cryptosat Randomness Beacon
   * using the random value.
   */
  function getRandom()
    external
    view
    returns (
      address signer,
      bytes32 random,
      bytes memory signature
    );
}
