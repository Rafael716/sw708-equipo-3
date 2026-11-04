# Deploy — Vercel + Render + Supabase

Guía para desplegar el proyecto del Grupo 5 (BD252) en producción.

## Arquitectura

| Pieza | Plataforma | Stack |
|---|---|---|
| Frontend | **Vercel** | Next.js 16 (App Router) |
| Backend | **Render** | NestJS 11 (Node 22, pnpm) |
| Base de datos | **Supabase** | PostgreSQL 15/16 (schemas + UUID + PL/pgSQL) |
| Seed de datos | **GitHub Actions** | `consolidado.py` (Faker) + `seed.sh` (psql `\copy`) |

Flujo: `Vercel (https)` → `Render backend (https)` → `Supabase Postgres (pooler)`. El batch de conciliación nocturna se ejecuta **manualmente** vía `POST /gestion-maritima/conciliacion-nocturna` (botón del dashboard), sin `pg_cron`.

---

## Requisitos previos

- Cuenta en **Supabase**, **Render** y **Vercel**.
- Repositorio en GitHub (este repo).
- Credenciales de prueba: `admin@demo.com` / `Admin123!` (acceso a todos los módulos).

---

## 1. Supabase (Base de datos)

1. Crear un proyecto en [supabase.com](https://supabase.com) (región cercana a los usuarios).
2. En **Project Settings → Database → Connection string** copiar la **conexión directa** (no la pooler transaccional). Tiene la forma:
   ```
   postgresql://postgres.<project-ref>:<password>@aws-0-<region>.pooler.supabase.com:5432/postgres?sslmode=require
   ```
3. Guardarla como secreto del repositorio en GitHub:
   **Settings → Secrets and variables → Actions → New repository secret**
   - Nombre: `SUPABASE_DB_URL`
   - Valor: la connection string (con `sslmode=require`).

> **Ojo:** para `\copy` y el DDL usa la conexión **directa/session pooler**, no el pooler transaccional (puerto 6543), que puede fallar con `COPY`/DDL.
> Las extensiones `pgcrypto` y `uuid-ossp` ya vienen habilitadas en Supabase; no hace falta nada más.

---

## 2. Seed de datos (GitHub Actions)

El seed está automatizado en `.github/workflows/seed-db.yml` (disparo manual):

1. En GitHub ir a **Actions → "Seed DB" → Run workflow**.
2. Opciones:
   - **run_ddl = false** (recomendado): carga datos sobre el esquema existente.
   - **run_ddl = true**: recrea los schemas y vuelve a sembrar todo (**DESTRUCTIVO** — solo primer deploy o reseed completo).

El workflow: checkout → Python 3.12 → cliente `psql` → `bash scripts/poblamiento_datos/seed.sh`, usando `DATABASE_URL` del secreto `SUPABASE_DB_URL`.

Para **reproducir localmente** contra Supabase (opcional):

```bash
DATABASE_URL="postgresql://..." ./scripts/poblamiento_datos/seed.sh --ddl
```

---

## 3. Render (Backend)

Dos formas: **blueprint** (recomendado) o dashboard manual.

### Opción A — Blueprint (`app/render.yaml`)

El archivo `app/render.yaml` define el servicio. Para usarlo:

1. Render → **New → Blueprint** → seleccionar el repo.
2. Render lee `render.yaml`; el servicio `bd252-backend` aparece listo.
3. Configurar las variables con `sync: false` en el dashboard del servicio:
   - `DATABASE_URL`: connection string de Supabase (directa, con `sslmode=require`).
   - `JWT_SECRET`: cualquier secreto largo.

### Opción B — Dashboard manual

- **New → Web Service** → conectar el repo.
- **Root Directory:** `app`
- **Build Command:**
  ```
  pnpm install --frozen-lockfile && pnpm --filter backend build
  ```
- **Start Command:**
  ```
  pnpm --filter backend start:prod
  ```
- **Environment** (añadir manualmente):

| Variable | Valor |
|---|---|
| `NODE_ENV` | `production` |
| `PORT` | `3001` |
| `DATABASE_URL` | connection string de Supabase (directa) |
| `JWT_SECRET` | secreto largo |
| `CORS_ORIGINS` | `https://<tu-app>.vercel.app,http://localhost:3000` |

Render detecta pnpm por el `pnpm-lock.yaml` en `app/`. El build genera `app/backend/dist/main.js` (correcto para `start:prod`).

> En el plan free, Render duerme el servicio tras ~15 min de inactividad; el primer request tarda unos segundos en despertarlo.

---

## 4. Vercel (Frontend)

1. **Vercel → Add New → Project** → importar el repo.
2. **Root Directory:** `app/frontend`
3. Framework: **Next.js** (auto-detectado).
4. En **Settings → Environment Variables** añadir (build-time):
   - `NEXT_PUBLIC_API_URL`: `https://<backend>.onrender.com`
5. Deploy. El frontend quedará en `https://<tu-app>.vercel.app`.

---

## 5. Variables de entorno (resumen)

| Dónde | Variable | Valor |
|---|---|---|
| GitHub secret | `SUPABASE_DB_URL` | connection string de Supabase (directa, `sslmode=require`) |
| Render (backend) | `DATABASE_URL` | igual que `SUPABASE_DB_URL` |
| Render (backend) | `JWT_SECRET` | secreto largo |
| Render (backend) | `CORS_ORIGINS` | `https://<tu-app>.vercel.app,http://localhost:3000` |
| Render (backend) | `NODE_ENV` | `production` |
| Render (backend) | `PORT` | `3001` |
| Vercel (frontend) | `NEXT_PUBLIC_API_URL` | `https://<backend>.onrender.com` |

---

## 6. Verificación post-deploy

```bash
# 1. Backend
curl https://<backend>.onrender.com/                 # -> Hello World!

# 2. Login unificado (devuelve los módulos accesibles)
curl -X POST https://<backend>.onrender.com/auth/login \
  -H "Content-Type: application/json" \
  -d '{"correo_electronico":"admin@demo.com","contrasena":"Admin123!"}'
# -> { "access_token": "...", "usuario": {...}, "modulos": ["monitoreo","reservas","maritimo","portuario"] }

# 3. Batch de conciliación (manual)
curl -X POST https://<backend>.onrender.com/gestion-maritima/conciliacion-nocturna \
  -H "Content-Type: application/json" -d '{}'

# 4. Frontend
# Abrir https://<tu-app>.vercel.app -> Iniciar sesión -> admin@demo.com / Admin123!
```

---

## 7. Troubleshooting

- **`\copy` falla contra Supabase**: asegúrate de usar la **conexión directa** (`...pooler.supabase.com:5432` con el usuario `postgres.<ref>`) y `sslmode=require`, no el pooler transaccional `:6543`.
- **CORS "no permitido" en el navegador**: revisa que `CORS_ORIGINS` en Render incluya exactamente el origen de Vercel (sin barra final).
- **KPIs del dashboard en 0**: si el seed se corrió hace tiempo, los datos quedan fuera de la ventana de "últimos 30 días". Volver a correr el workflow de seed (sin `--ddl`).
- **Render no encuentra pnpm**: el `Root Directory` debe ser `app` (donde está `pnpm-lock.yaml`). Si usas Docker, el `backend/Dockerfile` requiere contexto `app/` (Render lo soporta vía `dockerfilePath` en un blueprint).
- **Pruebas locales**: `docker compose up -d --build` + `./scripts/poblamiento_datos/seed.sh` (carga en el contenedor local).

---

## 8. Deuda técnica / pendientes

- Contraseñas en **texto plano** (modo desarrollo): migrar a `bcrypt` (hash en `generar_usuarios` + `bcrypt.compare` en `AuthService`) antes de producción real.
- Programar el batch nocturno (`pg_cron` en Supabase) si se quiere sin intervención manual.