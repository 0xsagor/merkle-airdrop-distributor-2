# Merkle Airdrop Distributor

A gas-optimized solution for distributing ERC-20 tokens to a large list of eligible addresses.

### How it Works
1. **Off-chain:** Generate a Merkle Tree from a list of addresses and amounts.
2. **On-chain:** Deploy this contract with the Merkle Root.
3. **Claim:** Users provide a "proof" (generated off-chain) to the contract to claim their specific allocation.



### Benefits
* **Cost Effective:** Deploying for 10 users costs the same as deploying for 10,000.
* **Security:** Cryptographically prevents unauthorized claims or double-claiming.
* **Standardized:** Uses OpenZeppelin's robust `MerkleProof` library.

### Setup
1. `npm install`
2. Generate your Merkle Root using `merkletreejs`.
3. Deploy and call `claim()`.
