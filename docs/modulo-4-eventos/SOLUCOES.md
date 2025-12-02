# Módulo 4 — Soluções: Eventos

## Exercício 1: Consultar Eventos

### Após criar um link:

```bash
sui client query-events \
  --limit 5 \
  --move-event-struct <PACKAGE_ID>::suisnap::LinkCreated
```

### Após atualizar um link:

```bash
sui client query-events \
  --limit 5 \
  --move-event-struct <PACKAGE_ID>::suisnap::LinkUpdated
```

### Após deletar um link:

```bash
sui client query-events \
  --limit 5 \
  --move-event-struct <PACKAGE_ID>::suisnap::LinkDeleted
```

**Resultado esperado:**
```json
{
  "id": {...},
  "packageId": "0x...",
  "transactionModule": "suisnap",
  "sender": "0x...",
  "type": "<PACKAGE_ID>::suisnap::LinkCreated",
  "parsedJson": {
    "link_id": "0x...",
    "owner": "0x...",
    "short_code": "abc"
  }
}
```

---

## Exercício 2: Incluir Dados Extras no Evento

### Atualizar struct `LinkCreated`:

```move
struct LinkCreated has copy, drop {
    link_id: ID,
    owner: address,
    original_url: vector<u8>,  // NOVO
    short_code: vector<u8>,
}
```

### Atualizar emissão do evento:

```move
public entry fun create_link(
    original_url: vector<u8>,
    short_code: vector<u8>,
    ctx: &mut TxContext
) {
    // ... validações ...
    
    let sender = tx_context::sender(ctx);
    let (link, cap) = create_link_internal(sender, original_url, short_code, ctx);
    let link_id = object::id(&link);
    
    // Truncar URL para os primeiros 50 caracteres
    let url_len = vector::length(&link.original_url);
    let truncated_url = if (url_len > 50) {
        // Criar vector com primeiros 50 caracteres
        let result = vector::empty<u8>();
        let i = 0;
        while (i < 50) {
            vector::push_back(&mut result, *vector::borrow(&link.original_url, i));
            i = i + 1;
        };
        result
    } else {
        clone_vector(&link.original_url)
    };
    
    event::emit(LinkCreated {
        link_id,
        owner: sender,
        original_url: truncated_url,
        short_code: clone_vector(&link.short_code),
    });
    
    transfer::transfer(link, sender);
    transfer::transfer(cap, sender);
}
```

### Recompilar e republicar:

```bash
sui move build
sui move test
sui client publish --gas-budget 500000000 --skip-fetch-latest-gas-price .
```

### Verificar no Explorer:

1. Acesse https://suiexplorer.com
2. Busque pelo `packageId` ou `objectId` do link
3. Veja os eventos emitidos com a URL truncada

---

## Exercício 3: Auditoria com Múltiplos Donos

### Criar 3 links com diferentes donos:

```bash
# Link 1 - Dono A
sui client switch --address <ENDERECO_A>
sui client call \
  --package <PACKAGE_ID> \
  --module suisnap \
  --function create_link \
  --args "vector<u8>:https://dono-a.com" "vector<u8>:donoa" \
  --gas-budget 20000000

# Link 2 - Dono B
sui client switch --address <ENDERECO_B>
sui client call \
  --package <PACKAGE_ID> \
  --module suisnap \
  --function create_link \
  --args "vector<u8>:https://dono-b.com" "vector<u8>:donob" \
  --gas-budget 20000000

# Link 3 - Dono C
sui client switch --address <ENDERECO_C>
sui client call \
  --package <PACKAGE_ID> \
  --module suisnap \
  --function create_link \
  --args "vector<u8>:https://dono-c.com" "vector<u8>:donoc" \
  --gas-budget 20000000
```

### Consultar eventos por sender:

```bash
# Eventos do Dono A
sui client query-events \
  --move-event-struct <PACKAGE_ID>::suisnap::LinkCreated \
  --sender <ENDERECO_A>

# Eventos do Dono B
sui client query-events \
  --move-event-struct <PACKAGE_ID>::suisnap::LinkCreated \
  --sender <ENDERECO_B>

# Eventos do Dono C
sui client query-events \
  --move-event-struct <PACKAGE_ID>::suisnap::LinkCreated \
  --sender <ENDERECO_C>
```

### Análise:

Compare os eventos e observe:
- Cada dono tem seus próprios eventos
- O campo `owner` nos eventos corresponde ao `sender`
- Eventos são imutáveis e permanentes

---

## Exercício 4: Evento `ClickRegistered`

### Se implementou `register_click` no Módulo 1:

```move
struct ClickRegistered has copy, drop {
    link_id: ID,
    clicks: u64,
    timestamp: u64,  // Opcional: usar clock oracle
}

public entry fun register_click(
    link: &mut Link,
    cap: &EditCap,
    ctx: &TxContext
) {
    let actor = tx_context::sender(ctx);
    enforce_access(link, cap, actor);
    
    link.clicks = link.clicks + 1;
    
    event::emit(ClickRegistered {
        link_id: object::id(link),
        clicks: link.clicks,
    });
}
```

### Consultar eventos de clique:

```bash
sui client query-events \
  --move-event-struct <PACKAGE_ID>::suisnap::ClickRegistered
```

---

## ✅ Checklist de Conclusão

- [ ] Eventos `LinkCreated`, `LinkUpdated`, `LinkDeleted` consultados via CLI
- [ ] Eventos visualizados no Sui Explorer
- [ ] Dados extras (URL truncada) adicionados ao evento
- [ ] Auditoria realizada com múltiplos donos
- [ ] Evento `ClickRegistered` implementado (se aplicável)
- [ ] Compreensão da imutabilidade de eventos confirmada

