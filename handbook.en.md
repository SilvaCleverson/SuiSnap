# 🚀 SuiSnap

**Development Guide in Move for Sui Blockchain**

---

## 📖 Introduction

Welcome to the handbook on **Move** development on the **Sui** blockchain! This practical guide was created to help you learn how to build decentralized applications (dApps) using the SuiSnap project as an example.

Through the **SuiSnap** project — an on-chain URL shortener — you will learn the fundamental concepts of the Sui ecosystem in a practical and incremental way. By the end of this journey, you will have the knowledge to model objects, implement authorization, emit events, write tests, and integrate with front-end.

> **🎯 SuiSnap's Educational Purpose**
>
> The idea is not to compete with commercial URL shorteners, but to create an educational project that demonstrates, in a practical and organized way, the main concepts of Sui architecture:
>
> - On-chain object creation and management
> - Ownership and permission manipulation
> - Use of capabilities for access control
> - Event emission for auditing
> - Best practices in Move modeling
>
> Each shortened link becomes an autonomous object on Sui, allowing deep exploration of its object model — which is precisely the academic differentiator of the platform. It is a simple project in concept, but very rich technically, suitable for demonstrating mastery of Sui/Move, Web3 architecture, and secure blockchain development.

> **🔷 Why Move and Sui?**
>
> Move is a smart contract language designed specifically for memory safety and Sui's unique object model. Unlike account-based blockchains (like Ethereum), Sui uses a **Programmable Object Model** that allows greater flexibility, scalability, and security.

---

## 🎓 What You Will Learn

The SuiSnap project has been structured to cover the main technical aspects of Sui progressively. Each module builds on the previous one, allowing gradual and practical understanding of concepts.

### 🔧 1. Programmable Object Model (Sui Core)

**Learning objectives:**

- Object creation using `has key`
- On-chain persistence via `UID`
- Controlled object mutability
- Object transfer between addresses
- Stateful data structuring

Each shortened link becomes an on-chain object, demonstrating how Sui differs from account-based blockchains. You will understand in practice the object model that is the platform's differentiator.

### 🔑 2. Ownership and Authorization

**Learning objectives:**

- Use of `tx_context::sender` for identification
- Address-based access restriction
- Capabilities for editing/deleting links (`EditCap`)
- Authorization patterns without global variables
- Permission validation before critical operations

You will learn how Sui Move implements security without relying on `require` or `if` in the EVM style, using the capability system for granular and secure access control.

### 🏛️ 3. Move Modeling

**Learning objectives:**

- Structs with `vector<u8>` to represent strings
- `entry` functions for transactions
- Proper organization of modules and imports
- Manipulation of native Move types
- Input validation and error handling
- Sui-specific design best practices

You will learn Move in a contextualized way, applying language concepts in a real project, understanding when and how to use each language feature.

### 📡 4. Event Emission and Indexing

**Learning objectives:**

- Move event structuring (`LinkCreated`, `LinkUpdated`, `LinkDeleted`)
- Event emission in critical operations
- Audit and traceability patterns
- Indexing via Sui Explorer and Indexer
- Event queries via CLI and APIs

Contract observability is essential in production but is often neglected. You will learn to implement a complete event system that allows auditing and monitoring of operations.

### 🧪 5. Automated Tests in Move

**Learning objectives:**

- Unit tests with `sui move test`
- Object creation and mutation tests
- Permission checking and expected failures
- Use of `#[expected_failure]` to test aborts
- Event emission validation
- Abort code interpretation

The project serves as a laboratory to teach TDD (Test-Driven Development) in Move, covering both success paths and expected failure cases.

### 🌐 6. Front-end Integration (Sui dApp Kit)

**Learning objectives:**

- Sui dApp Kit setup with React/Next.js
- Wallet connection and authentication
> - `moveCall` calls to contract functions
- On-chain object rendering in the front-end
- Conversion between `vector<u8>` and readable strings
- UX patterns for Sui dApps

You will learn to create a complete interface that interacts with your contract, forming a solid foundation for full-stack Web3 development.

### 🔮 7. Advanced Extensions (Optional)

**Advanced concepts to explore:**

- **Dynamic Fields:** Add dynamic metadata to links
- **Link NFT:** Transform each link into a unique NFT
- **URL Hashing:** Implement privacy through hashing
- **Expiration:** Use clock oracle for links with validity period
- **SUI Payment:** Charging mechanism for link creation
- **Granular Capabilities:** Different permission levels (read, edit, delete)

This modular progression makes the project suitable for different levels of depth, allowing more experienced students to explore advanced features of the Sui platform.

> **💼 Project Value**
>
> With this, SuiSnap becomes an excellent portfolio piece and a solid academic experiment for modern blockchain studies, demonstrating technical mastery without the complexity of financial or commercial cases. It is a simple project in concept, but very rich technically.

---

## 🗺️ Journey Map

- 📦 [Module 0 - Setup and Publishing](#module-0---setup-and-publishing)
- 🔷 [Module 1 - Programmable Object Model](#module-1---programmable-object-model)
- 🔐 [Module 2 - Ownership and Authorization](#module-2---ownership-and-authorization)
- 🏗️ [Module 3 - Move Modeling](#module-3---move-modeling)
- 📢 [Module 4 - Events and Auditing](#module-4---events-and-auditing)
- 🧪 [Module 5 - Automated Tests](#module-5---automated-tests)
- 💻 [Module 6 - Front-end (Sui dApp Kit)](#module-6---front-end-sui-dapp-kit)
- ⚡ [Module 7 - Advanced Extensions](#module-7---advanced-extensions)

---

## Module 0 - Setup and Publishing

**✅ Objective:** Set up your development environment and publish your first Move package on Sui.

### 📋 Prerequisites

- Basic programming knowledge
- Basic Terminal/CLI
- Internet access

### 🔧 Sui CLI Installation

First, let's install the Sui CLI. Choose the appropriate method for your operating system:

**Linux/macOS (via curl):**

```bash
curl -fsSL https://get.sui.io | sh
```

**Windows (via PowerShell):**

```powershell
irm https://get.sui.io | iex
```

### 🎯 Initial Configuration

1. **Create a new address:**
   ```bash
   sui client new-address ed25519
   ```

2. **Choose environment (devnet recommended for testing):**
   ```bash
   sui client switch --env devnet
   ```

3. **Get test tokens (if needed):**
   ```bash
   sui client faucet
   ```

### 📦 Compilation and Tests

In the SuiSnap project directory:

```bash
# Compile the package
sui move build

# Run tests
sui move test

# Run tests with filter
sui move test --filter suisnap
```

### 🚀 Package Publishing

To publish your package to devnet:

```bash
sui client publish --gas-budget 500000000 --skip-fetch-latest-gas-price .
```

> **⚠️ Important:** Note the `packageId` returned after publishing. You will need it in the following modules to make contract calls and integrate with the front-end.

### ✅ Verification

Verify that your package was published correctly:

```bash
# List objects from your address
sui client objects --owner <YOUR_ADDRESS>

# Inspect a specific object
sui client object --id <OBJECT_ID>
```

---

## Module 1 - Programmable Object Model

**✅ Objective:** Understand how objects work on Sui through modeling the `Link` struct.

### 🎯 Fundamental Concepts

On Sui, everything is an **object**. Unlike account-based blockchains, where state is stored in global variables, on Sui each piece of data is an independent object with its own **UID** (Unique Identifier).

### 📝 Link Structure

Let's examine the basic structure of our `Link` object:

```move
struct Link has key {
    id: UID,
    owner: address,
    original_url: vector<u8>,
    short_code: vector<u8>,
}
```

**Important components:**

- `has key`: Allows the struct to be an on-chain object
- `UID`: Unique identifier of the object on the blockchain
- `owner`: Address that owns the object
- `vector<u8>`: Represents strings in Move (bytes)

### 🔨 Creating a Link

To create a link via CLI:

```bash
sui client call \
  --package <PACKAGE_ID> \
  --module suisnap \
  --function create_link \
  --args "https://example.com" "example" \
  --gas-budget 10000000
```

### 🔍 Inspecting Objects

```bash
# List all objects from your address
sui client objects --owner <YOUR_ADDRESS>

# View details of a specific object
sui client object --id <LINK_ID> --json
```

### 💡 Practical Exercise

> **Challenge:** Add a `clicks: u64` field to the `Link` struct and create an `entry register_click` function that increments this counter. Optionally, emit a `ClickRegistered` event when the counter is incremented.

---

## Module 2 - Ownership and Authorization

**✅ Objective:** Implement secure access control using capabilities, without global variables.

### 🔐 The Capability Pattern

On Sui, we don't use global variables for access control. Instead, we use **capabilities** — special objects that represent permissions. In SuiSnap, we use `EditCap` to control who can edit a link.

```move
struct EditCap has key {
    id: UID,
    link_id: ID,
    owner: address,
}
```

### 🛡️ Authorization Function

The `enforce_access` function checks two things:

1. The capability owner is the one trying to use it
2. The capability belongs to the correct link

```move
fun enforce_access(link: &Link, cap: &EditCap, actor: address) {
    if (cap.owner != actor) {
        abort E_NOT_OWNER
    };
    if (cap.link_id != object::id(link)) {
        abort E_LINK_CAP_MISMATCH
    };
}
```

### ✏️ Updating a Link

```bash
sui client call \
  --package <PACKAGE_ID> \
  --module suisnap \
  --function update_link \
  --args <LINK_OBJECT_ID> <EDIT_CAP_OBJECT_ID> "https://new-url.com" "new-code" \
  --gas-budget 10000000
```

### 🧪 Testing Authorization Failures

> **Security Test:**
> 1. Transfer the `EditCap` to another address
> 2. Try to update the link with the transferred capability
> 3. Observe the abort code `E_NOT_OWNER`

### 💡 Practical Exercise

> **Challenge:** Implement a `transfer_edit_cap` function that allows transferring the capability to another address. Add validation to prevent unauthorized transfers (error `E_CAP_TRANSFER_NOT_ALLOWED`) and test the behavior.

---

## Module 3 - Move Modeling

**✅ Objective:** Create secure, readable, and well-structured Move APIs with proper validation.

### ✅ Data Validation

It is essential to validate all user inputs. Let's implement validations for:

- **URL:** Must start with `http://` or `https://`
- **Short Code:** Must be alphanumeric, with size between 1 and 50 characters
- **Maximum Size:** URLs cannot exceed 2048 characters

### 📏 Validation Constants

```move
const MAX_URL_LENGTH: u64 = 2048;
const MAX_SHORT_CODE_LENGTH: u64 = 50;
const MIN_SHORT_CODE_LENGTH: u64 = 1;

const E_INVALID_URL: u64 = 3;
const E_INVALID_SHORT_CODE: u64 = 4;
```

### 🔍 URL Validation Function

```move
fun validate_url(url: &vector<u8>): bool {
    let len = vector::length(url);
    if (len > MAX_URL_LENGTH || len == 0) {
        return false
    };
    // Check if it starts with http:// or https://
    // ... implementation ...
}
```

### 📖 Read Functions

Expose public functions for safe data reading:

```move
public fun get_url(link: &Link): vector<u8> {
    clone_vector(&link.original_url)
}

public fun get_short_code(link: &Link): vector<u8> {
    clone_vector(&link.short_code)
}

public fun get_owner(link: &Link): address {
    link.owner
}
```

### 💡 Practical Exercises

- **Sanitization:** Implement a function that removes whitespace and special characters from the short code
- **Size Limit:** Add validation to ensure the short code does not exceed the maximum size
- **Helper Functions:** Create helper functions to convert between `vector<u8>` and readable strings

---

## Module 4 - Events and Auditing

**✅ Objective:** Make all transactions observable and auditable through events.

### 📢 Event Structure

Events on Sui must have the `copy` and `drop` abilities:

```move
struct LinkCreated has copy, drop {
    link_id: ID,
    owner: address,
    short_code: vector<u8>,
}

struct LinkUpdated has copy, drop {
    link_id: ID,
    owner: address,
    short_code: vector<u8>,
}

struct LinkDeleted has copy, drop {
    link_id: ID,
    owner: address,
}
```

### 🎯 Emitting Events

```move
public entry fun create_link(...) {
    // ... link creation ...
    event::emit(LinkCreated {
        link_id,
        owner: sender,
        short_code: clone_vector(&link.short_code),
    });
}
```

### 🔍 Querying Events

**Via CLI:**

```bash
# Query events of type LinkCreated
sui client query-events \
  --move-event-struct <PACKAGE_ID>::suisnap::LinkCreated

# Filter by sender
sui client query-events \
  --move-event-struct <PACKAGE_ID>::suisnap::LinkCreated \
  --sender <ADDRESS>
```

**Via Sui Explorer:**

Visit `https://suiexplorer.com` and navigate to your package to see all emitted events.

### 💡 Practical Exercises

- **Truncated URL:** Include the first 50 characters of the URL in the `LinkCreated` event to facilitate auditing
- **Multiple Owners:** Create an audit system that compares events from different owners and generates reports
- **Click Event:** If you implemented the click counter, emit a `ClickRegistered` event on each click

---

## Module 5 - Automated Tests

**✅ Objective:** Ensure code quality and reliability through comprehensive tests.

### 🧪 Test Structure

Tests in Move use the `test_scenario` API to simulate transactions:

```move
#[test]
fun create_sets_owner_and_cap_link_id() {
    let owner = @0xA;
    let scenario = test_scenario::begin(owner);
    {
        let ctx = test_scenario::ctx(&mut scenario);
        let (link, cap) = suisnap::create_link_internal(owner, b"https://sui.io", b"sui", ctx);
        assert!(suisnap::owner(&link) == owner, 0);
        assert!(suisnap::link_id(&cap) == object::id(&link), 0);
        suisnap::delete_link_internal(link, cap, owner);
    };
    test_scenario::end(scenario);
}
```

### ❌ Testing Expected Failures

```move
#[test]
#[expected_failure(abort_code = suisnap::E_NOT_OWNER)]
fun update_rejects_wrong_owner() {
    let owner = @0xC;
    let scenario = test_scenario::begin(owner);
    {
        let ctx = test_scenario::ctx(&mut scenario);
        let (link, cap) = suisnap::create_link_internal(owner, b"https://url", b"code", ctx);
        // This call should fail
        suisnap::update_link_internal(&mut link, &cap, @0xD, b"https://fail", b"bad");
    };
    test_scenario::end(scenario);
}
```

### 🚀 Running Tests

```bash
# Run all tests
sui move test

# Run tests with filter
sui move test --filter suisnap

# Run with detailed output
sui move test --verbose
```

### 📊 Interpreting Abort Codes

| Code | Constant | Meaning |
|------|----------|---------|
| 1 | `E_NOT_OWNER` | The address is not the capability owner |
| 2 | `E_LINK_CAP_MISMATCH` | The capability does not belong to the link |
| 3 | `E_INVALID_URL` | The URL is not valid |
| 4 | `E_INVALID_SHORT_CODE` | The short code is not valid |

### 💡 Practical Exercises

- **Capability Test:** Write a test that verifies `E_LINK_CAP_MISMATCH` when a capability from one link is used on another
- **Validation Test:** Create tests for invalid URLs and invalid short codes
- **Complete Coverage:** Ensure all code paths are covered by tests

---

## Module 6 - Front-end (Sui dApp Kit)

**✅ Objective:** Create a functional web interface that interacts with your Move contract.

### ⚙️ Initial Setup

**Dependency Installation:**

```bash
npm install @mysten/dapp-kit @mysten/sui.js @tanstack/react-query
```

**Provider Configuration:**

```typescript
import { SuiClientProvider, WalletProvider } from '@mysten/dapp-kit';
import { getFullnodeUrl } from '@mysten/sui.js/client';

function App() {
  return (
    <SuiClientProvider networks={{
      devnet: { url: getFullnodeUrl('devnet') }
    }}>
      <WalletProvider>
        {/* Your app here */}
      </WalletProvider>
    </SuiClientProvider>
  );
}
```

### 🔌 Connecting Wallet

```typescript
import { useWallet } from '@mysten/dapp-kit';

function ConnectButton() {
  const { currentWallet, connect, disconnect } = useWallet();
  
  if (currentWallet) {
    return (
      <div>
        <p>Connected: {currentWallet.name}</p>
        <button onClick={disconnect}>Disconnect</button>
      </div>
    );
  }
  
  return <button onClick={connect}>Connect Wallet</button>;
}
```

### 📞 Making moveCall Calls

```typescript
import { useSignAndExecuteTransaction } from '@mysten/dapp-kit';

function CreateLink() {
  const { mutate: signAndExecute } = useSignAndExecuteTransaction();
  const PACKAGE_ID = '0x...'; // Your package ID
  
  const handleCreate = () => {
    signAndExecute({
      transaction: {
        kind: 'moveCall',
        data: {
          packageObjectId: PACKAGE_ID,
          module: 'suisnap',
          function: 'create_link',
          arguments: [
            'https://example.com',
            'example'
          ],
        },
      },
    });
  };
  
  return <button onClick={handleCreate}>Create Link</button>;
}
```

### 📋 Listing Objects

```typescript
import { useSuiClientQuery } from '@mysten/dapp-kit';

function MyLinks() {
  const { data, isLoading } = useSuiClientQuery('getOwnedObjects', {
    owner: currentAccount?.address,
    filter: { StructType: `${PACKAGE_ID}::suisnap::Link` },
  });
  
  if (isLoading) return <p>Loading...</p>;
  
  return (
    <ul>
      {data?.data.map((obj) => (
        <li key={obj.data.objectId}>
          {obj.data.objectId}
        </li>
      ))}
    </ul>
  );
}
```

### 💡 Practical Exercises

- **Copy Button:** Implement a button that copies the short code to the clipboard
- **Open URL:** Create a button that opens the original URL in a new tab
- **Recent Events:** Display the latest link creation/update events in real-time

---

## Module 7 - Advanced Extensions

**✅ Objective:** Explore advanced Sui features to create a complete and professional dApp.

### 🔗 Dynamic Fields

Use dynamic fields to add extra metadata to links without modifying the main struct:

```move
use sui::dynamic_object_field as ofield;

public fun add_metadata(link: &mut Link, key: vector<u8>, value: vector<u8>) {
    ofield::add(&mut link.id, key, value);
}
```

### 🎨 Link NFT

Transform each link into a unique NFT with visual metadata:

```move
struct LinkNFT has key, store {
    id: UID,
    link_id: ID,
    image_url: vector<u8>,
    description: vector<u8>,
}
```

### ⏰ Link Expiration

Use the Clock Oracle to implement automatic expiration:

```move
use sui::clock::{Self, Clock};

struct Link has key {
    // ... existing fields ...
    expires_at: u64,
}

public fun is_expired(link: &Link, clock: &Clock): bool {
    clock::timestamp_ms(clock) > link.expires_at
}
```

### 💰 SUI Charging

Implement charging for link creation:

```move
use sui::coin::{Self, Coin};
use sui::sui::SUI;

public entry fun create_link_with_payment(
    payment: Coin<SUI>,
    original_url: vector<u8>,
    short_code: vector<u8>,
    ctx: &mut TxContext
) {
    let amount = coin::value(&payment);
    assert!(amount >= 1000000000, E_INSUFFICIENT_PAYMENT); // Minimum 1 SUI
    // ... create link ...
    coin::burn(payment);
}
```

### 📊 State Diagram

**Link State Flow:**
`Created` → `Updated` → `Deleted`

**Error States:**
- `E_NOT_OWNER`: Unauthorized access attempt
- `E_LINK_CAP_MISMATCH`: Incorrect capability
- `E_INVALID_URL`: Invalid URL
- `E_INVALID_SHORT_CODE`: Invalid short code
- `E_EXPIRED`: Expired link (if implemented)

### 💡 Practical Exercises

- **Payment Split:** Implement a system where part of the payment goes to the creator and part to a development fund
- **Click Event:** Emit detailed events when a link is accessed, including timestamp and accessor address
- **Renewal:** Allow users to renew expired links by paying a fee

---

## 🎉 Conclusion

**Congratulations!** If you followed this handbook to the end, you now have:

- ✅ A Move package published and fully tested on the Sui blockchain
- ✅ A functional front-end integrated with Sui dApp Kit
- ✅ Deep knowledge of authorization patterns, events, and tests
- ✅ Practical experience with advanced Sui platform features

### 🚀 Next Steps

- Explore other projects on Sui to see different design patterns
- Participate in the Sui community on Discord and forums
- Contribute open-source code to Sui projects
- Build your own dApp using the knowledge acquired

### 📚 Additional Resources

- [Official Sui Documentation](https://docs.sui.io)
- [Sui GitHub Repository](https://github.com/MystenLabs/sui)
- [Sui Explorer](https://suiexplorer.com)
- [Discord Community](https://discord.gg/sui)

---

**© 2024 SuiSnap - Development Guide**

Developed with ❤️ for the Sui community

