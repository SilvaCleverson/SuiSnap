# Módulo 6 — Front-end (Sui dApp Kit)

Objetivo: integrar a dApp ao contrato Move.

Exercícios práticos
1) Criar front-end base (Next/React): `npx create-next-app suisnap-frontend --ts` e instalar `@mysten/dapp-kit @mysten/sui.js`.
2) Conectar carteira e mostrar endereço/saldo: usar `useWalletKit` e `useSuiClient` para exibir dados do perfil conectado.
3) Chamar `create_link` via `moveCall`:
   - Input URL e shortcode, montar args como `new Uint8Array(Buffer.from(url))`.
   - Usar `packageId` publicado e `module: "suisnap"`, `function: "create_link"`.
4) Listar objetos `Link` do usuário: `client.getOwnedObjects` filtrando pelo `type` do objeto `Link` (inclui packageId e struct `Link`). Renderizar URL/shortcode.
5) Atualizar link pelo front: botão para enviar `update_link` usando `objectId` do Link e da EditCap.
6) UX extra: botão copiar shortcode, abrir URL original em nova aba, exibir eventos recentes consumindo `getEvents`.
