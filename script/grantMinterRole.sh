#!/bin/bash
# Grant the minter role to the Minter API
useMainNet=0

if [ useMainNet -eq 1 ]
then
    echo *** Immutable zkEVM Mainnet Configuration ***
    RPC=https://rpc.immutable.com
    BLOCKSCOUT=https://explorer.immutable.com/api?
    USEMAINNET=true
else
    echo *** Immutable zkEVM Testnet Configuration ***
    RPC=https://rpc.testnet.immutable.com
    BLOCKSCOUT=https://explorer.testnet.immutable.com/api?
    USEMAINNET=false
fi

echo PKEY: $PKEY
echo RPC URL: $RPC
echo Blockscout API Key: $APIKEY
echo Blockscout URI: $BLOCKSCOUT$APIKEY
echo Use Mainnet: $USEMAINNET
echo ERC1155: $NFTCONTRACT

if [ -z "${PKEY}" ]; then
    echo "Error: PKEY environment variable is not set"
    exit 1
fi
if [ -z "${APIKEY}" ]; then
    echo "Error: APIKEY environment variable is not set"
    exit 1
fi
if [ -z "${NFTCONTRACT}" ]; then
    echo "Error: NFTCONTRACT environment variable is not set"
    exit 1
fi


# To switch from private key environment variable to private key in ledger:
# Remove: 
#    --private-key $PKEY \
# Add:
#    --ledger \
#    --hd-paths "m/44'/60'/0'/0/1" \
# where m/44'/60'/0'/0/1 is the path to the key to use.

# Add resume option if the script fails part way through:
#     --resume \

forge script --rpc-url $RPC \
    --private-key $PKEY \
    --priority-gas-price 10000000000 \
    --with-gas-price     10000000100 \
    -vvv \
    --broadcast \
    --verify \
    --verifier blockscout \
    --verifier-url $BLOCKSCOUT$APIKEY \
    --sig "grantMinterRole(bool _mainnet, address _proxy)" \
    script/ChampzERC1155Soulbound.s.sol:ChampzERC1155SoulboundScript \
    $USEMAINNET $NFTCONTRACT

