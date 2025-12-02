# 🚀 SuiSnap

**Guia de Desenvolvimento em Move para Blockchain Sui**

---

## 📖 Apresentação

Bem-vindo à apostila sobre desenvolvimento em **Move** na blockchain **Sui**! Este guia prático foi criado para ajudar você a aprender a construir aplicações descentralizadas (dApps) usando o projeto SuiSnap como exemplo.

Através do projeto **SuiSnap** — um encurtador de links on-chain — você aprenderá os conceitos fundamentais do ecossistema Sui de forma prática e incremental. Ao final desta jornada, você terá conhecimento para modelar objetos, implementar autorização, emitir eventos, escrever testes e integrar com front-end.

> **🎯 Propósito Didático do SuiSnap**
>
> A ideia não é competir com encurtadores comerciais, mas criar um projeto didático que permita demonstrar, de forma prática e organizada, os principais conceitos da arquitetura da Sui:
>
> - Criação e gerenciamento de objetos on-chain
> - Manipulação de propriedade e permissões
> - Uso de capabilities para controle de acesso
> - Emissão de eventos para auditoria
> - Boas práticas de modelagem em Move
>
> Cada link encurtado se torna um objeto autônomo na Sui, permitindo explorar profundamente o seu modelo de objetos — que é justamente o diferencial acadêmico da plataforma. É um projeto simples em conceito, mas muito rico tecnicamente, adequado para demonstrar domínio de Sui/Move, arquitetura Web3 e desenvolvimento seguro em blockchain.

> **🔷 Por que Move e Sui?**
>
> Move é uma linguagem de smart contracts projetada especificamente para segurança de memória e o modelo de objetos único da Sui. Diferente de blockchains baseadas em contas (como Ethereum), a Sui utiliza um **Programmable Object Model** que permite maior flexibilidade, escalabilidade e segurança.

---

## 🎓 O que você vai aprender

O projeto SuiSnap foi estruturado para cobrir os principais aspectos técnicos da Sui de forma progressiva. Cada módulo constrói sobre o anterior, permitindo uma compreensão gradual e prática dos conceitos.

### 🔧 1. Programmable Object Model (Core da Sui)

**Objetivos de aprendizagem:**

- Criação de objetos usando `has key`
- Persistência on-chain via `UID`
- Mutabilidade controlada de objetos
- Transferência de objetos entre endereços
- Estruturação de dados stateful

Cada link encurtado vira um objeto on-chain, demonstrando como a Sui difere de blockchains baseadas em contas. Você entenderá na prática o modelo de objetos que é o diferencial da plataforma.

### 🔑 2. Ownership e Autorização

**Objetivos de aprendizagem:**

- Uso de `tx_context::sender` para identificação
- Restrição de acesso baseada em endereço
- Capabilities para editar/excluir links (`EditCap`)
- Padrões de autorização sem variáveis globais
- Validação de permissões antes de operações críticas

Você aprenderá como a Sui Move implementa segurança sem depender de `require` ou `if` no estilo EVM, usando o sistema de capabilities para controle de acesso granular e seguro.

### 🏛️ 3. Modelagem com Move

**Objetivos de aprendizagem:**

- Structs com `vector<u8>` para representar strings
- Funções `entry` para transações
- Organização correta de módulos e imports
- Manipulação de tipos nativos do Move
- Validação de inputs e tratamento de erros
- Boas práticas de design específicas da Sui

Você aprenderá Move de forma contextualizada, aplicando os conceitos da linguagem em um projeto real, entendendo quando e como usar cada recurso da linguagem.

### 📡 4. Emissão e Indexação de Eventos

**Objetivos de aprendizagem:**

- Estruturação de eventos Move (`LinkCreated`, `LinkUpdated`, `LinkDeleted`)
- Emissão de eventos em operações críticas
- Padrões de auditoria e rastreabilidade
- Indexação via Sui Explorer e Indexer
- Consultas de eventos via CLI e APIs

A observabilidade de contratos é essencial em produção, mas costuma ser negligenciada. Você aprenderá a implementar um sistema completo de eventos que permite auditoria e monitoramento das operações.

### 🧪 5. Testes Automatizados em Move

**Objetivos de aprendizagem:**

- Testes unitários com `sui move test`
- Testes de criação e mutação de objetos
- Checagem de permissões e falhas esperadas
- Uso de `#[expected_failure]` para testar aborts
- Validação da emissão de eventos
- Interpretação de abort codes

O projeto serve como um laboratório para ensinar TDD (Test-Driven Development) em Move, cobrindo tanto caminhos de sucesso quanto casos de falha esperados.

### 🌐 6. Integração com Front-end (Sui dApp Kit)

**Objetivos de aprendizagem:**

- Configuração do Sui dApp Kit com React/Next.js
- Conexão de carteira e autenticação
- Chamadas `moveCall` para funções do contrato
- Renderização de objetos on-chain no front-end
- Conversão entre `vector<u8>` e strings legíveis
- Padrões de UX para dApps Sui

Você aprenderá a criar uma interface completa que interage com seu contrato, formando uma base sólida para desenvolvimento full-stack Web3.

### 🔮 7. Extensões Avançadas (Opcional)

**Conceitos avançados para explorar:**

- **Dynamic Fields:** Adicionar metadata dinâmica aos links
- **NFT do Link:** Transformar cada link em um NFT único
- **Hash de URLs:** Implementar privacidade através de hashing
- **Expiração:** Usar clock oracle para links com prazo de validade
- **Pagamento em SUI:** Mecanismo de cobrança na criação de links
- **Capabilities Granulares:** Diferentes níveis de permissão (leitura, edição, exclusão)

Esta progressão modular torna o projeto adequado para diferentes níveis de profundidade, permitindo que alunos mais experientes explorem recursos avançados da plataforma Sui.

> **💼 Valor do Projeto**
>
> Com isso, o SuiSnap se torna uma excelente peça de portfólio e um experimento acadêmico sólido para estudos de blockchain moderna, demonstrando domínio técnico sem a complexidade de casos financeiros ou comerciais. É um projeto simples em conceito, mas muito rico tecnicamente.

---

## 🗺️ Mapa da Jornada

- 📦 [Módulo 0 - Setup e Publicação](#módulo-0---setup-e-publicação)
- 🔷 [Módulo 1 - Programmable Object Model](#módulo-1---programmable-object-model)
- 🔐 [Módulo 2 - Ownership e Autorização](#módulo-2---ownership-e-autorização)
- 🏗️ [Módulo 3 - Modelagem Move](#módulo-3---modelagem-move)
- 📢 [Módulo 4 - Eventos e Auditoria](#módulo-4---eventos-e-auditoria)
- 🧪 [Módulo 5 - Testes Automatizados](#módulo-5---testes-automatizados)
- 💻 [Módulo 6 - Front-end (Sui dApp Kit)](#módulo-6---front-end-sui-dapp-kit)
- ⚡ [Módulo 7 - Extensões Avançadas](#módulo-7---extensões-avançadas)

---

## Módulo 0 - Setup e Publicação

**✅ Objetivo:** Configurar seu ambiente de desenvolvimento e publicar seu primeiro pacote Move na Sui.

### 📋 Pré-requisitos

- Conhecimento básico de programação
- Terminal/CLI básico
- Acesso à internet

### 🔧 Instalação do Sui CLI

Primeiro, vamos instalar o Sui CLI. Escolha o método apropriado para seu sistema operacional:

**Linux/macOS (via curl):**

```bash
curl -fsSL https://get.sui.io | sh
```

**Windows (via PowerShell):**

```powershell
irm https://get.sui.io | iex
```

### 🎯 Configuração Inicial

1. **Criar um novo endereço:**
   ```bash
   sui client new-address ed25519
   ```

2. **Escolher ambiente (devnet recomendado para testes):**
   ```bash
   sui client switch --env devnet
   ```

3. **Obter tokens de teste (se necessário):**
   ```bash
   sui client faucet
   ```

### 📦 Compilação e Testes

No diretório do projeto SuiSnap:

```bash
# Compilar o pacote
sui move build

# Executar testes
sui move test

# Executar testes com filtro
sui move test --filter suisnap
```

### 🚀 Publicação do Pacote

Para publicar seu pacote na devnet:

```bash
sui client publish --gas-budget 500000000 --skip-fetch-latest-gas-price .
```

> **⚠️ Importante:** Anote o `packageId` retornado após a publicação. Você precisará dele nos módulos seguintes para fazer chamadas ao contrato e integrar com o front-end.

### ✅ Verificação

Verifique se seu pacote foi publicado corretamente:

```bash
# Listar objetos do seu endereço
sui client objects --owner <SEU_ENDERECO>

# Inspecionar um objeto específico
sui client object --id <OBJECT_ID>
```

---

## Módulo 1 - Programmable Object Model

**✅ Objetivo:** Entender como objetos funcionam na Sui através da modelagem do struct `Link`.

### 🎯 Conceitos Fundamentais

Na Sui, tudo é um **objeto**. Diferente de blockchains baseadas em contas, onde o estado é armazenado em variáveis globais, na Sui cada dado é um objeto independente com seu próprio **UID** (Unique Identifier).

### 📝 Estrutura do Link

Vamos examinar a estrutura básica do nosso objeto `Link`:

```move
struct Link has key {
    id: UID,
    owner: address,
    original_url: vector<u8>,
    short_code: vector<u8>,
}
```

**Componentes importantes:**

- `has key`: Permite que o struct seja um objeto on-chain
- `UID`: Identificador único do objeto na blockchain
- `owner`: Endereço que possui o objeto
- `vector<u8>`: Representa strings em Move (bytes)

### 🔨 Criando um Link

Para criar um link via CLI:

```bash
sui client call \
  --package <PACKAGE_ID> \
  --module suisnap \
  --function create_link \
  --args "https://exemplo.com" "exemplo" \
  --gas-budget 10000000
```

### 🔍 Inspecionando Objetos

```bash
# Listar todos os objetos do seu endereço
sui client objects --owner <SEU_ENDERECO>

# Ver detalhes de um objeto específico
sui client object --id <LINK_ID> --json
```

### 💡 Exercício Prático

> **Desafio:** Adicione um campo `clicks: u64` ao struct `Link` e crie uma função `entry register_click` que incrementa esse contador. Opcionalmente, emita um evento `ClickRegistered` quando o contador for incrementado.

---

## Módulo 2 - Ownership e Autorização

**✅ Objetivo:** Implementar controle de acesso seguro usando capabilities, sem variáveis globais.

### 🔐 O Padrão Capability

Na Sui, não usamos variáveis globais para controle de acesso. Em vez disso, usamos **capabilities** — objetos especiais que representam permissões. No SuiSnap, usamos `EditCap` para controlar quem pode editar um link.

```move
struct EditCap has key {
    id: UID,
    link_id: ID,
    owner: address,
}
```

### 🛡️ Função de Autorização

A função `enforce_access` verifica duas coisas:

1. O dono da capability é quem está tentando usar
2. A capability pertence ao link correto

```move
fun enforce_access(link: &Link, cap: &EditCap, actor: address) {
    if (cap.owner != actor) {
        abort E_NOT_OWNER
    };
    if (cap.link_id != object::id(link)) {
        abort E_LINK_CAP_MISMATCH
    };
}
```

### ✏️ Atualizando um Link

```bash
sui client call \
  --package <PACKAGE_ID> \
  --module suisnap \
  --function update_link \
  --args <LINK_OBJECT_ID> <EDIT_CAP_OBJECT_ID> "https://nova-url.com" "novo-codigo" \
  --gas-budget 10000000
```

### 🧪 Testando Falhas de Autorização

> **Teste de Segurança:**
> 1. Transfira a `EditCap` para outro endereço
> 2. Tente atualizar o link com a capability transferida
> 3. Observe o abort code `E_NOT_OWNER`

### 💡 Exercício Prático

> **Desafio:** Implemente uma função `transfer_edit_cap` que permite transferir a capability para outro endereço. Adicione validação para evitar transferências não autorizadas (erro `E_CAP_TRANSFER_NOT_ALLOWED`) e teste o comportamento.

---

## Módulo 3 - Modelagem Move

**✅ Objetivo:** Criar APIs Move seguras, legíveis e bem estruturadas com validação adequada.

### ✅ Validação de Dados

É essencial validar todos os inputs do usuário. Vamos implementar validações para:

- **URL:** Deve começar com `http://` ou `https://`
- **Short Code:** Deve ser alfanumérico, com tamanho entre 1 e 50 caracteres
- **Tamanho Máximo:** URLs não podem exceder 2048 caracteres

### 📏 Constantes de Validação

```move
const MAX_URL_LENGTH: u64 = 2048;
const MAX_SHORT_CODE_LENGTH: u64 = 50;
const MIN_SHORT_CODE_LENGTH: u64 = 1;

const E_INVALID_URL: u64 = 3;
const E_INVALID_SHORT_CODE: u64 = 4;
```

### 🔍 Função de Validação de URL

```move
fun validate_url(url: &vector<u8>): bool {
    let len = vector::length(url);
    if (len > MAX_URL_LENGTH || len == 0) {
        return false
    };
    // Verifica se começa com http:// ou https://
    // ... implementação ...
}
```

### 📖 Funções de Leitura

Exponha funções públicas para leitura segura dos dados:

```move
public fun get_url(link: &Link): vector<u8> {
    clone_vector(&link.original_url)
}

public fun get_short_code(link: &Link): vector<u8> {
    clone_vector(&link.short_code)
}

public fun get_owner(link: &Link): address {
    link.owner
}
```

### 💡 Exercícios Práticos

- **Sanitização:** Implemente uma função que remove espaços em branco e caracteres especiais do short code
- **Limite de Tamanho:** Adicione validação para garantir que o short code não exceda o tamanho máximo
- **Helper Functions:** Crie funções auxiliares para converter entre `vector<u8>` e strings legíveis

---

## Módulo 4 - Eventos e Auditoria

**✅ Objetivo:** Tornar todas as transações observáveis e auditáveis através de eventos.

### 📢 Estrutura de Eventos

Eventos na Sui devem ter as abilities `copy` e `drop`:

```move
struct LinkCreated has copy, drop {
    link_id: ID,
    owner: address,
    short_code: vector<u8>,
}

struct LinkUpdated has copy, drop {
    link_id: ID,
    owner: address,
    short_code: vector<u8>,
}

struct LinkDeleted has copy, drop {
    link_id: ID,
    owner: address,
}
```

### 🎯 Emitindo Eventos

```move
public entry fun create_link(...) {
    // ... criação do link ...
    event::emit(LinkCreated {
        link_id,
        owner: sender,
        short_code: clone_vector(&link.short_code),
    });
}
```

### 🔍 Consultando Eventos

**Via CLI:**

```bash
# Consultar eventos do tipo LinkCreated
sui client query-events \
  --move-event-struct <PACKAGE_ID>::suisnap::LinkCreated

# Filtrar por sender
sui client query-events \
  --move-event-struct <PACKAGE_ID>::suisnap::LinkCreated \
  --sender <ENDERECO>
```

**Via Sui Explorer:**

Acesse `https://suiexplorer.com` e navegue até seu pacote para ver todos os eventos emitidos.

### 💡 Exercícios Práticos

- **URL Truncada:** Inclua os primeiros 50 caracteres da URL no evento `LinkCreated` para facilitar auditoria
- **Múltiplos Donos:** Crie um sistema de auditoria que compara eventos de diferentes donos e gera relatórios
- **Evento de Clique:** Se você implementou o contador de cliques, emita um evento `ClickRegistered` a cada clique

---

## Módulo 5 - Testes Automatizados

**✅ Objetivo:** Garantir qualidade e confiabilidade do código através de testes abrangentes.

### 🧪 Estrutura de Testes

Testes em Move usam a API `test_scenario` para simular transações:

```move
#[test]
fun create_sets_owner_and_cap_link_id() {
    let owner = @0xA;
    let scenario = test_scenario::begin(owner);
    {
        let ctx = test_scenario::ctx(&mut scenario);
        let (link, cap) = suisnap::create_link_internal(owner, b"https://sui.io", b"sui", ctx);
        assert!(suisnap::owner(&link) == owner, 0);
        assert!(suisnap::link_id(&cap) == object::id(&link), 0);
        suisnap::delete_link_internal(link, cap, owner);
    };
    test_scenario::end(scenario);
}
```

### ❌ Testando Falhas Esperadas

```move
#[test]
#[expected_failure(abort_code = suisnap::E_NOT_OWNER)]
fun update_rejects_wrong_owner() {
    let owner = @0xC;
    let scenario = test_scenario::begin(owner);
    {
        let ctx = test_scenario::ctx(&mut scenario);
        let (link, cap) = suisnap::create_link_internal(owner, b"https://url", b"code", ctx);
        // Esta chamada deve falhar
        suisnap::update_link_internal(&mut link, &cap, @0xD, b"https://fail", b"bad");
    };
    test_scenario::end(scenario);
}
```

### 🚀 Executando Testes

```bash
# Executar todos os testes
sui move test

# Executar testes com filtro
sui move test --filter suisnap

# Executar com output detalhado
sui move test --verbose
```

### 📊 Interpretando Abort Codes

| Código | Constante | Significado |
|--------|-----------|-------------|
| 1 | `E_NOT_OWNER` | O endereço não é o dono da capability |
| 2 | `E_LINK_CAP_MISMATCH` | A capability não pertence ao link |
| 3 | `E_INVALID_URL` | A URL não é válida |
| 4 | `E_INVALID_SHORT_CODE` | O código curto não é válido |

### 💡 Exercícios Práticos

- **Teste de Capability:** Escreva um teste que verifica `E_LINK_CAP_MISMATCH` quando uma capability de um link é usada em outro
- **Teste de Validação:** Crie testes para URLs inválidas e short codes inválidos
- **Cobertura Completa:** Garanta que todos os caminhos de código estejam cobertos por testes

---

## Módulo 6 - Front-end (Sui dApp Kit)

**✅ Objetivo:** Criar uma interface web funcional que interage com seu contrato Move.

### ⚙️ Configuração Inicial

**Instalação de Dependências:**

```bash
npm install @mysten/dapp-kit @mysten/sui.js @tanstack/react-query
```

**Configuração do Provider:**

```typescript
import { SuiClientProvider, WalletProvider } from '@mysten/dapp-kit';
import { getFullnodeUrl } from '@mysten/sui.js/client';

function App() {
  return (
    <SuiClientProvider networks={{
      devnet: { url: getFullnodeUrl('devnet') }
    }}>
      <WalletProvider>
        {/* Seu app aqui */}
      </WalletProvider>
    </SuiClientProvider>
  );
}
```

### 🔌 Conectando Carteira

```typescript
import { useWallet } from '@mysten/dapp-kit';

function ConnectButton() {
  const { currentWallet, connect, disconnect } = useWallet();
  
  if (currentWallet) {
    return (
      <div>
        <p>Conectado: {currentWallet.name}</p>
        <button onClick={disconnect}>Desconectar</button>
      </div>
    );
  }
  
  return <button onClick={connect}>Conectar Carteira</button>;
}
```

### 📞 Fazendo Chamadas moveCall

```typescript
import { useSignAndExecuteTransaction } from '@mysten/dapp-kit';

function CreateLink() {
  const { mutate: signAndExecute } = useSignAndExecuteTransaction();
  const PACKAGE_ID = '0x...'; // Seu package ID
  
  const handleCreate = () => {
    signAndExecute({
      transaction: {
        kind: 'moveCall',
        data: {
          packageObjectId: PACKAGE_ID,
          module: 'suisnap',
          function: 'create_link',
          arguments: [
            'https://exemplo.com',
            'exemplo'
          ],
        },
      },
    });
  };
  
  return <button onClick={handleCreate}>Criar Link</button>;
}
```

### 📋 Listando Objetos

```typescript
import { useSuiClientQuery } from '@mysten/dapp-kit';

function MyLinks() {
  const { data, isLoading } = useSuiClientQuery('getOwnedObjects', {
    owner: currentAccount?.address,
    filter: { StructType: `${PACKAGE_ID}::suisnap::Link` },
  });
  
  if (isLoading) return <p>Carregando...</p>;
  
  return (
    <ul>
      {data?.data.map((obj) => (
        <li key={obj.data.objectId}>
          {obj.data.objectId}
        </li>
      ))}
    </ul>
  );
}
```

### 💡 Exercícios Práticos

- **Botão Copiar:** Implemente um botão que copia o short code para a área de transferência
- **Abrir URL:** Crie um botão que abre a URL original em uma nova aba
- **Eventos Recentes:** Exiba os últimos eventos de criação/atualização de links em tempo real

---

## Módulo 7 - Extensões Avançadas

**✅ Objetivo:** Explorar recursos avançados da Sui para criar uma dApp completa e profissional.

### 🔗 Dynamic Fields

Use dynamic fields para adicionar metadata extra aos links sem modificar o struct principal:

```move
use sui::dynamic_object_field as ofield;

public fun add_metadata(link: &mut Link, key: vector<u8>, value: vector<u8>) {
    ofield::add(&mut link.id, key, value);
}
```

### 🎨 NFT do Link

Transforme cada link em um NFT único com metadados visuais:

```move
struct LinkNFT has key, store {
    id: UID,
    link_id: ID,
    image_url: vector<u8>,
    description: vector<u8>,
}
```

### ⏰ Expiração de Links

Use o Clock Oracle para implementar expiração automática:

```move
use sui::clock::{Self, Clock};

struct Link has key {
    // ... campos existentes ...
    expires_at: u64,
}

public fun is_expired(link: &Link, clock: &Clock): bool {
    clock::timestamp_ms(clock) > link.expires_at
}
```

### 💰 Cobrança em SUI

Implemente cobrança na criação de links:

```move
use sui::coin::{Self, Coin};
use sui::sui::SUI;

public entry fun create_link_with_payment(
    payment: Coin<SUI>,
    original_url: vector<u8>,
    short_code: vector<u8>,
    ctx: &mut TxContext
) {
    let amount = coin::value(&payment);
    assert!(amount >= 1000000000, E_INSUFFICIENT_PAYMENT); // 1 SUI mínimo
    // ... criar link ...
    coin::burn(payment);
}
```

### 📊 Diagrama de Estados

**Fluxo de Estados do Link:**
`Criado` → `Atualizado` → `Deletado`

**Estados de Erro:**
- `E_NOT_OWNER`: Tentativa de acesso não autorizado
- `E_LINK_CAP_MISMATCH`: Capability incorreta
- `E_INVALID_URL`: URL inválida
- `E_INVALID_SHORT_CODE`: Código curto inválido
- `E_EXPIRED`: Link expirado (se implementado)

### 💡 Exercícios Práticos

- **Split de Pagamento:** Implemente um sistema onde parte do pagamento vai para o criador e parte para um fundo de desenvolvimento
- **Evento de Clique:** Emita eventos detalhados quando um link é acessado, incluindo timestamp e endereço do acessante
- **Renovação:** Permita que usuários renovem links expirados pagando uma taxa

---

## 🎉 Conclusão

**Parabéns!** Se você seguiu esta apostila até o fim, você agora possui:

- ✅ Um pacote Move publicado e totalmente testado na blockchain Sui
- ✅ Um front-end funcional integrado com o Sui dApp Kit
- ✅ Conhecimento profundo de padrões de autorização, eventos e testes
- ✅ Experiência prática com recursos avançados da plataforma Sui

### 🚀 Próximos Passos

- Explore outros projetos na Sui para ver diferentes padrões de design
- Participe da comunidade Sui no Discord e fóruns
- Contribua com código open-source para projetos Sui
- Construa sua própria dApp usando os conhecimentos adquiridos

### 📚 Recursos Adicionais

- [Documentação Oficial do Sui](https://docs.sui.io)
- [Repositório GitHub do Sui](https://github.com/MystenLabs/sui)
- [Sui Explorer](https://suiexplorer.com)
- [Comunidade Discord](https://discord.gg/sui)

---

**© 2024 SuiSnap - Guia de Desenvolvimento**

Desenvolvido com ❤️ para a comunidade Sui
