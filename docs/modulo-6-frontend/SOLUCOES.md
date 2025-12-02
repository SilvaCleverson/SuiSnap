# Módulo 6 — Soluções: Front-end (Sui dApp Kit)

## Exercício 1: Criar Front-end Base

```bash
# Criar projeto Next.js com TypeScript
npx create-next-app@latest suisnap-frontend --typescript --tailwind --app

cd suisnap-frontend

# Instalar dependências Sui
npm install @mysten/dapp-kit @mysten/sui.js @tanstack/react-query
```

**Estrutura esperada:**
```
suisnap-frontend/
├── app/
│   ├── layout.tsx
│   └── page.tsx
├── package.json
└── ...
```

---

## Exercício 2: Conectar Carteira

### Código em `app/layout.tsx`:

```typescript
'use client';

import { SuiClientProvider, WalletProvider } from '@mysten/dapp-kit';
import { getFullnodeUrl } from '@mysten/sui.js/client';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { useState } from 'react';

export default function RootLayout({ children }: { children: React.ReactNode }) {
  const [queryClient] = useState(() => new QueryClient());

  return (
    <html lang="pt-BR">
      <body>
        <QueryClientProvider client={queryClient}>
          <SuiClientProvider networks={{
            devnet: { url: getFullnodeUrl('devnet') },
            mainnet: { url: getFullnodeUrl('mainnet') },
          }}>
            <WalletProvider>
              {children}
            </WalletProvider>
          </SuiClientProvider>
        </QueryClientProvider>
      </body>
    </html>
  );
}
```

### Código em `app/page.tsx`:

```typescript
'use client';

import { useWallet, useSuiClient } from '@mysten/dapp-kit';
import { useEffect, useState } from 'react';

export default function Home() {
  const { currentWallet, connect, disconnect, accounts } = useWallet();
  const client = useSuiClient();
  const [balance, setBalance] = useState<string>('0');

  useEffect(() => {
    if (accounts[0]) {
      client.getBalance({
        owner: accounts[0].address,
      }).then((result) => {
        setBalance((Number(result.totalBalance) / 1e9).toFixed(4));
      });
    }
  }, [accounts, client]);

  return (
    <div className="container mx-auto p-4">
      <h1 className="text-3xl font-bold mb-4">SuiSnap</h1>
      
      {currentWallet ? (
        <div>
          <p>Conectado: {currentWallet.name}</p>
          <p>Endereço: {accounts[0]?.address}</p>
          <p>Saldo: {balance} SUI</p>
          <button 
            onClick={disconnect}
            className="mt-4 px-4 py-2 bg-red-500 text-white rounded"
          >
            Desconectar
          </button>
        </div>
      ) : (
        <button 
          onClick={connect}
          className="px-4 py-2 bg-blue-500 text-white rounded"
        >
          Conectar Carteira
        </button>
      )}
    </div>
  );
}
```

---

## Exercício 3: Chamar `create_link` via moveCall

### Código:

```typescript
'use client';

import { useSignAndExecuteTransaction } from '@mysten/dapp-kit';
import { useState } from 'react';

const PACKAGE_ID = '0x...'; // Seu packageId

export default function CreateLink() {
  const { mutate: signAndExecute, isPending } = useSignAndExecuteTransaction();
  const [url, setUrl] = useState('');
  const [shortCode, setShortCode] = useState('');

  const handleCreate = () => {
    // Converter strings para Uint8Array
    const urlBytes = new Uint8Array(Buffer.from(url));
    const codeBytes = new Uint8Array(Buffer.from(shortCode));

    signAndExecute({
      transaction: {
        kind: 'moveCall',
        data: {
          packageObjectId: PACKAGE_ID,
          module: 'suisnap',
          function: 'create_link',
          arguments: [urlBytes, codeBytes],
        },
      },
    }, {
      onSuccess: (result) => {
        console.log('Link criado!', result);
        setUrl('');
        setShortCode('');
      },
      onError: (error) => {
        console.error('Erro:', error);
      },
    });
  };

  return (
    <div className="p-4">
      <h2 className="text-2xl font-bold mb-4">Criar Link</h2>
      <input
        type="text"
        placeholder="URL"
        value={url}
        onChange={(e) => setUrl(e.target.value)}
        className="border p-2 w-full mb-2"
      />
      <input
        type="text"
        placeholder="Código curto"
        value={shortCode}
        onChange={(e) => setShortCode(e.target.value)}
        className="border p-2 w-full mb-2"
      />
      <button
        onClick={handleCreate}
        disabled={isPending || !url || !shortCode}
        className="px-4 py-2 bg-green-500 text-white rounded disabled:opacity-50"
      >
        {isPending ? 'Criando...' : 'Criar Link'}
      </button>
    </div>
  );
}
```

---

## Exercício 4: Listar Objetos Link

### Código:

```typescript
'use client';

import { useSuiClientQuery } from '@mysten/dapp-kit';
import { useWallet } from '@mysten/dapp-kit';

const PACKAGE_ID = '0x...'; // Seu packageId

export default function MyLinks() {
  const { accounts } = useWallet();
  const owner = accounts[0]?.address;

  const { data, isLoading, error } = useSuiClientQuery('getOwnedObjects', {
    owner: owner || '',
    filter: {
      StructType: `${PACKAGE_ID}::suisnap::Link`,
    },
    options: {
      showContent: true,
      showType: true,
    },
  });

  if (isLoading) return <p>Carregando...</p>;
  if (error) return <p>Erro: {error.message}</p>;

  return (
    <div className="p-4">
      <h2 className="text-2xl font-bold mb-4">Meus Links</h2>
      <ul>
        {data?.data.map((obj) => {
          const content = obj.data?.content as any;
          const url = content?.fields?.original_url;
          const code = content?.fields?.short_code;
          
          // Converter bytes para string
          const urlStr = url ? Buffer.from(url).toString() : '';
          const codeStr = code ? Buffer.from(code).toString() : '';

          return (
            <li key={obj.data.objectId} className="border p-2 mb-2">
              <p><strong>ID:</strong> {obj.data.objectId}</p>
              <p><strong>URL:</strong> {urlStr}</p>
              <p><strong>Código:</strong> {codeStr}</p>
            </li>
          );
        })}
      </ul>
    </div>
  );
}
```

---

## Exercício 5: Atualizar Link

### Código:

```typescript
'use client';

import { useSignAndExecuteTransaction } from '@mysten/dapp-kit';
import { useState } from 'react';

export default function UpdateLink({ linkId, capId }: { linkId: string; capId: string }) {
  const { mutate: signAndExecute, isPending } = useSignAndExecuteTransaction();
  const [newUrl, setNewUrl] = useState('');
  const [newCode, setNewCode] = useState('');

  const handleUpdate = () => {
    const urlBytes = new Uint8Array(Buffer.from(newUrl));
    const codeBytes = new Uint8Array(Buffer.from(newCode));

    signAndExecute({
      transaction: {
        kind: 'moveCall',
        data: {
          packageObjectId: PACKAGE_ID,
          module: 'suisnap',
          function: 'update_link',
          arguments: [
            linkId,
            capId,
            urlBytes,
            codeBytes,
          ],
        },
      },
    });
  };

  return (
    <div>
      <input
        type="text"
        placeholder="Nova URL"
        value={newUrl}
        onChange={(e) => setNewUrl(e.target.value)}
        className="border p-2"
      />
      <input
        type="text"
        placeholder="Novo código"
        value={newCode}
        onChange={(e) => setNewCode(e.target.value)}
        className="border p-2"
      />
      <button
        onClick={handleUpdate}
        disabled={isPending}
        className="px-4 py-2 bg-blue-500 text-white rounded"
      >
        Atualizar
      </button>
    </div>
  );
}
```

---

## Exercício 6: UX Extra

### Botão Copiar:

```typescript
const copyToClipboard = (text: string) => {
  navigator.clipboard.writeText(text);
  alert('Copiado!');
};

<button onClick={() => copyToClipboard(shortCode)}>
  Copiar código
</button>
```

### Abrir URL:

```typescript
<a 
  href={url} 
  target="_blank" 
  rel="noopener noreferrer"
  className="text-blue-500 underline"
>
  Abrir URL
</a>
```

### Exibir Eventos Recentes:

```typescript
const { data: events } = useSuiClientQuery('queryEvents', {
  query: {
    MoveEventType: `${PACKAGE_ID}::suisnap::LinkCreated`,
  },
  limit: 10,
});

// Renderizar eventos
{events?.data.map((event) => (
  <div key={event.id}>
    <p>Evento: {event.type}</p>
    <p>Sender: {event.sender}</p>
  </div>
))}
```

---

## ✅ Checklist de Conclusão

- [ ] Projeto Next.js criado e configurado
- [ ] Sui dApp Kit instalado e configurado
- [ ] Carteira conectada e dados exibidos
- [ ] Função `create_link` chamada via moveCall
- [ ] Objetos Link listados e renderizados
- [ ] Função `update_link` implementada
- [ ] UX extra implementada (copiar, abrir URL, eventos)

