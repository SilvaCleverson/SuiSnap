# Módulo 2 — Ownership e Autorização

Objetivo: aplicar `tx_context::sender` e capabilities.

Conceitos-chave
- `EditCap` amarra dono (`owner`) e `link_id`; `enforce_access` aborta com `E_NOT_OWNER` ou `E_LINK_CAP_MISMATCH`.

Exercícios práticos
1) Atualizar link corretamente:
   `sui client call --package <PACKAGE_ID> --module suisnap --function update_link --args object:<LINK_ID> object:<EDIT_CAP_ID> "vector<u8>:https://novo.com" "vector<u8>:novo" --gas-budget 20000000`
   (use o mesmo dono do `Link` e da `EditCap`).
2) Testar falha de dono errado:
   - Transfira a `EditCap` para outro endereço: `sui client transfer --to <ADDR2> --object-id <EDIT_CAP_ID> --gas-budget 20000000`.
   - Tente atualizar a partir de `<ADDR2>` e observe o abort `E_NOT_OWNER`.
3) Testar mismatch de capability:
   - Crie dois links A e B; use a cap de A para atualizar B e veja o abort `E_LINK_CAP_MISMATCH`.
4) Exercício de código: implementar `transfer_edit_cap` que só permite o owner mover a cap para outro endereço de forma segura; adicione erro `E_CAP_TRANSFER_NOT_ALLOWED` e teste.
