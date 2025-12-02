# 🚀 SuiSnap

> **On-chain URL shortener** built with Move for the Sui blockchain. A complete educational project that teaches Sui development fundamentals through a practical and progressive application.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Sui](https://img.shields.io/badge/Built%20on-Sui-6fbcf0)](https://sui.io)
[![Move](https://img.shields.io/badge/Language-Move-00d4ff)](https://github.com/move-language/move)

**🌐 Languages:** [English](README.md) | [Português](README.pt.md) | [Español](README.es.md)

---

## 📖 About the Project

**SuiSnap** is a decentralized URL shortener that serves as a complete educational pathway to learn **Move** development on the **Sui** blockchain. Each shortened link becomes an autonomous object on Sui, allowing deep exploration of the platform's unique object model.

### 🎯 Educational Purpose

This project is not intended to compete with commercial URL shorteners, but rather to demonstrate in a practical and organized way the main concepts of Sui architecture:

- ✅ On-chain object creation and management
- ✅ Ownership and permission manipulation
- ✅ Capabilities for access control
- ✅ Event emission for auditing
- ✅ Best practices in Move modeling

---

## 🔄 Quick Reference: Layman's Terms → Move/Sui

A quick mapping of everyday concepts to Sui/Move terminology to help beginners understand the codebase:

| 🧑‍💼 **Layman's Term** | 🔧 **Move/Sui Equivalent** | 📝 **Explanation** |
|----------------------|---------------------------|-------------------|
| **Owner** | `owner: address` | The address that owns the object and can move/transfer it according to the contract rules |
| **Object ID** | `UID` / `ID` | Unique global identifier for objects with `has key` - like a social security number for blockchain objects |
| **Permission Card** | `Capability` / `EditCap` | A proof object that authorizes specific actions (like editing/deleting a Link) - think of it as a key card |
| **Sender** | `tx_context::sender` | The address that signed and sent the transaction - the "who" behind each action |
| **Event** | `LinkCreated` / `LinkUpdated` / `LinkDeleted` | Public receipt of an action, permanently recorded on-chain and queryable via Explorer/CLI - like a transaction log |
| **Entry Function** | `public entry fun` | User-facing function that validates rules and aborts if violated - the "front door" to your contract |

### 💡 Quick Tips

- **UID vs ID**: `UID` is created when the object is born, `ID` is derived from it and used for references
- **Capability Pattern**: Instead of checking global state, Sui uses transferable proof objects (capabilities) for authorization
- **Events are Immutable**: Once emitted, events are permanent and can be queried forever - perfect for auditing

---

## ✨ Features

- 🔷 **Programmable Object Model**: Each link is an on-chain object with unique UID
- 🔐 **Capabilities Pattern**: Secure authorization system without global variables
- 📡 **On-chain Events**: Complete auditing with `LinkCreated`, `LinkUpdated`, `LinkDeleted`
- ✅ **Robust Validation**: URL and short code validation
- 🧪 **Complete Tests**: Unit test coverage with success and failure cases
- 📚 **Complete Documentation**: Detailed handbook and step-by-step modules
- 🌐 **Front-end Ready**: Prepared for Sui dApp Kit integration

---

## 📚 Educational Pathway Structure

The project is organized into **8 progressive modules**, each covering essential aspects of Sui development:

| Module | Topic | Description |
|--------|-------|-------------|
| **0** | Setup and Publishing | Environment, Sui CLI, build, tests and package publishing |
| **1** | Programmable Object Model | `Link` object (UID, owner, short_code), mutability, transfers |
| **2** | Ownership and Authorization | `tx_context::sender`, capabilities (`EditCap`), address-based restrictions |
| **3** | Move Modeling | URL/shortcode validation, custom errors, best practices |
| **4** | Events and Auditing | `LinkCreated/Updated/Deleted` events, CLI/Explorer queries |
| **5** | Automated Tests | `sui move test`, happy paths and `#[expected_failure]` |
| **6** | Front-end (Sui dApp Kit) | moveCall, list objects, React/Next.js integration |
| **7** | Advanced Extensions | Dynamic fields, NFT, hashing, expiration, SUI payments |

📖 **Detailed documentation**: Each module has a specific README in `docs/modulo-*/README.md`  
📘 **Complete handbook**: Available in three languages:
  - [`handbook.en.md`](handbook.en.md) (English)
  - [`apostila.pt.md`](apostila.pt.md) (Português)
  - [`apostila.es.md`](apostila.es.md) (Español)

---

## 🚀 Quick Start

### Prerequisites

- [Sui CLI](https://docs.sui.io/build/install) installed and configured
- Environment configured (devnet or localnet)
- (Optional) Node.js for front-end development

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/SilvaCleverson/SuiSnap.git
   cd SuiSnap
   ```

2. **Build the package**
   ```bash
   sui move build
   ```

3. **Run tests**
   ```bash
   sui move test
   ```

4. **Publish to devnet** (after configuring your wallet)
   ```bash
   sui client publish --gas-budget 500000000 --skip-fetch-latest-gas-price .
   ```
   ⚠️ **Important**: Note the returned `packageId` to use in contract calls.

---

## 💻 Usage

### Create a Shortened Link

```bash
sui client call \
  --package <PACKAGE_ID> \
  --module suisnap \
  --function create_link \
  --args "vector<u8>:https://example.com" "vector<u8>:abc" \
  --gas-budget 20000000
```

### Update a Link

```bash
sui client call \
  --package <PACKAGE_ID> \
  --module suisnap \
  --function update_link \
  --args object:<LINK_ID> object:<EDIT_CAP_ID> \
    "vector<u8>:https://new.com" "vector<u8>:new" \
  --gas-budget 20000000
```

### Query Events

```bash
# Creation events
sui client query-events \
  --move-event-struct <PACKAGE_ID>::suisnap::LinkCreated

# Update events
sui client query-events \
  --move-event-struct <PACKAGE_ID>::suisnap::LinkUpdated
```

### List User Objects

```bash
sui client objects --owner <YOUR_ADDRESS>
```

---

## 📁 Project Structure

```
SuiSnap/
├── Move.toml              # Move package manifest
├── sources/
│   └── suisnap.move       # Main contract module
├── tests/
│   └── suisnap_tests.move # Unit tests
├── handbook.en.md         # Complete handbook (English)
├── apostila.pt.md         # Apostila completa (Português)
├── apostila.es.md         # Manual completo (Español)
├── docs/
│   ├── apostila.html      # Handbook (HTML)
│   ├── README.md          # Documentation index
│   └── modulo-*/          # Module documentation
├── LICENSE                # MIT License
└── README.md              # This file
```

---

## 🧪 Testing

The project includes a complete test suite covering:

- ✅ Link creation
- ✅ Link updates
- ✅ Permission validation
- ✅ Error handling (`E_NOT_OWNER`, `E_LINK_CAP_MISMATCH`)
- ✅ Read functions (`get_url`, `get_short_code`, `get_owner`)

Run tests:

```bash
# All tests
sui move test

# Filtered tests
sui move test --filter suisnap

# Verbose output
sui move test --verbose
```

---

## 📖 Documentation

- **📘 Complete Handbook**: Available in three languages:
  - [`handbook.en.md`](handbook.en.md) - English
  - [`apostila.pt.md`](apostila.pt.md) - Português
  - [`apostila.es.md`](apostila.es.md) - Español
- **📚 Individual Modules**: Specific documentation in `docs/modulo-*/README.md`
- **🌐 HTML Version**: [`docs/apostila.html`](docs/apostila.html) - Web-formatted handbook
- **📄 PDF**: [`docs/Apostila LinkPass Sui - Guia de Desenvolvimento.pdf`](docs/Apostila%20LinkPass%20Sui%20-%20Guia%20de%20Desenvolvimento.pdf)

---

## 🛠️ Technologies

- **Move**: Sui smart contract language
- **Sui Blockchain**: High-performance blockchain platform
- **Sui CLI**: Command-line tools
- **Sui dApp Kit**: (Optional) For front-end integration

---

## 🗺️ Roadmap

- [ ] Advanced URL and short code validation
- [ ] Click counter with `ClickRegistered` event
- [ ] Complete front-end with Sui dApp Kit
- [ ] Dynamic fields for metadata
- [ ] Link expiration system
- [ ] SUI payment mechanism

---

## 🤝 Contributing

Contributions are welcome! Feel free to:

1. Fork the project
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🔗 Useful Links

- [Official Sui Documentation](https://docs.sui.io)
- [Sui Repository](https://github.com/MystenLabs/sui)
- [Sui Explorer](https://suiexplorer.com)
- [Sui Discord Community](https://discord.gg/sui)

---

## 👤 Author

**SilvaCleverson**

- GitHub: [@SilvaCleverson](https://github.com/SilvaCleverson)
- Project: [SuiSnap](https://github.com/SilvaCleverson/SuiSnap)

---

## ⭐ Acknowledgments

- Sui community for the excellent ecosystem
- Mysten Labs for the innovative platform
- All contributors and learners who use this project

---

<div align="center">

**Made with ❤️ for the Sui community**

⭐ If this project was useful to you, consider giving it a star!

</div>
