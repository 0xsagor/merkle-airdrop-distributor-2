const { MerkleTree } = require('merkletreejs');
const keccak256 = require('keccak256');

// Example data
const elements = [
  { addr: "0xAb8422c718243424306118BA8825b7D0f2256671", amount: "100" },
  { addr: "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db", amount: "200" }
];

const leaves = elements.map(x => 
  keccak256(Buffer.concat([
    Buffer.from(x.addr.replace('0x', ''), 'hex'),
    Buffer.from(BigInt(x.amount).toString(16).padStart(64, '0'), 'hex')
  ]))
);

const tree = new MerkleTree(leaves, keccak256, { sortPairs: true });
const root = tree.getHexRoot();

console.log("Merkle Root:", root);

// Generate proof for the first user
const leaf = leaves[0];
const proof = tree.getHexProof(leaf);
console.log("Proof for User 1:", proof);
