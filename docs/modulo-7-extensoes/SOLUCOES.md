# Módulo 7 — Soluções: Extensões Avançadas

## Exercício 1: Dynamic Fields

### Código em `sources/suisnap.move`:

```move
use sui::dynamic_object_field as ofield;

// Adicionar metadata a um link
public entry fun add_metadata(
    link: &mut Link,
    key: vector<u8>,
    value: vector<u8>,
    ctx: &TxContext
) {
    ofield::add(&mut link.id, key, value);
}

// Obter metadata
public fun get_metadata(link: &Link, key: vector<u8>): option<vector<u8>> {
    if (ofield::contains(&link.id, key)) {
        option::some(*ofield::borrow(&link.id, key))
    } else {
        option::none()
    }
}

// Exemplo de uso: adicionar descrição
public entry fun set_description(
    link: &mut Link,
    description: vector<u8>,
    ctx: &TxContext
) {
    add_metadata(link, b"description", description, ctx);
}
```

---

## Exercício 2: EditCap Granular

### Código:

```move
// Capability apenas para URL
struct UrlEditCap has key {
    id: UID,
    link_id: ID,
    owner: address,
}

// Capability apenas para short_code
struct ShortCodeEditCap has key {
    id: UID,
    link_id: ID,
    owner: address,
}

// Função para atualizar apenas URL
public entry fun update_url(
    link: &mut Link,
    cap: &UrlEditCap,
    new_url: vector<u8>,
    ctx: &TxContext
) {
    let actor = tx_context::sender(ctx);
    enforce_url_access(link, cap, actor);
    
    if (!validate_url(&new_url)) {
        abort E_INVALID_URL
    };
    
    link.original_url = new_url;
    event::emit(LinkUpdated { ... });
}

// Função para atualizar apenas short_code
public entry fun update_short_code(
    link: &mut Link,
    cap: &ShortCodeEditCap,
    new_code: vector<u8>,
    ctx: &TxContext
) {
    let actor = tx_context::sender(ctx);
    enforce_code_access(link, cap, actor);
    
    if (!validate_short_code(&new_code)) {
        abort E_INVALID_SHORT_CODE
    };
    
    link.short_code = new_code;
    event::emit(LinkUpdated { ... });
}
```

---

## Exercício 3: NFT do Link

### Código:

```move
use sui::display;

struct LinkNFT has key, store {
    id: UID,
    link_id: ID,
    image_url: vector<u8>,
    description: vector<u8>,
}

// Criar NFT ao criar link
public(friend) fun create_link_with_nft(
    owner: address,
    original_url: vector<u8>,
    short_code: vector<u8>,
    image_url: vector<u8>,
    description: vector<u8>,
    ctx: &mut TxContext
): (Link, EditCap, LinkNFT) {
    let (link, cap) = create_link_internal(owner, original_url, short_code, ctx);
    
    let nft = LinkNFT {
        id: object::new(ctx),
        link_id: object::id(&link),
        image_url,
        description,
    };
    
    (link, cap, nft)
}
```

**Observação:** O NFT pode ser transferido independentemente do Link, demonstrando a flexibilidade do modelo de objetos da Sui.

---

## Exercício 4: Privacidade com Hash

### Código:

```move
use sui::hash;

struct Link has key {
    id: UID,
    owner: address,
    url_hash: vector<u8>,  // Hash da URL
    short_code: vector<u8>,
}

// Criar link com hash
public entry fun create_link_private(
    url_hash: vector<u8>,
    short_code: vector<u8>,
    ctx: &mut TxContext
) {
    // Validar que o hash tem tamanho correto (32 bytes para SHA3-256)
    assert!(vector::length(&url_hash) == 32, E_INVALID_HASH);
    
    // ... criar link com hash ...
}

// Validar hash off-chain
// No front-end ou backend:
// const hash = sha3_256(url);
// Chamar create_link_private com o hash
```

---

## Exercício 5: Expiração com Clock Oracle

### Código:

```move
use sui::clock::{Self, Clock};

struct Link has key {
    // ... campos existentes ...
    expires_at: u64,
}

const E_EXPIRED: u64 = 8;

public fun is_expired(link: &Link, clock: &Clock): bool {
    clock::timestamp_ms(clock) > link.expires_at
}

public entry fun update_link(
    link: &mut Link,
    cap: &EditCap,
    new_url: vector<u8>,
    new_short_code: vector<u8>,
    clock: &Clock,
    ctx: &TxContext
) {
    if (is_expired(link, clock)) {
        abort E_EXPIRED
    };
    
    // ... resto da lógica ...
}
```

---

## Exercício 6: Pagamento em SUI

### Código:

```move
use sui::coin::{Self, Coin};
use sui::sui::SUI;
use sui::balance;

const MIN_PAYMENT: u64 = 1000000000; // 1 SUI
const E_INSUFFICIENT_PAYMENT: u64 = 9;

// Cofre para acumular pagamentos
struct Treasury has key {
    id: UID,
    balance: Balance<SUI>,
}

public entry fun create_link_with_payment(
    payment: Coin<SUI>,
    original_url: vector<u8>,
    short_code: vector<u8>,
    treasury: &mut Treasury,
    ctx: &mut TxContext
) {
    let amount = coin::value(&payment);
    assert!(amount >= MIN_PAYMENT, E_INSUFFICIENT_PAYMENT);
    
    // Adicionar ao cofre
    balance::join(&mut treasury.balance, coin::into_balance(payment));
    
    // Criar link normalmente
    let sender = tx_context::sender(ctx);
    let (link, cap) = create_link_internal(sender, original_url, short_code, ctx);
    
    // ... transferir objetos ...
}

// Sacar do cofre (apenas owner)
public entry fun withdraw_treasury(
    treasury: &mut Treasury,
    amount: u64,
    ctx: &mut TxContext
) {
    let sender = tx_context::sender(ctx);
    // Verificar se é o owner (precisa de capability ou verificação)
    
    let coins = balance::split(&mut treasury.balance, amount);
    transfer::public_transfer(coins, sender);
}
```

---

## Exercício 7: Diagrama de Estados

### Estados do Link:

```
[Criado]
  │
  ├─→ [Atualizado] ─→ [Atualizado] ─→ ...
  │
  └─→ [Deletado] (FINAL)
```

### Transições:

- **Criar**: `create_link` → Estado: `Criado`
- **Atualizar**: `update_link` → Estado: `Atualizado`
- **Deletar**: `delete_link` → Estado: `Deletado` (final)

### Erros:

| Erro | Código | Quando Ocorre |
|------|--------|---------------|
| `E_NOT_OWNER` | 1 | Capability de outro dono |
| `E_LINK_CAP_MISMATCH` | 2 | Capability de outro link |
| `E_INVALID_URL` | 3 | URL inválida |
| `E_INVALID_SHORT_CODE` | 4 | Código inválido |
| `E_EXPIRED` | 8 | Link expirado |
| `E_INSUFFICIENT_PAYMENT` | 9 | Pagamento insuficiente |

### Testes Necessários:

```move
#[test]
#[expected_failure(abort_code = suisnap::E_EXPIRED)]
fun update_expired_link_fails() { ... }

#[test]
#[expected_failure(abort_code = suisnap::E_INSUFFICIENT_PAYMENT)]
fun create_link_with_insufficient_payment_fails() { ... }
```

---

## ✅ Checklist de Conclusão

- [ ] Dynamic fields implementados para metadata
- [ ] EditCap granular criado (URL e short_code separados)
- [ ] NFT do link implementado
- [ ] Sistema de hash para privacidade criado
- [ ] Expiração com clock oracle implementada
- [ ] Sistema de pagamento em SUI criado
- [ ] Diagrama de estados mapeado
- [ ] Testes para novas funcionalidades criados

