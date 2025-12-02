# 🚀 SuiSnap

**Guía de Desarrollo en Move para Blockchain Sui**

---

## 📖 Presentación

¡Bienvenido a la guía sobre desarrollo en **Move** en la blockchain **Sui**! Esta guía práctica fue creada para ayudarte a aprender a construir aplicaciones descentralizadas (dApps) usando el proyecto SuiSnap como ejemplo.

A través del proyecto **SuiSnap** — un acortador de enlaces on-chain — aprenderás los conceptos fundamentales del ecosistema Sui de forma práctica e incremental. Al final de este viaje, tendrás el conocimiento para modelar objetos, implementar autorización, emitir eventos, escribir pruebas e integrar con front-end.

> **🎯 Propósito Didáctico de SuiSnap**
>
> La idea no es competir con acortadores comerciales, sino crear un proyecto didáctico que permita demostrar, de forma práctica y organizada, los principales conceptos de la arquitectura de Sui:
>
> - Creación y gestión de objetos on-chain
> - Manipulación de propiedad y permisos
> - Uso de capabilities para control de acceso
> - Emisión de eventos para auditoría
> - Buenas prácticas de modelado en Move
>
> Cada enlace acortado se convierte en un objeto autónomo en Sui, permitiendo explorar profundamente su modelo de objetos — que es precisamente el diferenciador académico de la plataforma. Es un proyecto simple en concepto, pero muy rico técnicamente, adecuado para demostrar dominio de Sui/Move, arquitectura Web3 y desarrollo seguro en blockchain.

> **🔷 ¿Por qué Move y Sui?**
>
> Move es un lenguaje de contratos inteligentes diseñado específicamente para seguridad de memoria y el modelo de objetos único de Sui. A diferencia de blockchains basadas en cuentas (como Ethereum), Sui utiliza un **Programmable Object Model** que permite mayor flexibilidad, escalabilidad y seguridad.

---

## 🎓 Lo que Aprenderás

El proyecto SuiSnap ha sido estructurado para cubrir los principales aspectos técnicos de Sui de forma progresiva. Cada módulo se construye sobre el anterior, permitiendo una comprensión gradual y práctica de los conceptos.

### 🔧 1. Programmable Object Model (Núcleo de Sui)

**Objetivos de aprendizaje:**

- Creación de objetos usando `has key`
- Persistencia on-chain vía `UID`
- Mutabilidad controlada de objetos
- Transferencia de objetos entre direcciones
- Estructuración de datos stateful

Cada enlace acortado se convierte en un objeto on-chain, demostrando cómo Sui difiere de blockchains basadas en cuentas. Entenderás en la práctica el modelo de objetos que es el diferenciador de la plataforma.

### 🔑 2. Propiedad y Autorización

**Objetivos de aprendizaje:**

- Uso de `tx_context::sender` para identificación
- Restricción de acceso basada en dirección
- Capabilities para editar/eliminar enlaces (`EditCap`)
- Patrones de autorización sin variables globales
- Validación de permisos antes de operaciones críticas

Aprenderás cómo Sui Move implementa seguridad sin depender de `require` o `if` al estilo EVM, usando el sistema de capabilities para control de acceso granular y seguro.

### 🏛️ 3. Modelado con Move

**Objetivos de aprendizaje:**

- Structs con `vector<u8>` para representar strings
- Funciones `entry` para transacciones
- Organización correcta de módulos e imports
- Manipulación de tipos nativos de Move
- Validación de inputs y manejo de errores
- Buenas prácticas de diseño específicas de Sui

Aprenderás Move de forma contextualizada, aplicando los conceptos del lenguaje en un proyecto real, entendiendo cuándo y cómo usar cada característica del lenguaje.

### 📡 4. Emisión e Indexación de Eventos

**Objetivos de aprendizaje:**

- Estructuración de eventos Move (`LinkCreated`, `LinkUpdated`, `LinkDeleted`)
- Emisión de eventos en operaciones críticas
- Patrones de auditoría y trazabilidad
- Indexación vía Sui Explorer e Indexer
- Consultas de eventos vía CLI y APIs

La observabilidad de contratos es esencial en producción, pero suele ser descuidada. Aprenderás a implementar un sistema completo de eventos que permite auditoría y monitoreo de las operaciones.

### 🧪 5. Pruebas Automatizadas en Move

**Objetivos de aprendizaje:**

- Pruebas unitarias con `sui move test`
- Pruebas de creación y mutación de objetos
- Verificación de permisos y fallos esperados
- Uso de `#[expected_failure]` para probar aborts
- Validación de la emisión de eventos
- Interpretación de códigos de abort

El proyecto sirve como un laboratorio para enseñar TDD (Test-Driven Development) en Move, cubriendo tanto caminos de éxito como casos de fallo esperados.

### 🌐 6. Integración con Front-end (Sui dApp Kit)

**Objetivos de aprendizaje:**

- Configuración de Sui dApp Kit con React/Next.js
- Conexión de cartera y autenticación
- Llamadas `moveCall` a funciones del contrato
- Renderizado de objetos on-chain en el front-end
- Conversión entre `vector<u8>` y strings legibles
- Patrones de UX para dApps Sui

Aprenderás a crear una interfaz completa que interactúa con tu contrato, formando una base sólida para desarrollo full-stack Web3.

### 🔮 7. Extensiones Avanzadas (Opcional)

**Conceptos avanzados para explorar:**

- **Dynamic Fields:** Agregar metadata dinámica a los enlaces
- **NFT del Enlace:** Transformar cada enlace en un NFT único
- **Hash de URLs:** Implementar privacidad a través de hashing
- **Expiración:** Usar clock oracle para enlaces con plazo de validez
- **Pago en SUI:** Mecanismo de cobro en la creación de enlaces
- **Capabilities Granulares:** Diferentes niveles de permiso (lectura, edición, eliminación)

Esta progresión modular hace que el proyecto sea adecuado para diferentes niveles de profundidad, permitiendo que estudiantes más experimentados exploren características avanzadas de la plataforma Sui.

> **💼 Valor del Proyecto**
>
> Con esto, SuiSnap se convierte en una excelente pieza de portafolio y un experimento académico sólido para estudios de blockchain moderna, demostrando dominio técnico sin la complejidad de casos financieros o comerciales. Es un proyecto simple en concepto, pero muy rico técnicamente.

---

## 🗺️ Mapa del Viaje

- 📦 [Módulo 0 - Configuración y Publicación](#módulo-0---configuración-y-publicación)
- 🔷 [Módulo 1 - Programmable Object Model](#módulo-1---programmable-object-model)
- 🔐 [Módulo 2 - Propiedad y Autorización](#módulo-2---propiedad-y-autorización)
- 🏗️ [Módulo 3 - Modelado Move](#módulo-3---modelado-move)
- 📢 [Módulo 4 - Eventos y Auditoría](#módulo-4---eventos-y-auditoría)
- 🧪 [Módulo 5 - Pruebas Automatizadas](#módulo-5---pruebas-automatizadas)
- 💻 [Módulo 6 - Front-end (Sui dApp Kit)](#módulo-6---front-end-sui-dapp-kit)
- ⚡ [Módulo 7 - Extensiones Avanzadas](#módulo-7---extensiones-avanzadas)

---

## Módulo 0 - Configuración y Publicación

**✅ Objetivo:** Configurar tu entorno de desarrollo y publicar tu primer paquete Move en Sui.

### 📋 Prerrequisitos

- Conocimiento básico de programación
- Terminal/CLI básico
- Acceso a internet

### 🔧 Instalación de Sui CLI

Primero, instalemos el Sui CLI. Elige el método apropiado para tu sistema operativo:

**Linux/macOS (vía curl):**

```bash
curl -fsSL https://get.sui.io | sh
```

**Windows (vía PowerShell):**

```powershell
irm https://get.sui.io | iex
```

### 🎯 Configuración Inicial

1. **Crear una nueva dirección:**
   ```bash
   sui client new-address ed25519
   ```

2. **Elegir entorno (devnet recomendado para pruebas):**
   ```bash
   sui client switch --env devnet
   ```

3. **Obtener tokens de prueba (si es necesario):**
   ```bash
   sui client faucet
   ```

### 📦 Compilación y Pruebas

En el directorio del proyecto SuiSnap:

```bash
# Compilar el paquete
sui move build

# Ejecutar pruebas
sui move test

# Ejecutar pruebas con filtro
sui move test --filter suisnap
```

### 🚀 Publicación del Paquete

Para publicar tu paquete en devnet:

```bash
sui client publish --gas-budget 500000000 --skip-fetch-latest-gas-price .
```

> **⚠️ Importante:** Anota el `packageId` devuelto después de la publicación. Lo necesitarás en los módulos siguientes para hacer llamadas al contrato e integrar con el front-end.

### ✅ Verificación

Verifica que tu paquete fue publicado correctamente:

```bash
# Listar objetos de tu dirección
sui client objects --owner <TU_DIRECCIÓN>

# Inspeccionar un objeto específico
sui client object --id <OBJECT_ID>
```

---

## Módulo 1 - Programmable Object Model

**✅ Objetivo:** Entender cómo funcionan los objetos en Sui a través del modelado del struct `Link`.

### 🎯 Conceptos Fundamentales

En Sui, todo es un **objeto**. A diferencia de blockchains basadas en cuentas, donde el estado se almacena en variables globales, en Sui cada dato es un objeto independiente con su propio **UID** (Unique Identifier).

### 📝 Estructura del Link

Examinemos la estructura básica de nuestro objeto `Link`:

```move
struct Link has key {
    id: UID,
    owner: address,
    original_url: vector<u8>,
    short_code: vector<u8>,
}
```

**Componentes importantes:**

- `has key`: Permite que el struct sea un objeto on-chain
- `UID`: Identificador único del objeto en la blockchain
- `owner`: Dirección que posee el objeto
- `vector<u8>`: Representa strings en Move (bytes)

### 🔨 Creando un Link

Para crear un enlace vía CLI:

```bash
sui client call \
  --package <PACKAGE_ID> \
  --module suisnap \
  --function create_link \
  --args "https://ejemplo.com" "ejemplo" \
  --gas-budget 10000000
```

### 🔍 Inspeccionando Objetos

```bash
# Listar todos los objetos de tu dirección
sui client objects --owner <TU_DIRECCIÓN>

# Ver detalles de un objeto específico
sui client object --id <LINK_ID> --json
```

### 💡 Ejercicio Práctico

> **Desafío:** Agrega un campo `clicks: u64` al struct `Link` y crea una función `entry register_click` que incremente este contador. Opcionalmente, emite un evento `ClickRegistered` cuando el contador sea incrementado.

---

## Módulo 2 - Propiedad y Autorización

**✅ Objetivo:** Implementar control de acceso seguro usando capabilities, sin variables globales.

### 🔐 El Patrón Capability

En Sui, no usamos variables globales para control de acceso. En su lugar, usamos **capabilities** — objetos especiales que representan permisos. En SuiSnap, usamos `EditCap` para controlar quién puede editar un enlace.

```move
struct EditCap has key {
    id: UID,
    link_id: ID,
    owner: address,
}
```

### 🛡️ Función de Autorización

La función `enforce_access` verifica dos cosas:

1. El dueño de la capability es quien está intentando usarla
2. La capability pertenece al enlace correcto

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

### ✏️ Actualizando un Link

```bash
sui client call \
  --package <PACKAGE_ID> \
  --module suisnap \
  --function update_link \
  --args <LINK_OBJECT_ID> <EDIT_CAP_OBJECT_ID> "https://nueva-url.com" "nuevo-codigo" \
  --gas-budget 10000000
```

### 🧪 Probando Fallos de Autorización

> **Prueba de Seguridad:**
> 1. Transfiere la `EditCap` a otra dirección
> 2. Intenta actualizar el enlace con la capability transferida
> 3. Observa el código de abort `E_NOT_OWNER`

### 💡 Ejercicio Práctico

> **Desafío:** Implementa una función `transfer_edit_cap` que permita transferir la capability a otra dirección. Agrega validación para evitar transferencias no autorizadas (error `E_CAP_TRANSFER_NOT_ALLOWED`) y prueba el comportamiento.

---

## Módulo 3 - Modelado Move

**✅ Objetivo:** Crear APIs Move seguras, legibles y bien estructuradas con validación adecuada.

### ✅ Validación de Datos

Es esencial validar todos los inputs del usuario. Implementemos validaciones para:

- **URL:** Debe comenzar con `http://` o `https://`
- **Short Code:** Debe ser alfanumérico, con tamaño entre 1 y 50 caracteres
- **Tamaño Máximo:** Las URLs no pueden exceder 2048 caracteres

### 📏 Constantes de Validación

```move
const MAX_URL_LENGTH: u64 = 2048;
const MAX_SHORT_CODE_LENGTH: u64 = 50;
const MIN_SHORT_CODE_LENGTH: u64 = 1;

const E_INVALID_URL: u64 = 3;
const E_INVALID_SHORT_CODE: u64 = 4;
```

### 🔍 Función de Validación de URL

```move
fun validate_url(url: &vector<u8>): bool {
    let len = vector::length(url);
    if (len > MAX_URL_LENGTH || len == 0) {
        return false
    };
    // Verifica si comienza con http:// o https://
    // ... implementación ...
}
```

### 📖 Funciones de Lectura

Expone funciones públicas para lectura segura de los datos:

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

### 💡 Ejercicios Prácticos

- **Sanitización:** Implementa una función que elimine espacios en blanco y caracteres especiales del short code
- **Límite de Tamaño:** Agrega validación para garantizar que el short code no exceda el tamaño máximo
- **Funciones Auxiliares:** Crea funciones auxiliares para convertir entre `vector<u8>` y strings legibles

---

## Módulo 4 - Eventos y Auditoría

**✅ Objetivo:** Hacer que todas las transacciones sean observables y auditables a través de eventos.

### 📢 Estructura de Eventos

Los eventos en Sui deben tener las abilities `copy` y `drop`:

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

### 🎯 Emitiendo Eventos

```move
public entry fun create_link(...) {
    // ... creación del enlace ...
    event::emit(LinkCreated {
        link_id,
        owner: sender,
        short_code: clone_vector(&link.short_code),
    });
}
```

### 🔍 Consultando Eventos

**Vía CLI:**

```bash
# Consultar eventos del tipo LinkCreated
sui client query-events \
  --move-event-struct <PACKAGE_ID>::suisnap::LinkCreated

# Filtrar por sender
sui client query-events \
  --move-event-struct <PACKAGE_ID>::suisnap::LinkCreated \
  --sender <DIRECCIÓN>
```

**Vía Sui Explorer:**

Accede a `https://suiexplorer.com` y navega hasta tu paquete para ver todos los eventos emitidos.

### 💡 Ejercicios Prácticos

- **URL Truncada:** Incluye los primeros 50 caracteres de la URL en el evento `LinkCreated` para facilitar auditoría
- **Múltiples Dueños:** Crea un sistema de auditoría que compare eventos de diferentes dueños y genere reportes
- **Evento de Clic:** Si implementaste el contador de clics, emite un evento `ClickRegistered` en cada clic

---

## Módulo 5 - Pruebas Automatizadas

**✅ Objetivo:** Garantizar calidad y confiabilidad del código a través de pruebas exhaustivas.

### 🧪 Estructura de Pruebas

Las pruebas en Move usan la API `test_scenario` para simular transacciones:

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

### ❌ Probando Fallos Esperados

```move
#[test]
#[expected_failure(abort_code = suisnap::E_NOT_OWNER)]
fun update_rejects_wrong_owner() {
    let owner = @0xC;
    let scenario = test_scenario::begin(owner);
    {
        let ctx = test_scenario::ctx(&mut scenario);
        let (link, cap) = suisnap::create_link_internal(owner, b"https://url", b"code", ctx);
        // Esta llamada debe fallar
        suisnap::update_link_internal(&mut link, &cap, @0xD, b"https://fail", b"bad");
    };
    test_scenario::end(scenario);
}
```

### 🚀 Ejecutando Pruebas

```bash
# Ejecutar todas las pruebas
sui move test

# Ejecutar pruebas con filtro
sui move test --filter suisnap

# Ejecutar con salida detallada
sui move test --verbose
```

### 📊 Interpretando Códigos de Abort

| Código | Constante | Significado |
|--------|-----------|-------------|
| 1 | `E_NOT_OWNER` | La dirección no es el dueño de la capability |
| 2 | `E_LINK_CAP_MISMATCH` | La capability no pertenece al enlace |
| 3 | `E_INVALID_URL` | La URL no es válida |
| 4 | `E_INVALID_SHORT_CODE` | El código corto no es válido |

### 💡 Ejercicios Prácticos

- **Prueba de Capability:** Escribe una prueba que verifique `E_LINK_CAP_MISMATCH` cuando una capability de un enlace se usa en otro
- **Prueba de Validación:** Crea pruebas para URLs inválidas y códigos cortos inválidos
- **Cobertura Completa:** Garantiza que todos los caminos de código estén cubiertos por pruebas

---

## Módulo 6 - Front-end (Sui dApp Kit)

**✅ Objetivo:** Crear una interfaz web funcional que interactúe con tu contrato Move.

### ⚙️ Configuración Inicial

**Instalación de Dependencias:**

```bash
npm install @mysten/dapp-kit @mysten/sui.js @tanstack/react-query
```

**Configuración del Provider:**

```typescript
import { SuiClientProvider, WalletProvider } from '@mysten/dapp-kit';
import { getFullnodeUrl } from '@mysten/sui.js/client';

function App() {
  return (
    <SuiClientProvider networks={{
      devnet: { url: getFullnodeUrl('devnet') }
    }}>
      <WalletProvider>
        {/* Tu app aquí */}
      </WalletProvider>
    </SuiClientProvider>
  );
}
```

### 🔌 Conectando Cartera

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
  
  return <button onClick={connect}>Conectar Cartera</button>;
}
```

### 📞 Haciendo Llamadas moveCall

```typescript
import { useSignAndExecuteTransaction } from '@mysten/dapp-kit';

function CreateLink() {
  const { mutate: signAndExecute } = useSignAndExecuteTransaction();
  const PACKAGE_ID = '0x...'; // Tu package ID
  
  const handleCreate = () => {
    signAndExecute({
      transaction: {
        kind: 'moveCall',
        data: {
          packageObjectId: PACKAGE_ID,
          module: 'suisnap',
          function: 'create_link',
          arguments: [
            'https://ejemplo.com',
            'ejemplo'
          ],
        },
      },
    });
  };
  
  return <button onClick={handleCreate}>Crear Enlace</button>;
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
  
  if (isLoading) return <p>Cargando...</p>;
  
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

### 💡 Ejercicios Prácticos

- **Botón Copiar:** Implementa un botón que copie el código corto al portapapeles
- **Abrir URL:** Crea un botón que abra la URL original en una nueva pestaña
- **Eventos Recientes:** Muestra los últimos eventos de creación/actualización de enlaces en tiempo real

---

## Módulo 7 - Extensiones Avanzadas

**✅ Objetivo:** Explorar características avanzadas de Sui para crear una dApp completa y profesional.

### 🔗 Dynamic Fields

Usa dynamic fields para agregar metadata extra a los enlaces sin modificar el struct principal:

```move
use sui::dynamic_object_field as ofield;

public fun add_metadata(link: &mut Link, key: vector<u8>, value: vector<u8>) {
    ofield::add(&mut link.id, key, value);
}
```

### 🎨 NFT del Enlace

Transforma cada enlace en un NFT único con metadata visual:

```move
struct LinkNFT has key, store {
    id: UID,
    link_id: ID,
    image_url: vector<u8>,
    description: vector<u8>,
}
```

### ⏰ Expiración de Enlaces

Usa el Clock Oracle para implementar expiración automática:

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

### 💰 Cobro en SUI

Implementa cobro en la creación de enlaces:

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
    assert!(amount >= 1000000000, E_INSUFFICIENT_PAYMENT); // Mínimo 1 SUI
    // ... crear enlace ...
    coin::burn(payment);
}
```

### 📊 Diagrama de Estados

**Flujo de Estados del Enlace:**
`Creado` → `Actualizado` → `Eliminado`

**Estados de Error:**
- `E_NOT_OWNER`: Intento de acceso no autorizado
- `E_LINK_CAP_MISMATCH`: Capability incorrecta
- `E_INVALID_URL`: URL inválida
- `E_INVALID_SHORT_CODE`: Código corto inválido
- `E_EXPIRED`: Enlace expirado (si se implementa)

### 💡 Ejercicios Prácticos

- **División de Pago:** Implementa un sistema donde parte del pago va al creador y parte a un fondo de desarrollo
- **Evento de Clic:** Emite eventos detallados cuando se accede a un enlace, incluyendo timestamp y dirección del accesante
- **Renovación:** Permite que los usuarios renueven enlaces expirados pagando una tarifa

---

## 🎉 Conclusión

**¡Felicitaciones!** Si seguiste esta guía hasta el final, ahora tienes:

- ✅ Un paquete Move publicado y totalmente probado en la blockchain Sui
- ✅ Un front-end funcional integrado con Sui dApp Kit
- ✅ Conocimiento profundo de patrones de autorización, eventos y pruebas
- ✅ Experiencia práctica con características avanzadas de la plataforma Sui

### 🚀 Próximos Pasos

- Explora otros proyectos en Sui para ver diferentes patrones de diseño
- Participa en la comunidad Sui en Discord y foros
- Contribuye con código open-source a proyectos Sui
- Construye tu propia dApp usando el conocimiento adquirido

### 📚 Recursos Adicionales

- [Documentación Oficial de Sui](https://docs.sui.io)
- [Repositorio GitHub de Sui](https://github.com/MystenLabs/sui)
- [Sui Explorer](https://suiexplorer.com)
- [Comunidad Discord](https://discord.gg/sui)

---

**© 2024 SuiSnap - Guía de Desarrollo**

Desarrollado con ❤️ para la comunidad Sui

