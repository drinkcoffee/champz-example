#!/bin/bash
# Use the minting API. This can be accessed here: 
# https://docs.immutable.com/api/zkevm/reference/#/operations/GetMintRequest
# This only mints one NFT at a time. Multiple NFTs could be minted at once using the array of assets.

useMainNet=0

if [ ${useMainNet} -eq 1 ]
then
    echo Immutable zkEVM Mainnet Configuration
    API=https://api.immutable.com/
    CHAINNAME=imtbl-zkevm-mainnet
else
    echo Immutable zkEVM Testnet Configuration
    API=https://api.sandbox.immutable.com/
    CHAINNAME=imtbl-zkevm-testnet
fi

echo Immutable API Key: $IMMUTABLEAPIKEY
echo NFT Contract Address: $NFTCONTRACT
echo Owner of Minted NFTs: $NEWOWNER


if [ -z "${IMMUTABLEAPIKEY}" ]; then
    echo "Error: IMMUTABLEAPIKEY environment variable is not set"
    exit 1
fi
if [ -z "${NFTCONTRACT}" ]; then
    echo "Error: NFTCONTRACT environment variable is not set"
    exit 1
fi
if [ -z "${NEWOWNER}" ]; then
    echo "Error: NEWOWNER environment variable is not set"
    exit 1
fi


generate_post_data()
{
  cat <<EOF
{
  "assets": [
    {
      "reference_id": "100",
      "owner_address": "$NEWOWNER",
      "token_id": "100",
      "amount": "10",
      "metadata": {
        "name": "Grass Field",
        "image": "https://drinkcoffee.github.io/projects/erc1155nfts/100grassfield.png",
        "attributes": [
          {
            "trait_type": "Series",
            "value": "Gen1"
          },
          {
            "trait_type": "Rarity",
            "value": "Mythical"
          },
          {
            "trait_type": "Artist",
            "value": "Microsoft Designer"
          }
        ]
      }
    }
  ]
}
EOF
}

curl --request POST \
  --url ${API}v1/chains/${CHAINNAME}/collections/${NFTCONTRACT}/nfts/mint-requests \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json' \
  --header "x-immutable-api-key: ${IMMUTABLEAPIKEY}" \
  --data "$(generate_post_data)"

echo Minting API Call Done


