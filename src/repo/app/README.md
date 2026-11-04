# Sistema de Operaciones - Documentación de la aplicación

Este repositorio contiene la implementación completa (backend y frontend) del proyecto del **Grupo 5** del curso **BD252 - Diseño de Bases de Datos**.

La aplicación está orientada a la gestión y monitoreo de operaciones logísticas de contenedores para Hapag-Lloyd, incluyendo:

- Gestión de **reservas**.
- Gestión de **operaciones marítimas**.
- Módulo de **monitoreo** (operaciones, contenedores, incidencias, notificaciones, reportes, mapa).
- Gestión de **operaciones terrestres** y **personal/tripulación** (como soporte de datos).
- **Autenticación** y pantallas de login/perfil para usuarios internos.

Este README raíz funciona como **índice general** de la documentación.

---

## 1. Backend

Carpeta principal del backend:

- `backend/`

Documentación general del backend y módulos:

- **Backend - Documentación general** 
  * [Documentación backend](./backend/README.md)

Módulos principales (NestJS):

- **Autenticación** (`backend/src/auth/`)
  * [Documentación módulo auth](./backend/src/auth/README.md)

- **Gestión Marítima** (`backend/src/gestion_maritima/`)
  - [Documentación gestión marítima](./backend/src/gestion_maritima/README.md)

- **Gestión de Reserva** (`backend/src/gestion_reserva/`)
  - [Documentación gestión reserva](./backend/src/gestion_reserva/README.md)

- **Monitoreo** (`backend/src/monitoreo/`)
  - [Documentación monitoreo](./backend/src/monitoreo/README.md)

- **Operaciones Terrestres** (`backend/src/operaciones_terrestres/`)
  - [Documentación operaciones terrestres](./backend/src/operaciones_terrestres/README.md)

- **Personal de Tripulación** (`backend/src/personal_tripulacion/`)
  - [Documentación personal tripulación](./backend/src/personal_tripulacion/README.md)

- **Shared / Entidades compartidas** (`backend/src/shared/`)
  - [Documentación shared](./backend/src/shared/README.md)

En estos documentos se describen:

- Entidades y relaciones principales (TypeORM).
- Controladores y servicios (endpoints, reglas de negocio, validaciones).
- Flujos clave por módulo y cómo se integran entre sí.

---

## 2. Frontend

Carpeta principal del frontend:

- `frontend/`

Documentación general del frontend:

- **Frontend - Documentación general** 
  * [Documentación frontend](./frontend/README.md)

Módulos/pantallas principales (Next.js App Router):

- **Login y autenticación**
  * [Documentación pantallas de login](./frontend/app/login/README.md)

- **Gestión de Reservas** (`/gestion-reservas`)
  - [Documentación frontend gestión reservas](./frontend/app/gestion-reservas/README.md)

- **Monitoreo** (`/monitoreo`)
  - [Documentación frontend monitoreo](./frontend/app/monitoreo/README.md)

- **Operaciones Marítimas** (`/operaciones-maritimas`)
  - [Documentación frontend operaciones marítimas](./frontend/app/operaciones-maritimas/README.md)

- **Perfil de Usuario** (`/perfil`)
  - [Documentación frontend perfil](./frontend/app/perfil/README.md)

Cada README de frontend describe:

- Pantallas y componentes principales de cada sección.
- Flujos de usuario (qué hace cada pantalla, pasos típicos).
- Endpoints del backend que consume (por módulo).

---

## 3. Cómo navegar la documentación

1. **Entender la arquitectura general**:
   - Leer `backend/README.md` y `frontend/README.md`.

2. **Por módulo funcional**:
   - Backend: abrir el README del módulo correspondiente dentro de `backend/src/...`.
   - Frontend: abrir el README de la ruta/pantalla en `frontend/app/...`.

3. **Relación backend–frontend**:
   - Cada README de frontend indica explícitamente qué endpoints de backend utiliza.
   - Cada README de backend indica qué pantallas de frontend dependen de sus endpoints.

---

## 4. Datos del equipo

- Curso: Diseño de Bases de Datos
- Grupo: 5
- Integrantes:
  - Romel Rodrigo Chumpitaz Flores
  - Gonzalo Albornoz Azurza
  - Rafael Adriano Olivos Gallardo
  - David Luza Ccorimanya
  - Franz Joe Inga Champi

---

## 5. Ejecución básica del proyecto

El proyecto usa **pnpm workspaces** (monorepo en la raíz de `app/`). Todos los comandos se ejecutan desde la carpeta `app/`.

### 5.1. Instalación de dependencias

```bash
pnpm install
```

### 5.2. Ejecución en desarrollo

Backend (puerto 3001):

```bash
pnpm dev:backend
```

Frontend (puerto 3000):

```bash
pnpm dev:frontend
```

O ambos a la vez:

```bash
pnpm dev
```

Por defecto el frontend se expone en `http://localhost:3000` y el backend en `http://localhost:3001`.

### 5.3. Docker Compose (recomendado)

Levanta PostgreSQL + backend + frontend en contenedores:

```bash
cp .env.example .env   # opcional: ajustar credenciales
docker compose up -d --build
```

- Frontend: `http://localhost:3000`
- Backend: `http://localhost:3001`
- PostgreSQL: solo accesible desde la red interna (`db:5432`)

La base de datos se inicializa automáticamente con el **esquema** (`scripts/ddl/tablas/consolidado.sql`), que incluye los 8 schemas: `shared`, los 6 módulos y `gestion_maritima_audit` (auditoría batch de conciliación).

**Datos de prueba (seed automatizado):**

```bash
./scripts/poblamiento_datos/seed.sh          # genera CSVs (Python+Faker) y los carga con psql \copy
./scripts/poblamiento_datos/seed.sh --ddl    # igual, pero primero recrea el esquema (DESTRUCTIVO)
```

- El generador `consolidado.py` produce 123 CSVs con **UUIDs** (compatible con el DDL) y fechas relativas a la fecha actual.
- El loader `consolidado.sql` usa `\copy` (cliente) y el placeholder `:csvdir`, que `seed.sh` resuelve automáticamente.
- Destino: usa `DATABASE_URL` si está definida; si no, carga en el contenedor `db` del docker-compose (red `app_default`).
- Requisito: `python3` con `venv` y Docker (o psql local).

**Credenciales de prueba** (texto plano, modo desarrollo):

| Usuario | Contraseña | Acceso |
|---|---|---|
| `admin@demo.com` | `Admin123!` | Todos los módulos (Administrador + Operador) |

Los demás usuarios generados tienen contraseñas aleatorias legibles en `shared.Usuario`. El login es unificado (`POST /auth/login`) y el acceso a cada módulo se calcula por rol: **monitoreo** (ser operador), **reservas** (rol Admin/Supervisor/Operador/Coordinador/Consultor/Auditor), **marítimo** (no Agente/Cliente/Trabajador Portuario), **portuario** (no Agente/Cliente).

Comandos útiles:

```bash
docker compose logs -f backend   # logs del backend
docker compose down              # detener servicios
docker compose down -v           # detener y borrar datos de la BD (se vuelve a sembrar con seed.sh)
```

> ⚠️ Los scripts antiguos `scripts/dml/datos-iniciales/` usan IDs enteros y son **incompatibles** con el esquema UUID actual. Usar el pipeline `consolidado.py` + `consolidado.sql` + `seed.sh`.

### 5.4. Build de producción

```bash
pnpm build      # compila backend y frontend
pnpm test       # tests del backend
```

### 5.5. Deploy en producción

Para desplegar en **Vercel + Render + Supabase** (incluido el seed automatizado con GitHub Actions), ver [`DEPLOY.md`](../DEPLOY.md).

---

## Deuda técnica / pendiente (próxima iteración)

- **Contraseñas en texto plano**: el login y el seed usan contraseñas en texto plano (modo desarrollo). Migrar a `bcrypt` (hash en `generar_usuarios` + `bcrypt.compare` en `AuthService`) antes de producción.
