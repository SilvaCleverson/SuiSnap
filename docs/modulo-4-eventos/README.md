# Módulo 4 — Eventos

Objetivo: emitir e consultar eventos.

Conceitos-chave
- Eventos `LinkCreated`, `LinkUpdated`, `LinkDeleted` emitidos nas helpers.
- Consulta via Explorer/Indexer ou CLI.

Exercícios práticos
1) Criar/atualizar/deletar um link e consultar eventos:
   - Após transações, rode: `sui client query-events --limit 5 --move-event-struct <PACKAGE_ID>::suisnap::LinkCreated` (repita para `LinkUpdated`/`LinkDeleted`).
2) Incluir dados extras:
   - Alterar `LinkCreated` para carregar `original_url` truncada e `short_code`.
   - Reexecutar `sui move test` e publicar novamente; verificar evento no Explorer.
3) Exercício de auditoria:
   - Criar 3 links com diferentes donos; consultar eventos filtrando por `Sender` e analisar diferenças.
4) Extensão do módulo 1:
   - Se criou `register_click`, emitir `ClickRegistered` e consultar.
