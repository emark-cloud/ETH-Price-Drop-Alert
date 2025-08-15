# PriceDropTrap (Drosera Compatible)

A minimal Drosera Trap that triggers when ETH/USD falls below a threshold using a Chainlink-style price feed.

## How it works
- `collect()` reads the latest price from a hardcoded aggregator address (`PRICE_FEED`).
- `shouldRespond()` triggers if `price < MIN_PRICE` (both use 8 decimals).

## Files
- `src/PriceDropTrap.sol` — the trap
- `src/PriceDropResponse.sol` — the response/handler
- `test/PriceDropTrap.t.sol` — unit tests
- `foundry.toml` — Foundry config
- `drosera.toml` — Drosera wiring (trap + response)
- `lib/` — install dependencies here

## Quickstart

```bash
# Install Foundry if needed
curl -L https://foundry.paradigm.xyz | bash
foundryup

# Init deps
forge install drosera-network/drosera-contracts
forge install foundry-rs/forge-std

# Run tests
forge test -vv

