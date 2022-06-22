import { expect } from 'chai'
import { Contract, ContractFactory } from 'ethers'
import { ethers } from 'hardhat'

let signatureVerifierFactory: ContractFactory

before(async function () {
  signatureVerifierFactory = await ethers.getContractFactory(
    'SignatureVerifierMock',
  )
})

describe('SignatureVerifierTest', () => {
  let signatureVerifier: Contract

  beforeEach(async function () {
    signatureVerifier = await signatureVerifierFactory.deploy()
  })

  describe('#splitSignature', () => {
    it('splits signature', async function () {
      const r =
        '0x528459e4aec8934dc2ee94c4f3265cf6ce00d47cf42bb106afda3642c72e25eb'
      const s =
        '0x42544137118256121502784e5a6425e6183ca964421ecd577db6c66ba9bccdcf'
      const v = '0x1b'
      const signature = ethers.utils.concat([r, s, v])

      const result = await signatureVerifier.splitSignature(signature)
      expect(result).to.eql([r, s, parseInt(v, 16)])
    })
  })

  describe('#recoverSigner', () => {
    it('recovers signer address', async function () {
      const digest =
        '0x7c5ea36004851c764c44143b1dcb59679b11c9a68e5f41497f6cf3d480715331'
      const r =
        '0x528459e4aec8934dc2ee94c4f3265cf6ce00d47cf42bb106afda3642c72e25eb'
      const s =
        '0x42544137118256121502784e5a6425e6183ca964421ecd577db6c66ba9bccdcf'
      const v = '0x1b'
      const signature = ethers.utils.concat([r, s, v])

      const result = await signatureVerifier.recoverSigner(digest, signature)
      expect(result).to.equal('0x0Ac1dF02185025F65202660F8167210A80dD5086')
    })
  })

  describe('#verify', () => {
    it('verifies signature', async function () {
      // Create private/public keys
      const wallet = ethers.Wallet.createRandom()
      const signer_address = ethers.utils.computeAddress(wallet.publicKey)
      // '0x' + 20 (eth address length) byte string => 2 + 20 * 2 = 42
      expect(signer_address.length).to.equal(42)

      // Use sha256 and the low level signing key api to not append
      // \x19Ethereum Signed Message:\n32.
      const random = ethers.utils.randomBytes(32)
      const digest = ethers.utils.sha256(random)
      const signing_key = new ethers.utils.SigningKey(wallet.privateKey)
      const signature = signing_key.signDigest(digest)

      const sig_buf = ethers.utils.joinSignature(signature)
      // '0x' + 65 byte string => 2 + 65 * 2 = 132
      expect(sig_buf.length).to.equal(132)
      const result = await signatureVerifier.verify(
        signer_address,
        random,
        sig_buf,
      )

      expect(result).to.equal(true)
    })
  })
})
