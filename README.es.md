# 🚀 SuiSnap

> **Acortador de enlaces on-chain** construido en Move para la blockchain Sui. Un proyecto educativo completo que enseña los fundamentos del desarrollo en Sui a través de una aplicación práctica y progresiva.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Sui](https://img.shields.io/badge/Built%20on-Sui-6fbcf0)](https://sui.io)
[![Move](https://img.shields.io/badge/Language-Move-00d4ff)](https://github.com/move-language/move)

**🌐 Idiomas:** [English](README.md) | [Português](README.pt.md) | [Español](README.es.md)

---

## 📖 Sobre el Proyecto

**SuiSnap** es un acortador de enlaces descentralizado que funciona como una ruta educativa completa para aprender desarrollo en **Move** en la blockchain **Sui**. Cada enlace acortado se convierte en un objeto autónomo en Sui, permitiendo explorar profundamente el modelo de objetos único de la plataforma.

### 🎯 Propósito Educativo

Este proyecto no busca competir con acortadores comerciales, sino demostrar de forma práctica y organizada los principales conceptos de la arquitectura Sui:

- ✅ Creación y gestión de objetos on-chain
- ✅ Manipulación de propiedad y permisos
- ✅ Uso de capabilities para control de acceso
- ✅ Emisión de eventos para auditoría
- ✅ Buenas prácticas de modelado en Move

---

## 🔄 Referencia Rápida: Términos Cotidianos → Move/Sui

Un mapeo rápido de conceptos cotidianos a terminología Sui/Move para ayudar a principiantes a entender el código:

| 🧑‍💼 **Término Cotidiano** | 🔧 **Equivalente Move/Sui** | 📝 **Explicación** |
|----------------------|---------------------------|-------------------|
| **Propietario** | `owner: address` | La dirección que posee el objeto y puede moverlo/transferirlo según las reglas del contrato |
| **DNI del Objeto** | `UID` / `ID` | Identificador único global para objetos con `has key` - como un DNI para objetos en la blockchain |
| **Tarjeta de Permiso** | `Capability` / `EditCap` | Un objeto-prueba que autoriza acciones específicas (como editar/eliminar un Link) - piénsalo como una tarjeta de acceso |
| **Quien Envió** | `tx_context::sender` | La dirección que firmó y envió la transacción - el "quién" detrás de cada acción |
| **Evento** | `LinkCreated` / `LinkUpdated` / `LinkDeleted` | Recibo público de una acción, registrado permanentemente on-chain y consultable vía Explorer/CLI - como un log de transacciones |
| **Función de Entrada** | `public entry fun` | Función orientada al usuario que valida reglas y aborta si se violan - la "puerta principal" de tu contrato |

### 💡 Consejos Rápidos

- **UID vs ID**: `UID` se crea cuando el objeto nace, `ID` se deriva de él y se usa para referencias
- **Patrón Capability**: En lugar de verificar estado global, Sui usa objetos-prueba transferibles (capabilities) para autorización
- **Eventos son Inmutables**: Una vez emitidos, los eventos son permanentes y pueden consultarse para siempre - perfecto para auditoría

---

## ✨ Características

- 🔷 **Programmable Object Model**: Cada enlace es un objeto on-chain con UID único
- 🔐 **Capabilities Pattern**: Sistema de autorización seguro sin variables globales
- 📡 **Eventos On-chain**: Auditoría completa con `LinkCreated`, `LinkUpdated`, `LinkDeleted`
- ✅ **Validación Robusta**: Validación de URLs y códigos cortos
- 🧪 **Pruebas Completas**: Cobertura de pruebas unitarias con casos de éxito y fallo
- 📚 **Documentación Completa**: Manual detallado y módulos paso a paso
- 🌐 **Front-end Ready**: Preparado para integración con Sui dApp Kit

---

## 📚 Estructura de la Ruta Educativa

El proyecto está organizado en **8 módulos progresivos**, cada uno cubriendo aspectos esenciales del desarrollo Sui:

| Módulo | Tema | Descripción |
|--------|------|-------------|
| **0** | Configuración y Publicación | Entorno, Sui CLI, build, pruebas y publicación del paquete |
| **1** | Programmable Object Model | Objeto `Link` (UID, owner, short_code), mutabilidad, transferencias |
| **2** | Ownership y Autorización | `tx_context::sender`, capabilities (`EditCap`), restricciones por dirección |
| **3** | Modelado Move | Validación de URL/shortcode, errores personalizados, buenas prácticas |
| **4** | Eventos y Auditoría | Eventos `LinkCreated/Updated/Deleted`, consultas vía CLI/Explorer |
| **5** | Pruebas Automatizadas | `sui move test`, casos exitosos y `#[expected_failure]` |
| **6** | Front-end (Sui dApp Kit) | moveCall, listar objetos, integración React/Next.js |
| **7** | Extensiones Avanzadas | Dynamic fields, NFT, hash, expiración, pagos en SUI |

📖 **Documentación detallada**: Cada módulo tiene un README específico en `docs/modulo-*/README.md`  
📘 **Manual completo**: Disponible en tres idiomas:
  - [`handbook.en.md`](handbook.en.md) (English)
  - [`apostila.pt.md`](apostila.pt.md) (Português)
  - [`apostila.es.md`](apostila.es.md) (Español)

---

## 🚀 Inicio Rápido

### Prerrequisitos

- [Sui CLI](https://docs.sui.io/build/install) instalada y configurada
- Entorno configurado (devnet o localnet)
- (Opcional) Node.js para desarrollo front-end

### Instalación

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/SilvaCleverson/SuiSnap.git
   cd SuiSnap
   ```

2. **Compilar el paquete**
   ```bash
   sui move build
   ```

3. **Ejecutar las pruebas**
   ```bash
   sui move test
   ```

4. **Publicar en devnet** (después de configurar tu wallet)
   ```bash
   sui client publish --gas-budget 500000000 --skip-fetch-latest-gas-price .
   ```
   ⚠️ **Importante**: Anota el `packageId` devuelto para usar en las llamadas al contrato.

---

## 💻 Uso

### Crear un Enlace Acortado

```bash
sui client call \
  --package <PACKAGE_ID> \
  --module suisnap \
  --function create_link \
  --args "vector<u8>:https://ejemplo.com" "vector<u8>:abc" \
  --gas-budget 20000000
```

### Actualizar un Enlace

```bash
sui client call \
  --package <PACKAGE_ID> \
  --module suisnap \
  --function update_link \
  --args object:<LINK_ID> object:<EDIT_CAP_ID> \
    "vector<u8>:https://nuevo.com" "vector<u8>:nuevo" \
  --gas-budget 20000000
```

### Consultar Eventos

```bash
# Eventos de creación
sui client query-events \
  --move-event-struct <PACKAGE_ID>::suisnap::LinkCreated

# Eventos de actualización
sui client query-events \
  --move-event-struct <PACKAGE_ID>::suisnap::LinkUpdated
```

### Listar Objetos del Usuario

```bash
sui client objects --owner <TU_DIRECCION>
```

---

## 📁 Estructura del Proyecto

```
SuiSnap/
├── Move.toml              # Manifest del paquete Move
├── sources/
│   └── suisnap.move       # Módulo principal del contrato
├── tests/
│   └── suisnap_tests.move # Pruebas unitarias
├── handbook.en.md         # Complete handbook (English)
├── apostila.pt.md         # Apostila completa (Português)
├── apostila.es.md         # Manual completo (Español)
├── docs/
│   ├── apostila.html      # Manual (HTML)
│   ├── README.md          # Índice de documentación
│   └── modulo-*/          # Documentación por módulo
├── LICENSE                # Licencia MIT
└── README.md              # Este archivo
```

---

## 🧪 Pruebas

El proyecto incluye una suite completa de pruebas que cubre:

- ✅ Creación de enlaces
- ✅ Actualización de enlaces
- ✅ Validación de permisos
- ✅ Manejo de errores (`E_NOT_OWNER`, `E_LINK_CAP_MISMATCH`)
- ✅ Funciones de lectura (`get_url`, `get_short_code`, `get_owner`)

Ejecutar pruebas:

```bash
# Todas las pruebas
sui move test

# Pruebas con filtro
sui move test --filter suisnap

# Salida detallada
sui move test --verbose
```

---

## 📖 Documentación

- **📘 Manual Completo**: Disponible en tres idiomas:
  - [`handbook.en.md`](handbook.en.md) - English
  - [`apostila.pt.md`](apostila.pt.md) - Português
  - [`apostila.es.md`](apostila.es.md) - Español
- **📚 Módulos Individuales**: Documentación específica en `docs/modulo-*/README.md`
- **🌐 Versión HTML**: [`docs/apostila.html`](docs/apostila.html) - Manual formateado para web
- **📄 PDF**: [`docs/Apostila LinkPass Sui - Guia de Desenvolvimento.pdf`](docs/Apostila%20LinkPass%20Sui%20-%20Guia%20de%20Desenvolvimento.pdf)

---

## 🛠️ Tecnologías

- **Move**: Lenguaje de smart contracts de Sui
- **Sui Blockchain**: Plataforma blockchain de alto rendimiento
- **Sui CLI**: Herramientas de línea de comandos
- **Sui dApp Kit**: (Opcional) Para integración front-end

---

## 🗺️ Roadmap

- [ ] Validación avanzada de URLs y códigos cortos
- [ ] Contador de clics con evento `ClickRegistered`
- [ ] Front-end completo con Sui dApp Kit
- [ ] Dynamic fields para metadata
- [ ] Sistema de expiración de enlaces
- [ ] Mecanismo de pago en SUI

---

## 🤝 Contribuir

¡Las contribuciones son bienvenidas! Siéntete libre de:

1. Hacer fork del proyecto
2. Crear una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abrir un Pull Request

---

## 📝 Licencia

Este proyecto está licenciado bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para detalles.

---

## 🔗 Enlaces Útiles

- [Documentación Oficial de Sui](https://docs.sui.io)
- [Repositorio de Sui](https://github.com/MystenLabs/sui)
- [Sui Explorer](https://suiexplorer.com)
- [Comunidad Discord de Sui](https://discord.gg/sui)

---

## 👤 Autor

**SilvaCleverson**

- GitHub: [@SilvaCleverson](https://github.com/SilvaCleverson)
- Proyecto: [SuiSnap](https://github.com/SilvaCleverson/SuiSnap)

---

## ⭐ Agradecimientos

- Comunidad Sui por el excelente ecosistema
- Mysten Labs por la plataforma innovadora
- Todos los contribuidores y aprendices que utilizan este proyecto

---

<div align="center">

**Hecho con ❤️ para la comunidad Sui**

⭐ Si este proyecto te fue útil, ¡considera darle una estrella!

</div>

