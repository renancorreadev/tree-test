// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TreeToken is ERC20, Ownable {
    constructor() ERC20("TreeToken", "TREE") Ownable(msg.sender) {
        // Mint 1,000,000 tokens to the contract deployer
        _mint(msg.sender, 1_000_000 * 10 ** decimals());
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function airdrop(address[] memory recipients, uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        require(recipients.length > 0, "Must have at least one recipient");
        
        uint256 totalAmount = amount * recipients.length;
        require(balanceOf(msg.sender) >= totalAmount, "Insufficient balance for airdrop");

        for (uint256 i = 0; i < recipients.length; i++) {
            require(recipients[i] != address(0), "Cannot airdrop to zero address");
            _transfer(msg.sender, recipients[i], amount);
        }
    }
} 