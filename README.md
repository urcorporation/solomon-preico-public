### Introduction

Ethereum smartcontracts are used to collect and store funds and mint tokens. Smartcontracts also handle ERC20-related trasactions and enforce control spending of collected funds (using a multisignature wallet).

### Mechanics of smartcontracts

Investors send Ethereum to the address of SolomonCrowdSale smartcontract, published on the website of Solomon Money project. All funds are collected and held by RefundVault smartcontract.

If goal is reached, RefundVault smartcontract transfer collected funds to MultiSigWallet smartcontract, controlled by Solomon Money core team members. Also, remaining 35% SLMN tokens are minted for the team, advisors and bounty. All funds and tokens owned by the team are controlled via MultiSigWallet smartcontract. Approval of 2 out of 3 members of core team is required for any transaction with these assets.

If goal is not reached, funds remain locked in RefundVault smartcontract. Investors can ask and get back their investments.

### Parameters of SolomonCrowdsale smartcontract

* startTime = January 23, 2018
* endTime = February 23, 2018
* rate = 20000 (20000 SLMN for 1 ETH; 1 SLMN ~ $0.05)
* decimals = 18 (each SLMN token is divisible by 1'000'000'000'000'000)
* cap = 650'000'000 ETH (total supply is limited to 1'000'000'000 tokens, we mint 65% of total supply)
* goal = 500 ETH (minimum amount to gather or investors will be refunded)

| Smartcontract  | Functionality | Origin |
| ------- | ----------- | --- | 
| SolomonCrowdSale | Receives ETH and stashes it in RefundVault. | Extension of Zeppelin's RefundableCrowdsale.sol. |
| RefundVault | Stores funds, tracks investor's addresses and amounts. If goal is reached, transfers funds to MultiSigWallet or handles refunds. | Unmodified Zeppelin's RefundVault.sol |
| SolomonToken | Mints SLMN tokens, tracks token balance balance per investor. ERC20-compliant token. | Extension of Zeppelin's MintableToken.sol. |
| MultiSigWallet | Receives ETH if goal is reached. Requires at least two signatures for any transaction. | Unmodified Gnosis MultiSigWallet.sol. |

