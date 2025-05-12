// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {TreeToken} from "../src/TreeToken.sol";

contract TreeTokenTest is Test {
    TreeToken public token;
    address public owner;
    address public user1;
    address public user2;

    function setUp() public {
        owner = address(this);
        user1 = makeAddr("user1");
        user2 = makeAddr("user2");
        token = new TreeToken();
    }

    function testInitialSupply() public {
        assertEq(token.totalSupply(), 1_000_000 * 10 ** token.decimals());
        assertEq(token.balanceOf(owner), 1_000_000 * 10 ** token.decimals());
    }

    function testBurn() public {
        uint256 initialBalance = token.balanceOf(owner);
        uint256 burnAmount = 1000 * 10 ** token.decimals();
        
        token.burn(burnAmount);
        
        assertEq(token.balanceOf(owner), initialBalance - burnAmount);
        assertEq(token.totalSupply(), initialBalance - burnAmount);
    }

    function testAirdrop() public {
        address[] memory recipients = new address[](2);
        recipients[0] = user1;
        recipients[1] = user2;
        uint256 amount = 100 * 10 ** token.decimals();

        token.airdrop(recipients, amount);

        assertEq(token.balanceOf(user1), amount);
        assertEq(token.balanceOf(user2), amount);
    }
} 