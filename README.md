# 🚨 Drosera ERC20 Spike Detection PoC

This repository contains a working Proof-of-Concept for detecting **ERC20 transfer spikes** using [Drosera](https://drosera.network), an onchain monitoring protocol for programmable security.

## 🔧 Components

- **Trap Contract**  
  `ERC20TransferSpikeTrap.sol`  
  → Watches ERC20 transfers and detects large, sudden spikes in volume

- **Response Contract**  
  `ERC20TransferSpikeResponse.sol`  
  → Returns context information (volume/average) to the Drosera runtime

- **Drosera Network**  
  Using `drosera dryrun` to simulate and test spike events on-chain.

## 📜 Deployed Contracts (Hoodi Testnet)

| Type     | Address                                                                 |
|----------|-------------------------------------------------------------------------|
| Trap     | [`0x1C90a8D1...`](https://hoodi.etherscan.io/address/0x1C90a8D1f62D1587B3C46266b21430cF742BeC4e) |
| Response | [`0x7788749c...`](https://hoodi.etherscan.io/address/0x7788749c85306f989393ba7b4A7DDA6920657D41) |

## 🧪 Setup & Usage

```bash
# Clone and install dependencies
git clone https://github.com/EmilyMETH/drosera-spike-poc.git
cd drosera-spike-poc
forge install

# Build & test
forge build
forge test

# Deploy manually (for dryrun)
forge create src/ERC20TransferSpikeResponse.sol:ERC20TransferSpikeResponse \
  --rpc-url https://ethereum-hoodi-rpc.publicnode.com \
  --private-key $PRIVATE_KEY \
  --broadcast

forge create src/ERC20TransferSpikeTrap.sol:ERC20TransferSpikeTrap \
  --rpc-url https://ethereum-hoodi-rpc.publicnode.com \
  --private-key $PRIVATE_KEY \
  --broadcast

# Dryrun
drosera dryrun
```

## 📦 Dependency Pinned

This PoC uses Drosera contracts pinned at commit [`3a89d13`](https://github.com/drosera-network/contracts/commit/3a89d1328300a8f3010e71d03b235808a542bd12) to ensure stable behavior and reproducibility.

The contracts are installed as a Git submodule under `lib/contracts`.
