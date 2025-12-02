# Módulo 3 — Modelagem Move

Objetivo: organizar código e tipos.

Conceitos-chave
- Separar responsabilidades (módulos para eventos/caps depois, se quiser).
- `vector<u8>` como string; validar tamanho e conteúdo.
- Visibilidade: `public entry`, `public(friend)`, helpers para testes.

Exercícios práticos
1) Validar `short_code`:
   - Adicione constante `E_SHORT_CODE_INVALID` e rejeite códigos vazios ou > 16 bytes em `create_link_internal`/`update_link_internal`.
   - Rode `sui move test` para garantir que falhas são cobertas.
2) Sanitizar URL:
   - Rejeitar URLs que não começam com `http` (checagem simples de prefixo em bytes).
3) Refatoração opcional:
   - Extrair eventos para `sources/events.move` e capabilities para `sources/caps.move`; atualizar imports/uses.
4) Exercício: adicionar função `get_short_code(link: &Link): vector<u8>` com visibilidade `public(friend)` e justificar por que não deve ser `entry`.
