# Módulo 0 — Soluções: Setup

## Exercício 1: Verificar Instalação

```bash
sui --version
```

**Resultado esperado:** Versão do Sui CLI (ex: `sui 1.59.1`)

---

## Exercício 2: Criar e Selecionar Endereço

```bash
# Criar novo endereço
sui client new-address ed25519

# Selecionar endereço (use o endereço retornado)
sui client switch --address 0x...

# Verificar endereço ativo
sui client active-address
```

**Resultado esperado:** Endereço criado e selecionado com sucesso.

---

## Exercício 3: Escolher Rede

```bash
# Escolher devnet
sui client switch --env devnet

# Obter tokens de teste (se necessário)
sui client faucet
```

**Resultado esperado:** Ambiente configurado e tokens obtidos.

---

## Exercício 4: Compilar e Testar

```bash
# Compilar o pacote
sui move build

# Executar testes
sui move test
```

**Resultado esperado:** Compilação bem-sucedida e todos os testes passando.

---

## Exercício 5: Publicar Pacote

```bash
sui client publish --gas-budget 500000000 --skip-fetch-latest-gas-price .
```

**Resultado esperado:** 
- Package publicado com sucesso
- **Anotar o `packageId`** retornado (ex: `0x1234...`)
- **Anotar o `objectId`** do pacote publicado

**Exemplo de saída:**
```
Published Objects:
  ┌──
  │ PackageID: 0x1234567890abcdef...
  │ ...
```

---

## Exercício 6: Revisar Estrutura

**Estrutura esperada:**
```
SuiSnap/
├── Move.toml          # Configuração do pacote
├── sources/
│   └── suisnap.move   # Módulo principal
├── tests/
│   └── suisnap_tests.move  # Testes
└── docs/              # Documentação
```

**Verificações:**
- ✅ `Move.toml` contém nome do pacote e dependências
- ✅ `sources/suisnap.move` contém o módulo `suisnap::suisnap`
- ✅ `tests/suisnap_tests.move` contém testes unitários

---

## ✅ Checklist de Conclusão

- [ ] Sui CLI instalado e funcionando
- [ ] Endereço criado e selecionado
- [ ] Ambiente configurado (devnet/localnet)
- [ ] Pacote compilado sem erros
- [ ] Testes executados com sucesso
- [ ] Pacote publicado na blockchain
- [ ] `packageId` anotado para uso futuro

