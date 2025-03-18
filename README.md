## Champz Example Deploy Script

## Usage

### Build

```shell
$ forge build
```

### Deploy

Not that deploy.sh needs small modifications to switch between mainnet and testnet. It also has instructions if deploying using a Ledger hardware wallet.

```shell
$ export PKEY=<your key>
$ export APIKEY=<your blockscout test net or mainnet API key>
$ sh deploy.sh
```



### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
