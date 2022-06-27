// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/SpaceRandomBeaconInterface.sol";

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
    require(verify(_signer, _randomness, _signature), "Invalid signature");
    signer = _signer;
    randomness = _randomness;
    signature = _signature;
  }

  function verify(
    address _signer,
    bytes32 _randomness,
    bytes memory _signature
  ) public pure returns (bool) {
    // Cryptosat uses SHA256 instead of Keccak256.
    bytes32 _digest = sha256(abi.encodePacked(_randomness));

    return recoverSigner(_digest, _signature) == _signer;
  }

  function recoverSigner(bytes32 _digest, bytes memory _signature) public pure returns (address) {
    (bytes32 r, bytes32 s, uint8 v) = splitSignature(_signature);

    return ecrecover(_digest, v, r, s);
  }

  function splitSignature(bytes memory _signature)
    public
    pure
    returns (
      bytes32 r,
      bytes32 s,
      uint8 v
    )
  {
    require(_signature.length == 65, "invalid signature length");

    assembly {
      /*
            First 32 bytes stores the length of the signature

            add(sig, 32) = pointer of sig + 32
            effectively, skips first 32 bytes of signature

            mload(p) loads next 32 bytes starting at the memory address p into memory
            */

      // first 32 bytes, after the length prefix
      r := mload(add(_signature, 32))
      // second 32 bytes
      s := mload(add(_signature, 64))
      // final byte (first byte of the next 32 bytes)
      v := byte(0, mload(add(_signature, 96)))
    }

    // implicitly return (r, s, v)
  }
}
