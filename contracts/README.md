This is the set of smart contracts managing the Lenft lending protocol.

The Lender contract caters to two actors.

Lender can:
  * call createOffer to create an offer on a loan
  * call claimNFT (only when/if a loan expires)

Borrower flow:
  * call acceptOffer to accept an offer
  * call repayLoan to repay a loan


## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

```shell
$ forge create Lender.sol --rpc-url <your_rpc_url> --private-key <your_private_key>
```
