# ADR 003 — Puertos y adaptadores en la rodaja de Incidencias

- **Fecha:** 2026-11-04
- **Estado:** Aceptado
- **Sistema:** Gestión de operaciones logísticas (Hapag-Lloyd) — código en `src/repo`

## Contexto

La rodaja vertical de Incidencias concentra reglas de negocio críticas (severidad, operación activa, auditoría con `usuario_id` + `timestamp`, notificación a supervisores en severidad 5). Esas reglas deben poder probarse sin base de datos ni NestJS, y el mismo caso de uso debe poder persistir con TypeORM en producción.

En el código ya existía la separación:

- Dominio: `RegistrarIncidenciaUseCase` + puerto `Incidencias` en `src/repo/app/backend/src/monitoreo/dominio/`.
- Infraestructura: `IncidenciasTypeormAdapter` e `IncidenciasEnMemoriaAdapter`.
- Entrada HTTP: `IncidenciasController`.

Sin un ADR, la decisión quedaba implícita: el informe y la rúbrica pedían tres ADR y solo había dos (monolito modular y stack TypeScript).

## Alternativas

### 1. Puertos y adaptadores (hexagonal) en la rodaja — opción elegida

El caso de uso depende de un puerto (`Incidencias`). Los adaptadores implementan el puerto. Nest inyecta el puerto con el token `INCIDENCIAS_PORT`; el controlador no instancia el adaptador concreto con `new`.

### 2. Servicios Nest acoplados a TypeORM — descartada

`IncidenciasService` con repositorios inyectados y reglas mezcladas en el servicio. Acelera el primer CRUD, pero impide correr la misma suite de dominio contra un adaptador en memoria y acopla el dominio a Nest/TypeORM (viola la regla de dependency-cruiser).

### 3. Repositorio genérico compartido en `shared` — descartada

Un único repositorio transversal para varios módulos. Reduce duplicación aparente, pero borra la frontera de la rodaja y empuja reglas de incidencias hacia un núcleo compartido difícil de evolucionar (choca con ADR 001).

## Decisión

**Adoptamos puertos y adaptadores en la rodaja de Incidencias:** el dominio habla solo con el puerto; TypeORM y memoria son adaptadores intercambiables; el composition root de Nest cablea el puerto por token de inyección.

## Consecuencias

**Ventajas**

- La misma suite de dominio corre con memoria y con TypeORM (stub o real).
- dependency-cruiser puede prohibir imports de Nest/TypeORM desde `monitoreo/dominio`.
- Cambiar de adaptador (p. ej. pruebas e2e vs producción) no obliga a editar el controlador.

**Costos / riesgos**

- Hay más archivos y un token de DI que el equipo debe mantener.
- Cada método nuevo del puerto hay que implementarlo en todos los adaptadores.
- El resto de módulos (reservas, marítima, etc.) aún no siguen este patrón; la inconsistencia es consciente y acotada a la rodaja.
