## Champz Example Deploy Script

# Sequence

* Deploy contract. Note you will need to set-up environment variables.
```
sh script/deploy.sh
```
* Grant Minting API minter role. 
```
sh script/grantMinterRole.sh
```
* Link the contract on Hub.
* If you haven't already, generate an Immutable API key for the project. For Immutable Hub and the minting API, this is project specific.





## Usage

### Build

```shell
$ forge build
```

### Deploy

Not that `script/deploy.sh` needs small modifications to switch between mainnet and testnet. It also has instructions if deploying using a Ledger hardware wallet.

```shell
$ export PKEY=<your key>
$ export APIKEY=<your blockscout test net or mainnet API key>
$ sh script/deploy.sh
```



### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

