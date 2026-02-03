// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MerkleAirdrop is Ownable {
    IERC20 public immutable token;
    bytes32 public immutable merkleRoot;

    // Track which addresses have already claimed
    mapping(address => bool) public hasClaimed;

    event Claimed(address indexed account, uint256 amount);

    constructor(address _token, bytes32 _merkleRoot) Ownable(msg.sender) {
        token = IERC20(_token);
        merkleRoot = _merkleRoot;
    }

    /**
     * @dev Claim tokens by providing a Merkle proof.
     * @param amount Amount of tokens to claim.
     * @param proof Cryptographic proof that the sender is in the airdrop list.
     */
    function claim(uint256 amount, bytes32[] calldata proof) external {
        require(!hasClaimed[msg.sender], "Airdrop already claimed.");

        // Verify the leaf (node) in the Merkle Tree
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender, amount));
        require(MerkleProof.verify(proof, merkleRoot, leaf), "Invalid proof.");

        hasClaimed[msg.sender] = true;
        require(token.transfer(msg.sender, amount), "Transfer failed.");

        emit Claimed(msg.sender, amount);
    }

    function withdrawRemaining(uint256 amount) external onlyOwner {
        token.transfer(owner(), amount);
    }
}
