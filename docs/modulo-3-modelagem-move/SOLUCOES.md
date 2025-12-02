# Módulo 3 — Soluções: Modelagem Move

## Exercício 1: Validar `short_code`

### Código em `sources/suisnap.move`:

```move
// Adicionar constante de erro
const E_SHORT_CODE_INVALID: u64 = 4;

// Função de validação (já existe, mas vamos melhorar)
fun validate_short_code(code: &vector<u8>): bool {
    let len = vector::length(code);
    
    // Verificar tamanho mínimo e máximo
    if (len < MIN_SHORT_CODE_LENGTH || len > MAX_SHORT_CODE_LENGTH) {
        return false
    };
    
    // Verificar caracteres alfanuméricos
    let i = 0;
    while (i < len) {
        let char = *vector::borrow(code, i);
        // 0-9, A-Z, a-z, -, _
        if (!((char >= 48 && char <= 57) ||   // 0-9
              (char >= 65 && char <= 90) ||    // A-Z
              (char >= 97 && char <= 122) ||   // a-z
              char == 45 ||                    // -
              char == 95)) {                   // _
            return false
        };
        i = i + 1;
    };
    true
}
```

### Teste em `tests/suisnap_tests.move`:

```move
#[test]
#[expected_failure(abort_code = suisnap::E_INVALID_SHORT_CODE)]
fun create_link_rejects_empty_short_code() {
    let owner = @0xAA;
    let scenario = test_scenario::begin(owner);
    {
        let ctx = test_scenario::ctx(&mut scenario);
        // Código vazio deve falhar
        let (link, cap) = suisnap::create_link_internal(
            owner, b"https://test.com", b"", ctx
        );
        suisnap::delete_link_internal(link, cap, owner);
    };
    test_scenario::end(scenario);
}

#[test]
#[expected_failure(abort_code = suisnap::E_INVALID_SHORT_CODE)]
fun create_link_rejects_long_short_code() {
    let owner = @0xBB;
    let scenario = test_scenario::begin(owner);
    {
        let ctx = test_scenario::ctx(&mut scenario);
        // Código muito longo (51 caracteres)
        let long_code = b"abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxy";
        let (link, cap) = suisnap::create_link_internal(
            owner, b"https://test.com", long_code, ctx
        );
        suisnap::delete_link_internal(link, cap, owner);
    };
    test_scenario::end(scenario);
}
```

---

## Exercício 2: Sanitizar URL

### Código em `sources/suisnap.move`:

```move
// Função de validação de URL (já existe, mas vamos revisar)
fun validate_url(url: &vector<u8>): bool {
    let len = vector::length(url);
    
    // Verificar tamanho
    if (len > MAX_URL_LENGTH || len == 0) {
        return false
    };
    
    // Verificar se começa com http:// (7 caracteres)
    if (len >= 7) {
        let http = vector::borrow(url, 0);
        let t1 = vector::borrow(url, 1);
        let t2 = vector::borrow(url, 2);
        let p = vector::borrow(url, 3);
        let colon = vector::borrow(url, 4);
        let slash1 = vector::borrow(url, 5);
        let slash2 = vector::borrow(url, 6);
        
        if (*http == 104 && *t1 == 116 && *t2 == 116 && *p == 112 &&
            *colon == 58 && *slash1 == 47 && *slash2 == 47) {
            return true
        };
    };
    
    // Verificar se começa com https:// (8 caracteres)
    if (len >= 8) {
        let https = vector::borrow(url, 0);
        let t1 = vector::borrow(url, 1);
        let t2 = vector::borrow(url, 2);
        let p = vector::borrow(url, 3);
        let s = vector::borrow(url, 4);
        let colon = vector::borrow(url, 5);
        let slash1 = vector::borrow(url, 6);
        let slash2 = vector::borrow(url, 7);
        
        if (*https == 104 && *t1 == 116 && *t2 == 116 && *p == 112 &&
            *s == 115 && *colon == 58 && *slash1 == 47 && *slash2 == 47) {
            return true
        };
    };
    
    false
}
```

---

## Exercício 3: Refatoração Opcional

### Criar `sources/events.move`:

```move
module suisnap::events {
    use sui::event;
    use sui::object::ID;

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

    public fun emit_created(link_id: ID, owner: address, short_code: vector<u8>) {
        event::emit(LinkCreated { link_id, owner, short_code });
    }

    public fun emit_updated(link_id: ID, owner: address, short_code: vector<u8>) {
        event::emit(LinkUpdated { link_id, owner, short_code });
    }

    public fun emit_deleted(link_id: ID, owner: address) {
        event::emit(LinkDeleted { link_id, owner });
    }
}
```

### Criar `sources/caps.move`:

```move
module suisnap::caps {
    use sui::object::{Self, ID, UID};
    use sui::transfer;
    use sui::tx_context::TxContext;

    struct EditCap has key {
        id: UID,
        link_id: ID,
        owner: address,
    }

    public fun create(link_id: ID, owner: address, ctx: &mut TxContext): EditCap {
        EditCap {
            id: object::new(ctx),
            link_id,
            owner,
        }
    }

    public fun link_id(cap: &EditCap): ID {
        cap.link_id
    }

    public fun owner(cap: &EditCap): address {
        cap.owner
    }

    public fun transfer(cap: EditCap, recipient: address) {
        transfer::transfer(cap, recipient);
    }
}
```

### Atualizar `sources/suisnap.move`:

```move
module suisnap::suisnap {
    use std::vector;
    use sui::object::{Self, ID, UID};
    use sui::tx_context::{Self, TxContext};
    
    use suisnap::events;
    use suisnap::caps::{Self, EditCap};

    // ... resto do código usando events:: e caps::
}
```

---

## Exercício 4: Função `get_short_code`

### Código:

```move
// Função pública (não entry) para leitura
public fun get_short_code(link: &Link): vector<u8> {
    clone_vector(&link.short_code)
}
```

**Por que não `entry`?**
- `entry` functions são para transações que modificam estado
- `get_short_code` apenas lê dados, não precisa ser uma transação
- Funções públicas sem `entry` podem ser chamadas por outros módulos ou via view calls
- Mais eficiente: não gasta gas para apenas ler dados

---

## ✅ Checklist de Conclusão

- [ ] Validação de `short_code` implementada e testada
- [ ] Validação de URL implementada
- [ ] Testes de falha criados com `#[expected_failure]`
- [ ] Refatoração opcional realizada (se escolhida)
- [ ] Função `get_short_code` adicionada e justificada
- [ ] Código compilando e testes passando

