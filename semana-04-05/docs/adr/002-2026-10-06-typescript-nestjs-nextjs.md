# ADR 002 — Stack de lenguaje: TypeScript con NestJS y Next.js

- **Fecha:** 2026-10-06
- **Estado:** Aceptado
- **Sistema:** Gestión de operaciones logísticas (Hapag-Lloyd) — código en `src/repo`

## Contexto

El equipo necesitaba un stack único para implementar y mantener varios módulos de dominio en el mismo repositorio (`src/repo/app`), con tipado extremo a extremo y una API HTTP clara hacia el frontend.

Evidencia en el código actual:

- Backend: NestJS + TypeORM + `pg` (`app/backend/package.json`), módulos TypeScript bajo `app/backend/src/`.
- Frontend: Next.js + React tipado (`app/frontend/package.json`).
- Persistencia: PostgreSQL (`type: 'postgres'` en `app.module.ts`).
- Autenticación ya modelada en Nest (`AuthModule`, JWT/Passport en dependencias).

La decisión de lenguaje se tomó al armar el prototipo funcional; este ADR la deja explícita ahora que el porqué todavía está fresco: un solo lenguaje para backend y frontend, alineado a los módulos Nest que espejan los esquemas de dominio.

## Alternativas

### 1. TypeScript + NestJS + Next.js (opción elegida)

Un lenguaje (TypeScript) en API y UI. Nest impone módulos, controladores y servicios coherentes con el monolito modular. Next.js cubre el dashboard y los flujos operativos (operaciones marítimas, monitoreo, reservas).

### 2. Java + Spring Boot (y UI separada) — descartada

Stack habitual en otros cursos del ciclo y con fuerte ecosistema enterprise. Se descartó porque el equipo ya estaba trabajando el modelo de datos y el prototipo web en el ecosistema Node; introducir JVM + plantillas o un SPA aparte duplicaba curva de aprendizaje y alargaba el tiempo a un UI usable para operaciones 24/7.

### 3. Python (Django o FastAPI) + frontend JS sin TypeScript — descartada

Acelera scripts y prototipos de datos, pero rompe el tipado compartido entre API y UI y debilita la estructura modular que Nest aporta “de fábrica”. Un frontend en JavaScript puro aumentaría errores de contrato en pantallas con muchos DTOs (reservas, estados de operación, monitoreo).

## Decisión

**Usamos TypeScript en backend y frontend, con NestJS como framework de la API y Next.js como framework de la interfaz**, tal como está implementado en `src/repo/app`.

## Consecuencias

**Ventajas**

- Un solo lenguaje reduce el costo de coordinación entre quien toca API y quien toca UI.
- El tipado y los módulos Nest refuerzan las fronteras del monolito modular (ADR 001).
- El ecosistema npm permite iterar rápido el dashboard (mapas, charts, formularios de operación) exigido por los escenarios de interacción.

**Costos / riesgos**

- El equipo queda acoplado al runtime Node y a las convenciones de Nest/Next; migrar después a otro stack es caro.
- Nest tiene curva propia (DI, módulos, pipes); sin disciplina, la lógica se duplica por módulo (como ya se observó con autenticación repartida).
- TypeScript no elimina errores de integración en runtime (URLs hardcodeadas, `synchronize: false` sin migraciones): el tipado no sustituye contratos de despliegue ni pruebas de integración.
