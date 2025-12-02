# 🚀 SuiSnap

> **Encurtador de links on-chain** construído em Move para a blockchain Sui. Um projeto didático completo que ensina os fundamentos do desenvolvimento em Sui através de uma aplicação prática e progressiva.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Sui](https://img.shields.io/badge/Built%20on-Sui-6fbcf0)](https://sui.io)
[![Move](https://img.shields.io/badge/Language-Move-00d4ff)](https://github.com/move-language/move)

**🌐 Idiomas:** [English](README.md) | [Português](README.pt.md) | [Español](README.es.md)

---

## 📖 Sobre o Projeto

O **SuiSnap** é um encurtador de links descentralizado que funciona como uma trilha didática completa para aprender desenvolvimento em **Move** na blockchain **Sui**. Cada link encurtado se torna um objeto autônomo na Sui, permitindo explorar profundamente o modelo de objetos único da plataforma.

### 🎯 Objetivo Didático

Este projeto não visa competir com encurtadores comerciais, mas sim demonstrar de forma prática e organizada os principais conceitos da arquitetura Sui:

- ✅ Criação e gerenciamento de objetos on-chain
- ✅ Manipulação de propriedade e permissões
- ✅ Uso de capabilities para controle de acesso
- ✅ Emissão de eventos para auditoria
- ✅ Boas práticas de modelagem em Move

---

## 🔄 Referência Rápida: Termos Leigos → Move/Sui

Um mapeamento rápido de conceitos do dia a dia para terminologia Sui/Move para ajudar iniciantes a entender o código:

| 🧑‍💼 **Termo Leigo** | 🔧 **Equivalente Move/Sui** | 📝 **Explicação** |
|----------------------|---------------------------|-------------------|
| **Dono** | `owner: address` | O endereço que possui o objeto e pode movê-lo/transferi-lo de acordo com as regras do contrato |
| **CPF do Objeto** | `UID` / `ID` | Identificador único global para objetos com `has key` - como um CPF para objetos na blockchain |
| **Cartão de Permissão** | `Capability` / `EditCap` | Um objeto-prova que autoriza ações específicas (como editar/excluir um Link) - pense como um cartão de acesso |
| **Quem Enviou** | `tx_context::sender` | O endereço que assinou e enviou a transação - o "quem" por trás de cada ação |
| **Evento** | `LinkCreated` / `LinkUpdated` / `LinkDeleted` | Recibo público de uma ação, registrado permanentemente on-chain e consultável via Explorer/CLI - como um log de transações |
| **Função de Entrada** | `public entry fun` | Função voltada ao usuário que valida regras e aborta se violadas - a "porta da frente" do seu contrato |

### 💡 Dicas Rápidas

- **UID vs ID**: `UID` é criado quando o objeto nasce, `ID` é derivado dele e usado para referências
- **Padrão Capability**: Em vez de verificar estado global, Sui usa objetos-prova transferíveis (capabilities) para autorização
- **Eventos são Imutáveis**: Uma vez emitidos, eventos são permanentes e podem ser consultados para sempre - perfeito para auditoria

---

## ✨ Características

- 🔷 **Programmable Object Model**: Cada link é um objeto on-chain com UID único
- 🔐 **Capabilities Pattern**: Sistema de autorização seguro sem variáveis globais
- 📡 **Eventos On-chain**: Auditoria completa com `LinkCreated`, `LinkUpdated`, `LinkDeleted`
- ✅ **Validação Robusta**: Validação de URLs e códigos curtos
- 🧪 **Testes Completos**: Cobertura de testes unitários com casos de sucesso e falha
- 📚 **Documentação Completa**: Apostila detalhada e módulos passo a passo
- 🌐 **Front-end Ready**: Preparado para integração com Sui dApp Kit

---

## 📚 Estrutura da Trilha Didática

O projeto está organizado em **8 módulos progressivos**, cada um cobrindo aspectos essenciais do desenvolvimento Sui:

| Módulo | Tópico | Descrição |
|--------|--------|-----------|
| **0** | Setup e Publicação | Ambiente, Sui CLI, build, testes e publicação do pacote |
| **1** | Programmable Object Model | Objeto `Link` (UID, owner, short_code), mutabilidade, transferências |
| **2** | Ownership e Autorização | `tx_context::sender`, capabilities (`EditCap`), restrições por endereço |
| **3** | Modelagem Move | Validação de URL/shortcode, erros customizados, boas práticas |
| **4** | Eventos e Auditoria | Eventos `LinkCreated/Updated/Deleted`, consulta via CLI/Explorer |
| **5** | Testes Automatizados | `sui move test`, casos felizes e `#[expected_failure]` |
| **6** | Front-end (Sui dApp Kit) | moveCall, listar objetos, integração React/Next.js |
| **7** | Extensões Avançadas | Dynamic fields, NFT, hash, expiração, cobrança em SUI |

📖 **Documentação detalhada**: Cada módulo possui um README específico em `docs/modulo-*/README.md`  
📘 **Apostila completa**: Disponível em três idiomas:
  - [`handbook.en.md`](handbook.en.md) (English)
  - [`apostila.pt.md`](apostila.pt.md) (Português)
  - [`apostila.es.md`](apostila.es.md) (Español)

---

## 🚀 Início Rápido

### Pré-requisitos

- [Sui CLI](https://docs.sui.io/build/install) instalada e configurada
- Ambiente configurado (devnet ou localnet)
- (Opcional) Node.js para desenvolvimento front-end

### Instalação

1. **Clone o repositório**
   ```bash
   git clone https://github.com/SilvaCleverson/SuiSnap.git
   cd SuiSnap
   ```

2. **Compile o pacote**
   ```bash
   sui move build
   ```

3. **Execute os testes**
   ```bash
   sui move test
   ```

4. **Publique na devnet** (após configurar sua carteira)
   ```bash
   sui client publish --gas-budget 500000000 --skip-fetch-latest-gas-price .
   ```
   ⚠️ **Importante**: Anote o `packageId` retornado para usar nas chamadas ao contrato.

---

## 💻 Uso

### Criar um Link Encurtado

```bash
sui client call \
  --package <PACKAGE_ID> \
  --module suisnap \
  --function create_link \
  --args "vector<u8>:https://exemplo.com" "vector<u8>:abc" \
  --gas-budget 20000000
```

### Atualizar um Link

```bash
sui client call \
  --package <PACKAGE_ID> \
  --module suisnap \
  --function update_link \
  --args object:<LINK_ID> object:<EDIT_CAP_ID> \
    "vector<u8>:https://novo.com" "vector<u8>:novo" \
  --gas-budget 20000000
```

### Consultar Eventos

```bash
# Eventos de criação
sui client query-events \
  --move-event-struct <PACKAGE_ID>::suisnap::LinkCreated

# Eventos de atualização
sui client query-events \
  --move-event-struct <PACKAGE_ID>::suisnap::LinkUpdated
```

### Listar Objetos do Usuário

```bash
sui client objects --owner <SEU_ENDERECO>
```

---

## 📁 Estrutura do Projeto

```
SuiSnap/
├── Move.toml              # Manifest do pacote Move
├── sources/
│   └── suisnap.move       # Módulo principal do contrato
├── tests/
│   └── suisnap_tests.move # Testes unitários
├── handbook.en.md         # Complete handbook (English)
├── apostila.pt.md         # Apostila completa (Português)
├── apostila.es.md         # Manual completo (Español)
├── docs/
│   ├── apostila.html      # Apostila (HTML)
│   ├── README.md          # Índice da documentação
│   └── modulo-*/          # Documentação por módulo
├── LICENSE                # Licença MIT
└── README.md              # Este arquivo
```

---

## 🧪 Testes

O projeto inclui uma suíte completa de testes cobrindo:

- ✅ Criação de links
- ✅ Atualização de links
- ✅ Validação de permissões
- ✅ Tratamento de erros (`E_NOT_OWNER`, `E_LINK_CAP_MISMATCH`)
- ✅ Funções de leitura (`get_url`, `get_short_code`, `get_owner`)

Execute os testes:

```bash
# Todos os testes
sui move test

# Testes com filtro
sui move test --filter suisnap

# Testes com output detalhado
sui move test --verbose
```

---

## 📖 Documentação

- **📘 Apostila Completa**: Disponível em três idiomas:
  - [`handbook.en.md`](handbook.en.md) - English
  - [`apostila.pt.md`](apostila.pt.md) - Português
  - [`apostila.es.md`](apostila.es.md) - Español
- **📚 Módulos Individuais**: Documentação específica em `docs/modulo-*/README.md`
- **🌐 Versão HTML**: [`docs/apostila.html`](docs/apostila.html) - Apostila formatada para web
- **📄 PDF**: [`docs/Apostila LinkPass Sui - Guia de Desenvolvimento.pdf`](docs/Apostila%20LinkPass%20Sui%20-%20Guia%20de%20Desenvolvimento.pdf)

---

## 🛠️ Tecnologias

- **Move**: Linguagem de smart contracts da Sui
- **Sui Blockchain**: Plataforma de blockchain de alta performance
- **Sui CLI**: Ferramentas de linha de comando
- **Sui dApp Kit**: (Opcional) Para integração front-end

---

## 🗺️ Roadmap

- [ ] Validação avançada de URLs e short codes
- [ ] Contador de cliques com evento `ClickRegistered`
- [ ] Front-end completo com Sui dApp Kit
- [ ] Dynamic fields para metadata
- [ ] Sistema de expiração de links
- [ ] Mecanismo de pagamento em SUI

---

## 🤝 Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para:

1. Fazer fork do projeto
2. Criar uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abrir um Pull Request

---

## 📝 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

---

## 🔗 Links Úteis

- [Documentação Oficial do Sui](https://docs.sui.io)
- [Repositório do Sui](https://github.com/MystenLabs/sui)
- [Sui Explorer](https://suiexplorer.com)
- [Comunidade Discord do Sui](https://discord.gg/sui)

---

## 👤 Autor

**SilvaCleverson**

- GitHub: [@SilvaCleverson](https://github.com/SilvaCleverson)
- Projeto: [SuiSnap](https://github.com/SilvaCleverson/SuiSnap)

---

## ⭐ Agradecimentos

- Comunidade Sui pelo excelente ecossistema
- Mysten Labs pela plataforma inovadora
- Todos os contribuidores e aprendizes que utilizam este projeto

---

<div align="center">

**Feito com ❤️ para a comunidade Sui**

⭐ Se este projeto foi útil para você, considere dar uma estrela!

</div>

