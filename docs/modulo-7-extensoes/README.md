# Módulo 7 — Extensões avançadas

Objetivo: evoluir o SuiSnap com features opcionais.

Exercícios práticos
1) Dynamic fields: armazenar metadata extra (ex.: descrição) por `link_id` usando dynamic fields; função para set/get.
2) EditCap granular: criar `UrlEditCap` e `ShortCodeEditCap`; ajustar `enforce_access` para cada fluxo.
3) NFT do link: mintear um NFT ligado ao `link_id` ao criar link; transferir NFT não transfere `Link` (discutir implicações).
4) Privacidade: armazenar hash da URL (SHA3) e guardar URL original off-chain; validar hash em uma entry.
5) Expiração: usar clock oracle para marcar `expires_at` e abortar updates/redirect se expirada.
6) Pagamento: cobrar `X` SUI na criação (`balance::split`) e acumular em um cofre; função para sacar para o owner/admin.
7) Diagrama de estados: mapear eventos e transições com as extensões; listar erros novos e testes necessários.
