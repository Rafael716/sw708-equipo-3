# Bitácora de IA — Semana 10 (APIs / contratos)

Registro de qué partes del trabajo salieron de la IA y qué corrigió o decidió el equipo.

## Contrato OpenAPI (`docs/api/openapi.yaml`)

| Origen | Qué |
|---|---|
| **IA (borrador)** | Estructura inicial del `POST /v1/incidencias`: esquemas `CrearIncidenciaRequest`, `Incidencia`, `Error`, y un primer set de status HTTP. |
| **Equipo** | Lista de modos de falla **antes** del camino feliz; códigos de error estables (`VALIDACION`, `DESCRIPCION_VACIA`, `OPERACION_NO_ACTIVA`, etc.); versionado semántico y qué sube MAJOR/MINOR/PATCH; ejemplos reales de petición y respuesta. |
| **Equipo (tras Equipo 1)** | Acta de ambigüedades: campo opcional `campo` en el error (1.1.0), orden de evaluación de errores, tratamiento de `null`, idempotencia explícita (no hay), UTC en el `codigo`, y catálogos de donde salen los UUID. |

## Acta e intercambio

| Origen | Qué |
|---|---|
| **Equipo 1** | Lista de supuestos al consumir nuestro contrato (`equipo-1/supuestos-equipo-1.md`). |
| **Equipo** | Decisiones punto por punto en `acta-ambiguedades.md` / `equipo-1/acta-ambiguedades-equipo-1.md` y corrección del YAML. |
| **Equipo** | Supuestos al consumir el contrato ajeno (Suazo): `supuestos-contrato-suazo.md`. |

## Implementación (paso 04)

| Origen | Qué |
|---|---|
| **IA / generador** | Interfaces y tipos con `openapi-generator` (`typescript-nestjs-server` → `http/generado/`). |
| **Equipo** | Adaptador `IncidenciasV1Controller` (Nest solo aquí), traducción de errores de dominio a HTTP, filtro de JSON inválido, y pruebas nombradas por punto del acta (`A3`…`A14`). El dominio no importa Nest ni el generador. |

## Regla de arquitectura (paso 05)

| Origen | Qué |
|---|---|
| **Equipo** | Ampliación de dependency-cruiser (`dominio-monitoreo-no-depende-de-framework`), experimento rojo con `class-validator`, capturas en `semana-10/assets/` (ver `docs/evidencia-paso-5.md`), y reversión del import. |

## Flujo por eventos (paso 06)

| Origen | Qué |
|---|---|
| **IA (asistencia)** | Esqueleto del evento `IncidenciaRegistrada`, puerto `PublicadorEventos` y adaptador en memoria. |
| **Equipo** | Decisión de negocio: el consumidor vive en **gestión marítima** (Partición B) y solo crea alerta operativa si la severidad es 5; si el consumidor falla, el alta no se revierte. Documentación en `docs/api/eventos.md` y prueba del recorrido completo. |

## Criterio del equipo

La IA aceleró borradores y cableado repetitivo. El equipo validó el contrato con otro grupo, cerró ambigüedades en el YAML (no en un chat) y mantuvo el framework fuera del dominio.
