// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.19;

import "@imtbl/contracts/contracts/token/erc1155/preset/ImmutableERC1155.sol";

error TokenSoulbound();

contract ChampzERC1155Soulbound is ImmutableERC1155 {
    constructor(
        address owner,
        string memory name,
        string memory symbol,
        string memory baseURI,
        string memory contractURI,
        address operatorAllowlist,
        address royaltyReceiver,
        uint96 feeNumerator
    ) ImmutableERC1155(owner, name, baseURI, contractURI, operatorAllowlist, royaltyReceiver, feeNumerator) {}

    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal override {
        if (!hasRole(MINTER_ROLE, msg.sender)) {
            revert TokenSoulbound();
        }
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }

    /**
     * Work around an issue with ImmutableERC1155.sol, where the token URI is not returned correctly.
     * The standard indicates that https://collection.com/game/{id}.json will return NFT 100 which is at:
     * https://collection.com/game/0000000000000000000000000000000000000000000000000000000000000064.json
     */
    function uri(uint256) public view virtual override returns (string memory) {
        string memory baseURI = baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, "{id}.json")) : "";
    }
}
