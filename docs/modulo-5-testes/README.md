# Módulo 5 — Testes

Objetivo: TDD e `sui move test`.

Conceitos-chave
- Testes em `tests/suisnap_tests.move` cobrem criação, atualização e erro de owner.
- `#[expected_failure]` para aborts; uso de helpers friend.

Exercícios práticos
1) Adicionar teste para `E_LINK_CAP_MISMATCH` usando cap de outro link.
2) Adicionar teste para validação de `short_code` (módulo 3) com `#[expected_failure]`.
3) Testar evento esperado: após `update_link_internal`, confirme que não aborta e (opcional) use `expected_failure` para um caso inválido.
4) Rodar `sui move test` com filtro: `sui move test --filter suisnap` e interpretar abort codes.
5) Desafio: criar um `proptest` simples (loop) gerando shortcodes de tamanhos variados e verificar aborts onde devido.
