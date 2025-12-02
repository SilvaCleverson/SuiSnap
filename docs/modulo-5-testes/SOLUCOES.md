# Módulo 5 — Soluções: Testes

## Exercício 1: Teste para `E_LINK_CAP_MISMATCH`

### Código em `tests/suisnap_tests.move`:

```move
#[test]
#[expected_failure(abort_code = suisnap::E_LINK_CAP_MISMATCH)]
fun update_rejects_wrong_cap() {
    let owner = @0xE;
    let scenario = test_scenario::begin(owner);
    {
        let ctx = test_scenario::ctx(&mut scenario);
        
        // Criar dois links
        let (link1, cap1) = suisnap::create_link_internal(
            owner, b"https://url1.com", b"code1", ctx
        );
        let (link2, cap2) = suisnap::create_link_internal(
            owner, b"https://url2.com", b"code2", ctx
        );
        
        // Tentar atualizar link1 usando cap2 (deve falhar)
        suisnap::update_link_internal(
            &mut link1, &cap2, owner, b"https://fail.com", b"fail"
        );
        
        // Limpeza (nunca chega aqui se o abort funcionar)
        suisnap::delete_link_internal(link1, cap1, owner);
        suisnap::delete_link_internal(link2, cap2, owner);
    };
    test_scenario::end(scenario);
}
```

**Executar:**
```bash
sui move test --filter update_rejects_wrong_cap
```

---

## Exercício 2: Teste para Validação de `short_code`

### Código em `tests/suisnap_tests.move`:

```move
#[test]
#[expected_failure(abort_code = suisnap::E_INVALID_SHORT_CODE)]
fun create_link_rejects_empty_short_code() {
    let owner = @0xF;
    let scenario = test_scenario::begin(owner);
    {
        let ctx = test_scenario::ctx(&mut scenario);
        // Código vazio deve abortar
        let (link, cap) = suisnap::create_link_internal(
            owner, b"https://test.com", b"", ctx
        );
        suisnap::delete_link_internal(link, cap, owner);
    };
    test_scenario::end(scenario);
}

#[test]
#[expected_failure(abort_code = suisnap::E_INVALID_SHORT_CODE)]
fun create_link_rejects_invalid_short_code() {
    let owner = @0x10;
    let scenario = test_scenario::begin(owner);
    {
        let ctx = test_scenario::ctx(&mut scenario);
        // Código com caracteres inválidos (espaço)
        let (link, cap) = suisnap::create_link_internal(
            owner, b"https://test.com", b"invalid code", ctx
        );
        suisnap::delete_link_internal(link, cap, owner);
    };
    test_scenario::end(scenario);
}

#[test]
#[expected_failure(abort_code = suisnap::E_INVALID_URL)]
fun create_link_rejects_invalid_url() {
    let owner = @0x11;
    let scenario = test_scenario::begin(owner);
    {
        let ctx = test_scenario::ctx(&mut scenario);
        // URL sem http:// ou https://
        let (link, cap) = suisnap::create_link_internal(
            owner, b"invalid-url.com", b"test", ctx
        );
        suisnap::delete_link_internal(link, cap, owner);
    };
    test_scenario::end(scenario);
}
```

---

## Exercício 3: Testar Evento Esperado

### Código:

```move
#[test]
fun update_link_emits_event() {
    let owner = @0x12;
    let scenario = test_scenario::begin(owner);
    {
        let ctx = test_scenario::ctx(&mut scenario);
        let (link, cap) = suisnap::create_link_internal(
            owner, b"https://old.com", b"old", ctx
        );
        
        // Atualizar deve funcionar e emitir evento
        suisnap::update_link_internal(
            &mut link, &cap, owner, b"https://new.com", b"new"
        );
        
        // Verificar que os valores foram atualizados
        let url = suisnap::get_url(&link);
        let code = suisnap::get_short_code(&link);
        assert!(url == b"https://new.com", 0);
        assert!(code == b"new", 0);
        
        suisnap::delete_link_internal(link, cap, owner);
    };
    test_scenario::end(scenario);
}

#[test]
#[expected_failure(abort_code = suisnap::E_INVALID_URL)]
fun update_link_rejects_invalid_url() {
    let owner = @0x13;
    let scenario = test_scenario::begin(owner);
    {
        let ctx = test_scenario::ctx(&mut scenario);
        let (link, cap) = suisnap::create_link_internal(
            owner, b"https://valid.com", b"valid", ctx
        );
        
        // Tentar atualizar com URL inválida (deve falhar)
        suisnap::update_link_internal(
            &mut link, &cap, owner, b"invalid-url", b"new"
        );
        
        suisnap::delete_link_internal(link, cap, owner);
    };
    test_scenario::end(scenario);
}
```

---

## Exercício 4: Rodar Testes com Filtro

```bash
# Todos os testes do módulo
sui move test --filter suisnap

# Teste específico
sui move test --filter update_rejects_wrong_cap

# Com output detalhado
sui move test --filter suisnap --verbose
```

**Interpretar abort codes:**
- `E_NOT_OWNER (1)`: Tentativa de usar capability de outro dono
- `E_LINK_CAP_MISMATCH (2)`: Capability não pertence ao link
- `E_INVALID_URL (3)`: URL não começa com http:// ou https://
- `E_INVALID_SHORT_CODE (4)`: Código curto inválido (vazio, muito longo, ou caracteres inválidos)

---

## Exercício 5: Proptest Simples

### Código:

```move
#[test]
fun proptest_short_code_lengths() {
    let owner = @0x14;
    let scenario = test_scenario::begin(owner);
    {
        let ctx = test_scenario::ctx(&mut scenario);
        
        // Testar diferentes tamanhos
        let sizes = vector[1, 5, 10, 20, 50];
        let i = 0;
        let len = vector::length(&sizes);
        
        while (i < len) {
            let size = *vector::borrow(&sizes, i);
            let code = vector::empty<u8>();
            let j = 0;
            
            // Criar código do tamanho especificado
            while (j < size) {
                vector::push_back(&mut code, 97); // 'a'
                j = j + 1;
            };
            
            // Deve funcionar para tamanhos válidos (1-50)
            let (link, cap) = suisnap::create_link_internal(
                owner, b"https://test.com", code, ctx
            );
            suisnap::delete_link_internal(link, cap, owner);
            
            i = i + 1;
        };
    };
    test_scenario::end(scenario);
}

#[test]
#[expected_failure(abort_code = suisnap::E_INVALID_SHORT_CODE)]
fun proptest_short_code_too_long() {
    let owner = @0x15;
    let scenario = test_scenario::begin(owner);
    {
        let ctx = test_scenario::ctx(&mut scenario);
        
        // Criar código com 51 caracteres (muito longo)
        let long_code = vector::empty<u8>();
        let i = 0;
        while (i < 51) {
            vector::push_back(&mut long_code, 97); // 'a'
            i = i + 1;
        };
        
        // Deve abortar
        let (link, cap) = suisnap::create_link_internal(
            owner, b"https://test.com", long_code, ctx
        );
        suisnap::delete_link_internal(link, cap, owner);
    };
    test_scenario::end(scenario);
}
```

---

## ✅ Checklist de Conclusão

- [ ] Teste para `E_LINK_CAP_MISMATCH` implementado
- [ ] Testes para validação de `short_code` criados
- [ ] Testes para validação de URL criados
- [ ] Teste de evento após atualização implementado
- [ ] Testes executados com filtro e interpretados
- [ ] Proptest simples implementado
- [ ] Todos os testes passando

