// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library SignatureVerifier {
  function  verify(
    address signer,
    bytes32 message,
    bytes memory signature
  ) internal pure returns (bool) {
    // Cryptosat uses SHA256 instead of Keccak256.
    bytes32 messageHash = sha256(abi.encodePacked(message));

    return recoverSigner(messageHash, signature) == signer;
  }

  function recoverSigner(bytes32 messageHash, bytes memory signature) internal pure returns (address) {
    (bytes32 r, bytes32 s, uint8 v) = splitSignature(signature);

    return ecrecover(messageHash, v, r, s);
  }

  function splitSignature(bytes memory sig)
    internal
    pure
    returns (
      bytes32 r,
      bytes32 s,
      uint8 v
    )
  {
    require(sig.length == 65, "invalid signature length");

    assembly {
      /*
            First 32 bytes stores the length of the signature

            add(sig, 32) = pointer of sig + 32
            effectively, skips first 32 bytes of signature

            mload(p) loads next 32 bytes starting at the memory address p into memory
            */

      // first 32 bytes, after the length prefix
      r := mload(add(sig, 32))
      // second 32 bytes
      s := mload(add(sig, 64))
      // final byte (first byte of the next 32 bytes)
      v := byte(0, mload(add(sig, 96)))
    }

    // implicitly return (r, s, v)
  }
}
