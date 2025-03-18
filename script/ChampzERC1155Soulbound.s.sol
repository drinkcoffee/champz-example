// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {ChampzERC1155Soulbound} from "../src/ChampzERC1155Soulbound.sol";

contract ChampzERC1155SoulboundScript is Script {
    ChampzERC1155Soulbound public token;

    function setUp() public {}

    function run() public {
        vm.broadcast();
        token = new ChampzERC1155Soulbound(
            0x3742bdFe39b00d6Ac8F109f083c167a06A705B01, // address owner,
            "Champz Soulbound", // string memory name,
            "CSB",
            "https://api-alpha.champz.world/soulbound/", // string memory baseURI,
            "https://api-alpha.champz.world/soulbound/json", // string memory contractURI,
            0x78A3399bB13E472F2B2B8493b228b7cAC0Dbed1d, //MainNet OAL: 0x5F5EBa8133f68ea22D712b0926e2803E78D89221, // address operatorAllowlist,
            0x8BF1282eD9F4319B93163A0171cA54246B6F9101, // address royaltyReceiver,
            500 // uint96 feeNumerator
        );

        console.log("Deployed to: %x", address(token));

    }
}
