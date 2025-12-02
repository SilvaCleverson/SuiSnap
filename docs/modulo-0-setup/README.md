# Módulo 0 — Setup

Objetivo: preparar o ambiente Sui/Move.

Pré-requisitos
- Instalar Sui CLI (ver docs oficiais) e ter `sui` no PATH.
- (Opcional) docker/localnet se não quiser usar devnet.

Exercícios práticos
1) Verificar instalação: `sui --version`.
2) Criar e selecionar endereço: `sui client new-address ed25519`; `sui client switch --address <ADDR>`; `sui client active-address`.
3) Escolher rede: `sui client switch --env devnet` (ou `localnet`). Se devnet, pegar faucet.
4) Clonar/abrir o pacote e compilar: `sui move build` e `sui move test` na raiz do projeto.
5) Publicar no ambiente escolhido (precisa SUI): `sui client publish --gas-budget 500000000 --skip-fetch-latest-gas-price .` e anotar o `packageId` gerado.
6) Revisar estrutura: `Move.toml`, `sources/`, `tests/` e docs/.
