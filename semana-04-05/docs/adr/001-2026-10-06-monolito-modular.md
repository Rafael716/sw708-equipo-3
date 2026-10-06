# ADR 001 — Estilo arquitectónico: monolito modular

- **Fecha:** 2026-10-06
- **Estado:** Aceptado
- **Sistema:** Gestión de operaciones logísticas (Hapag-Lloyd) — código en `src/repo`

## Contexto

El sistema cubre varios dominios (reservas, operaciones marítimas, portuarias, monitoreo, personal, etc.) que deben evolucionar en paralelo sin convertir cada cambio en un despliegue distribuido. En el repositorio de origen (`src/repo`) eso ya se refleja así:

- Un solo backend NestJS (`app/backend`) que registra módulos de dominio en `app.module.ts` (`GestionMaritimaModule`, `GestionReservaModule`, `MonitoreoModule`, …).
- Fronteras de datos por esquema PostgreSQL (`CREATE SCHEMA gestion_maritima`, `gestion_reserva`, `monitoreo`, `shared`, … en `scripts/ddl/tablas/`).
- Un solo frontend Next.js y un solo proceso de API, no un servicio por módulo.

La exigencia de calidad que ancla esta decisión es el escenario de **mantenibilidad** de la semana 2: ante un cambio de umbral o un nuevo tipo de sensor, el sistema debe permitir aplicar el cambio en **menos de 1 día-persona** y **sin downtime**. Eso exige fronteras claras (dónde tocar) y un despliegue simple (una unidad a publicar).

El cuadro del costo del cambio (semana 4–5) aporta números, no preferencias:

| Medida | Versión A | Versión B |
|---|---|---|
| Minutos | 25:41 | 32:39 |
| Archivos tocados | 3 | 6 |
| Líneas cambiadas | 52 | 48 |
| Lugares a buscar | 2 | 4 |

A concentró el cambio (más rápido, menos archivos). B repartió el cambio entre más capas y exigió buscar en más sitios. El estilo elegido debe **evitar el extremo B a escala de producto** (fragmentar de más) sin caer en una bola de barro donde cualquier cambio toca todo el sistema.

## Alternativas

### 1. Monolito modular (opción elegida)

Una aplicación desplegable con módulos de dominio y esquemas de BD separados. El equipo trabaja por frontera (`gestion_maritima`, `monitoreo`, …) sin multiplicar redes, contratos HTTP internos ni pipelines.

### 2. Monolito “bola de barro” — descartada

Todo el dominio en un solo paquete sin límites de esquema ni de módulo. Contra el escenario de mantenibilidad: un cambio de umbral o de regla compartida obliga a buscar en demasiados sitios y eleva el riesgo de downtime. Contra el cuadro: pierde la lección de A (cambio localizable) porque no hay frontera donde concentrar el cambio.

### 3. Microservicios por módulo — descartada

Un servicio y un despliegue por dominio. Multiplica contratos, latencia y fallos entre Operaciones Marítimas y Monitoreo (además de chocar con el escenario de interoperabilidad). Contra el cuadro: empuja el costo hacia el patrón B a escala de infraestructura (más “lugares donde buscar”, más archivos/repos tocados) sin evidencia de que el equipo necesite ese aislamiento operativo ahora.

## Decisión

**Adoptamos un monolito modular:** un despliegue de backend y uno de frontend, con módulos Nest por dominio y esquemas PostgreSQL por módulo (más `shared`), tal como está organizado en `src/repo`.

## Consecuencias

**Ventajas**

- El cambio queda acotado a un módulo/esquema, lo que alinea con la medida de mantenibilidad (&lt;1 día-persona) y con la lección del cuadro (preferir cambios localizables como en A).
- Un solo pipeline de despliegue reduce el riesgo de downtime frente a orquestar varios servicios.
- El equipo puede repartirse módulos sin pelear por el mismo esquema de tablas.

**Costos / riesgos**

- Las fronteras son por disciplina: si un módulo importa entidades o reglas de otro sin contrato claro, el monolito se degrada hacia bola de barro.
- El esquema `shared` y las tablas compartidas siguen siendo puntos de acoplamiento; un cambio ahí puede romper varios módulos a la vez.
- Escalar un solo dominio de forma independiente (CPU, cola, equipo) exigirá más adelante un corte explícito; hoy no lo pagamos, pero queda como deuda consciente.
