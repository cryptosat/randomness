// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../SignatureVerifier.sol";

contract SignatureVerifierMock {
  using SignatureVerifier for *;

  function verify(
    address signer,
    bytes32 message,
    bytes memory signature
  ) public pure returns (bool) {
    return signer.verify(message, signature);
  }

  function recoverSigner(
    bytes32 messageHash, bytes memory signature
  ) public pure returns (address) {
    return messageHash.recoverSigner(signature);
  }

  function splitSignature(
    bytes memory sig
  ) public pure returns (bytes32 r, bytes32 s, uint8 v) {
    return sig.splitSignature();
  }
}
