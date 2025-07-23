# 🚨 Drosera Spike Detection PoC

This repo contains a working Proof-of-Concept for detecting ERC20 transfer spikes on the [Drosera Network](https://drosera.network) using a custom trap and response contract.

## 🔧 Components
- Trap Contract: Monitors ERC20 transfers for sudden spikes
- Response Contract: Returns volume context for alerts
- Network: [Hoodi Testnet](https://hoodi.etherscan.io/)

## 📜 Deployed Contracts
- Trap: [0x8551...599C](https://hoodi.etherscan.io/address/0x85515427C38213951B1f0D62e6bc8D4E0e2E599C)
- Response: [0x7788...7D41](https://hoodi.etherscan.io/address/0x7788749c85306f989393ba7b4A7DDA6920657D41)

## 🛠 Tools Used
- Foundry: https://book.getfoundry.sh/
- Drosera CLI: https://github.com/drosera-network/cli
- Solidity 0.8.x

## 🧪 Usage
forge build  
forge test  
drosera apply
