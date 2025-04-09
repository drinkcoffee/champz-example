// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {ChampzERC1155Soulbound} from "../src/ChampzERC1155Soulbound.sol";

contract ChampzERC1155SoulboundScript is Script {
    // Fetch latest values from:
    // https://api.immutable.com/v1/chains
    // https://api.sandbox.immutable.com/v1/chains
    address constant MAINNET_OPERATOR_ALLOWLIST = 0x5F5EBa8133f68ea22D712b0926e2803E78D89221;
    address constant TESTNET_OPERATOR_ALLOWLIST = 0x6b969FD89dE634d8DE3271EbE97734FEFfcd58eE;
    address constant MAINNET_MINTER_API_MINTER = 0xbb7ee21AAaF65a1ba9B05dEe234c5603C498939E;
    address constant TESTNET_MINTER_API_MINTER = 0x9CcFbBaF5509B1a03826447EaFf9a0d1051Ad0CF;

    address constant OWNER = 0xE0069DDcAd199C781D54C0fc3269c94cE90364E2;

    ChampzERC1155Soulbound public token;

    function setUp() public {}

    function deploy(bool _deployToMainnet) public {
        string memory baseURI = "https://drinkcoffee.github.io/projects/erc1155nfts/{id}.json";
        string memory contractURI = "https://drinkcoffee.github.io/projects/erc1155nfts/sample-collection.json";
        string memory name = "ERC1155 Soulbound Sample Collection";
        string memory symbol = "SB8";
        uint96 feeNumerator = 200; // 2%

        address operatorAllolist = _deployToMainnet ? MAINNET_OPERATOR_ALLOWLIST : TESTNET_OPERATOR_ALLOWLIST;

        address owner = OWNER;
        address royaltyReceiver = owner;

        vm.broadcast();
        token = new ChampzERC1155Soulbound(
            owner, // address owner,
            name,
            symbol,
            baseURI,
            contractURI,
            operatorAllolist,
            royaltyReceiver,
            feeNumerator
        );

        console.log("Deployed to: %x", address(token));
    }

    // The Minter API's address must be granted minter role prior to minting.
    function grantMinterRole(bool _mainnet, address _contract) public {
        address minter = _mainnet ? MAINNET_MINTER_API_MINTER : TESTNET_MINTER_API_MINTER;

        ChampzERC1155Soulbound erc1155 = ChampzERC1155Soulbound(_contract);

        bytes32 MINTER_ROLE = erc1155.MINTER_ROLE();

        // Must be called by owner
        vm.startBroadcast();
        erc1155.grantRole(MINTER_ROLE, minter);
        vm.stopBroadcast();

        console.log("grantMinterRole complete");
    }
}
