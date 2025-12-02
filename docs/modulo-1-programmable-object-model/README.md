# Módulo 1 — Programmable Object Model

Objetivo: entender objetos Sui e UID.

Conceitos-chave
- Objeto `Link` (has key) com `UID`, `owner`, `original_url`, `short_code` em `sources/suisnap.move`.
- Mutabilidade controlada e transferência de objetos.

Exercícios práticos
1) Criar link via CLI:
   - Use o `packageId` publicado: `sui client call --package <PACKAGE_ID> --module suisnap --function create_link --args "vector<u8>:https://exemplo.com" "vector<u8>:abc" --gas-budget 20000000`.
   - Liste objetos do dono: `sui client objects --owner <ADDR>` e identifique `Link` e `EditCap`.
2) Inspecionar o `Link` pelo `objectId` no Explorer ou `sui client object --id <LINK_ID>`.
3) Transferir o link para outro endereço: `sui client transfer --to <ADDR2> --object-id <LINK_ID> --gas-budget 20000000` e observe que a capability continua com o dono original.
4) Exercício de código: adicionar campo `clicks: u64` em `Link` e uma `entry fun register_click(&mut Link, &EditCap, ...)` que incrementa; recompilar com `sui move build` e testar com `sui move test`.
