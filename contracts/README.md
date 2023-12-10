This is the set of smart contracts managing the Lenft lending protocol.

The Lender contract caters to two actors, as well as the general public.

Lender can:
  * call createOffer to create an offer on a loan
  * call cancelOffer to cancel an offer
  * call claimNFT (only when/if a loan expires)

Borrower can:
  * call listNft to list an NFT on the platform
  * call delistNft to delist an NFT
  * call acceptOffer to accept an offer
  * call repayLoan to repay a loan at any point in time

Anyone can:
  * see all the NFTs listed on the platform
  * see all the offers currently active

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Deploy

Two contracts (Lender.sol and Famcnft.sol) need to be deployed using your preferred method. The below examples are for using Foundry.
Note that Lender.sol takes an argument in the constructor to represent the address of the ERC20 stablecoin to use. 

For FXD they are:
* mainnet: 0x49d3f7543335cf38fa10889ccff10207e22110b5
* testnet: 0xDf29cB40Cb92a1b8E8337F542E3846E185DefF96

```shell
$ forge create <contract> --rpc-url <your_rpc_url> --private-key <your_private_key> --legacy

$ forge create Famcnft --rpc-url=https://erpc.apothem.network --private-key= --legacy
$ forge create Lender --rpc-url=https://erpc.apothem.network --private-key= --legacy --constructor-args=0xDf29cB40Cb92a1b8E8337F542E3846E185DefF96
```
