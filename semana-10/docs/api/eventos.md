# Eventos de dominio (paso 06)

Contrato de eventos del alta de incidencias (`POST /v1/incidencias`). Coinciden con el código en `monitoreo/dominio` y el consumidor en `gestion_maritima` (otro módulo de la Partición B).

## IncidenciaRegistrada

| | |
|---|---|
| **Nombre** | `IncidenciaRegistrada` (pasado, inmutable) |
| **Cuándo se emite** | Justo después de que `RegistrarIncidenciaUseCase` guarda con éxito una incidencia. |
| **Campos** | `idIncidencia`, `codigo`, `idOperacion`, `gradoSeveridad`, `idUsuario`, `ocurrioEn` |
| **Quién lo emite** | Caso de uso de monitoreo, a través del puerto `PublicadorEventos` (adaptador en memoria hoy). |
| **Quién lo consume** | `AlertaOperativaPorIncidenciaConsumer` en el módulo de **gestión marítima**. Si `gradoSeveridad === 5`, registra una alerta operativa sobre la operación. |

### ¿Qué pasa si el consumidor falla?

La incidencia **ya quedó guardada**. El caso de uso atrapa el error del publicador/consumidor y no revierte el alta ni cambia la respuesta HTTP (`201`). El efecto en el otro módulo es de mejor esfuerzo: sin reintentos ni broker en esta versión (semana 11).

### Dónde está en el código

- Evento: `src/repo/app/backend/src/monitoreo/dominio/incidencia-registrada.evento.ts`
- Puerto: `src/repo/app/backend/src/monitoreo/dominio/publicador-eventos.port.ts`
- Adaptador en memoria: `src/repo/app/backend/src/monitoreo/infraestructura/publicador-eventos-en-memoria.adapter.ts`
- Consumidor: `src/repo/app/backend/src/gestion_maritima/consumidores/alerta-operativa-por-incidencia.consumer.ts`
- Prueba del flujo: `src/repo/app/backend/src/monitoreo/dominio/flujo-eventos-incidencia.spec.ts`
