# Módulo 2 — Soluções: Ownership e Autorização

## Exercício 1: Atualizar Link Corretamente

```bash
sui client call \
  --package <PACKAGE_ID> \
  --module suisnap \
  --function update_link \
  --args \
    object:<LINK_ID> \
    object:<EDIT_CAP_ID> \
    "vector<u8>:https://novo.com" \
    "vector<u8>:novo" \
  --gas-budget 20000000
```

**Pré-requisitos:**
- O `Link` e a `EditCap` devem pertencer ao mesmo endereço
- Você deve estar usando o endereço que possui ambos os objetos

**Resultado esperado:**
- Link atualizado com sucesso
- Evento `LinkUpdated` emitido
- Novos valores de URL e short_code aplicados

**Verificar atualização:**
```bash
sui client object --id <LINK_ID> --json
```

---

## Exercício 2: Testar Falha de Dono Errado

### Passo 1: Transferir EditCap

```bash
# Criar segundo endereço (se ainda não tiver)
sui client new-address ed25519
# Anotar o novo endereço: <ADDR2>

# Transferir EditCap para o segundo endereço
sui client transfer \
  --to <ADDR2> \
  --object-id <EDIT_CAP_ID> \
  --gas-budget 20000000
```

### Passo 2: Tentar Atualizar com Dono Errado

```bash
# Mudar para o segundo endereço
sui client switch --address <ADDR2>

# Tentar atualizar (deve falhar)
sui client call \
  --package <PACKAGE_ID> \
  --module suisnap \
  --function update_link \
  --args \
    object:<LINK_ID> \
    object:<EDIT_CAP_ID> \
    "vector<u8>:https://fail.com" \
    "vector<u8>:fail" \
  --gas-budget 20000000
```

**Resultado esperado:**
```
Error: MoveAbort(1, E_NOT_OWNER)
```

**Explicação:**
- A `EditCap` foi transferida para `<ADDR2>`
- Mas o `Link` ainda pertence ao endereço original
- A função `enforce_access` verifica se o dono da cap é quem está tentando usar
- Como a cap foi transferida, o abort `E_NOT_OWNER` é acionado

---

## Exercício 3: Testar Mismatch de Capability

### Passo 1: Criar Dois Links

```bash
# Criar Link A
sui client call \
  --package <PACKAGE_ID> \
  --module suisnap \
  --function create_link \
  --args "vector<u8>:https://linka.com" "vector<u8>:linka" \
  --gas-budget 20000000
# Anotar: LINK_A_ID e CAP_A_ID

# Criar Link B
sui client call \
  --package <PACKAGE_ID> \
  --module suisnap \
  --function create_link \
  --args "vector<u8>:https://linkb.com" "vector<u8>:linkb" \
  --gas-budget 20000000
# Anotar: LINK_B_ID e CAP_B_ID
```

### Passo 2: Tentar Usar Cap de A em Link B

```bash
# Tentar atualizar Link B usando Cap de A (deve falhar)
sui client call \
  --package <PACKAGE_ID> \
  --module suisnap \
  --function update_link \
  --args \
    object:<LINK_B_ID> \
    object:<CAP_A_ID> \
    "vector<u8>:https://fail.com" \
    "vector<u8>:fail" \
  --gas-budget 20000000
```

**Resultado esperado:**
```
Error: MoveAbort(2, E_LINK_CAP_MISMATCH)
```

**Explicação:**
- A `EditCap` de A tem `link_id` apontando para A
- Tentamos usar essa cap no Link B
- A função `enforce_access` verifica se `cap.link_id == object::id(link)`
- Como não correspondem, o abort `E_LINK_CAP_MISMATCH` é acionado

---

## Exercício 4: Implementar `transfer_edit_cap`

### Código em `sources/suisnap.move`:

```move
// Adicionar novo erro
const E_CAP_TRANSFER_NOT_ALLOWED: u64 = 7;

// Função para transferir EditCap
public entry fun transfer_edit_cap(
    cap: EditCap,
    new_owner: address,
    ctx: &TxContext
) {
    let actor = tx_context::sender(ctx);
    
    // Verificar se o sender é o dono atual da cap
    if (cap.owner != actor) {
        abort E_CAP_TRANSFER_NOT_ALLOWED
    };
    
    // Atualizar o owner da cap
    cap.owner = new_owner;
    
    // Transferir a cap atualizada
    transfer::transfer(cap, new_owner);
}
```

### Teste em `tests/suisnap_tests.move`:

```move
#[test]
#[expected_failure(abort_code = suisnap::E_CAP_TRANSFER_NOT_ALLOWED)]
fun transfer_cap_rejects_wrong_owner() {
    let owner1 = @0xAA;
    let owner2 = @0xBB;
    let scenario = test_scenario::begin(owner1);
    {
        let ctx = test_scenario::ctx(&mut scenario);
        let (link, cap) = suisnap::create_link_internal(
            owner1, b"https://test.com", b"test", ctx
        );
        
        // Tentar transferir cap com owner2 (deve falhar)
        // Nota: precisa expor função friend ou testar via entry
        // Por enquanto, teste manual via CLI
    };
    test_scenario::end(scenario);
}
```

### Testar via CLI:

```bash
# Transferir cap corretamente (deve funcionar)
sui client call \
  --package <PACKAGE_ID> \
  --module suisnap \
  --function transfer_edit_cap \
  --args object:<EDIT_CAP_ID> <NOVO_ENDERECO> \
  --gas-budget 20000000

# Tentar transferir cap de outro dono (deve falhar)
# Use um endereço que não possui a cap
```

---

## ✅ Checklist de Conclusão

- [ ] Link atualizado com sucesso usando cap correta
- [ ] Testado abort `E_NOT_OWNER` com cap transferida
- [ ] Testado abort `E_LINK_CAP_MISMATCH` com cap de outro link
- [ ] Função `transfer_edit_cap` implementada
- [ ] Erro `E_CAP_TRANSFER_NOT_ALLOWED` testado
- [ ] Compreensão do padrão Capability confirmada

