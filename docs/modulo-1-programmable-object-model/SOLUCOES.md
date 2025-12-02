# Módulo 1 — Soluções: Programmable Object Model

## Exercício 1: Criar Link via CLI

```bash
# Substitua <PACKAGE_ID> pelo ID obtido no módulo 0
sui client call \
  --package <PACKAGE_ID> \
  --module suisnap \
  --function create_link \
  --args "vector<u8>:https://exemplo.com" "vector<u8>:abc" \
  --gas-budget 20000000
```

**Resultado esperado:**
- Link criado com sucesso
- Dois objetos criados: `Link` e `EditCap`
- Anotar os `objectId` de ambos

**Listar objetos do dono:**
```bash
sui client objects --owner <SEU_ENDERECO>
```

**Identificar objetos:**
- Objeto do tipo `Link` com `original_url` e `short_code`
- Objeto do tipo `EditCap` com `link_id` correspondente

---

## Exercício 2: Inspecionar Link

```bash
# Via CLI
sui client object --id <LINK_ID> --json

# Via Explorer
# Acesse: https://suiexplorer.com
# Cole o objectId do Link na busca
```

**Informações esperadas:**
- `owner`: Endereço do dono
- `original_url`: URL original
- `short_code`: Código curto
- `id`: UID do objeto

---

## Exercício 3: Transferir Link

```bash
# Transferir apenas o Link (não a EditCap)
sui client transfer \
  --to <OUTRO_ENDERECO> \
  --object-id <LINK_ID> \
  --gas-budget 20000000
```

**Observação importante:**
- O `Link` agora pertence ao novo endereço
- A `EditCap` continua com o dono original
- Isso demonstra que objetos podem ser transferidos independentemente

**Verificar transferência:**
```bash
# Objetos do novo dono
sui client objects --owner <OUTRO_ENDERECO>

# Objetos do dono original (ainda tem a EditCap)
sui client objects --owner <ENDERECO_ORIGINAL>
```

---

## Exercício 4: Adicionar Campo `clicks`

### Código em `sources/suisnap.move`:

```move
struct Link has key {
    id: UID,
    owner: address,
    original_url: vector<u8>,
    short_code: vector<u8>,
    clicks: u64,  // NOVO CAMPO
}

// Função para incrementar cliques
public entry fun register_click(
    link: &mut Link,
    cap: &EditCap,
    ctx: &TxContext
) {
    let actor = tx_context::sender(ctx);
    enforce_access(link, cap, actor);
    link.clicks = link.clicks + 1;
    
    // Opcional: emitir evento
    event::emit(ClickRegistered {
        link_id: object::id(link),
        clicks: link.clicks,
    });
}

// Evento opcional
struct ClickRegistered has copy, drop {
    link_id: ID,
    clicks: u64,
}
```

### Atualizar `create_link_internal`:

```move
public(friend) fun create_link_internal(
    owner: address,
    original_url: vector<u8>,
    short_code: vector<u8>,
    ctx: &mut TxContext
): (Link, EditCap) {
    let link = Link {
        id: object::new(ctx),
        owner,
        original_url,
        short_code,
        clicks: 0,  // Inicializar com 0
    };
    let cap = EditCap {
        id: object::new(ctx),
        link_id: object::id(&link),
        owner,
    };
    (link, cap)
}
```

### Testar:

```bash
# Recompilar
sui move build

# Executar testes
sui move test

# Testar via CLI (após republicar)
sui client call \
  --package <PACKAGE_ID> \
  --module suisnap \
  --function register_click \
  --args object:<LINK_ID> object:<EDIT_CAP_ID> \
  --gas-budget 20000000
```

---

## ✅ Checklist de Conclusão

- [ ] Link criado via CLI
- [ ] Objetos `Link` e `EditCap` identificados
- [ ] Link inspecionado no Explorer
- [ ] Link transferido para outro endereço
- [ ] Campo `clicks` adicionado ao struct
- [ ] Função `register_click` implementada
- [ ] Testes passando após modificações

