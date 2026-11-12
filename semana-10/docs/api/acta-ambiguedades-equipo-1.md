# Acta de ambigüedades — contrato «Incidencias» (Equipo 3)

**Levantó:** Equipo 1 (equipo consumidor) · **Contrato revisado:** [`openapi.yaml`](./openapi.yaml), `POST /v1/incidencias` (`crearIncidencia`) · **Versión:** 1.0.0 → 1.1.0

Lista original del Equipo 1, con la llamada que escribieron: [`supuestos-equipo-1.md`](./supuestos-equipo-1.md).

Cada duda se resolvió en el contrato, no en un chat aparte. El contrato sube a **1.1.0** (MINOR) porque se agrega el campo opcional `campo` al cuerpo de error; el resto son reglas que ya aplicaban y no estaban escritas.

| # | Qué tuvo que suponer el consumidor | Qué se decidió | Qué cambió en el contrato |
|---|---|---|---|
| 1 | El token se obtiene en otro endpoint, cualquier usuario puede registrar sobre cualquier operación, y no sabe si hay `403`. | El token sale de `POST /auth/login` (fuera del contrato). No hay roles en v1: basta con estar autenticado. Por eso no hay `403`. | Sección «Autenticación» en `info.description` y `description` en `bearerAuth`. |
| 2 | Los UUID válidos de `id_tipo_incidencia` e `id_operacion` se consultan en otros endpoints que no conoce. | Se documentan las rutas de los catálogos: tipos en `GET /monitoreo/incidencias/tipos`, operaciones en `GET /monitoreo/operaciones`. | Bloque «De dónde salen los identificadores» en la operación y `description` de los dos campos. |
| 3 | El `id_estado_incidencia` de la respuesta es el de «Abierta» y existe un catálogo. | En un alta exitosa **siempre** es el UUID de «Abierta». Catálogo en `GET /monitoreo/incidencias/estados`. | `description` de `Incidencia.id_estado_incidencia` y de la respuesta `201`. |
| 4 | `descripcion` ausente da `DESCRIPCION_VACIA` y `grado_severidad` ausente da `VALIDACION`. | Era una contradicción: la regla general decía «campo ausente → `VALIDACION`» y el ejemplo de `descripcion` decía «ausente → `DESCRIPCION_VACIA`». Se estandariza **un código por campo**: `descripcion` → `DESCRIPCION_VACIA`, `grado_severidad` → `SEVERIDAD_INVALIDA`, `id_tipo_incidencia` e `id_operacion` → `VALIDACION`. | Tabla «Campos ausentes y `null`» en «Errores»; `summary` de los ejemplos `campo_ausente`, `descripcion_vacia` y `severidad_invalida`. |
| 5 | `null` equivale a ausente; `"4"` y `4.5` dan `SEVERIDAD_INVALIDA`; `descripcion: 123` da `VALIDACION`. | Se confirma: `null` es igual que ausente. `grado_severidad` como texto o decimal da `SEVERIDAD_INVALIDA`; cualquier otro tipo incorrecto da `VALIDACION`. | Párrafos «Campos ausentes y `null`» y «Tipos incorrectos»; ejemplo nuevo `tipo_incorrecto`; `description` de los campos. |
| 6 | Con varios problemas a la vez sale un solo error, en orden `401`, `400`, `422`, `409`. | Se confirma: un solo error por respuesta, en ese orden. Dentro del `422` se revisa primero el tipo y luego la operación. | Párrafo «Un solo error por respuesta» en «Errores»; `description` de la respuesta `422`. |
| 7 | Para saber qué campo falló en un `VALIDACION` hay que leer `mensaje`. | No debe leerse `mensaje`. Se agrega el campo opcional `campo` al cuerpo de error en los `400` asociados a un campo. | Propiedad `campo` en el esquema `Error`; `campo` en todos los ejemplos del `400` que corresponden a un campo. |
| 8 | Más de 1000 caracteres da `VALIDACION`, el límite se mide tras recortar y la respuesta devuelve el texto recortado. | Se confirma y se documenta el saneamiento: primero se quitan los espacios de los extremos, después se mide; más de 1000 → 400 `VALIDACION`; se guarda y devuelve recortado. | `description` de `descripcion`; ejemplo nuevo `descripcion_muy_larga`. |
| 9 | Cuerpo vacío, JSON roto o `Content-Type` distinto dan `400 VALIDACION` (o quizá `415`). | Solo se acepta `application/json`. Cuerpo vacío, JSON inválido u otro `Content-Type` → 400 `VALIDACION` (no `415`). | Fila `400` de la tabla de errores; ejemplo nuevo `cuerpo_no_json`. |
| 10 | Repetir la llamada crea otra incidencia; tras un corte de red no se sabe si se guardó. | Se confirma: no es idempotente y no hay `Idempotency-Key` en v1. La decisión de reintentar es del cliente, que debe consultar antes de repetir. | Bloque «Repetir la llamada» en la `description` de la operación. |
| 11 | Existe un `GET` por `id_incidencia` que no está en el contrato. | Existe `GET /monitoreo/incidencias/{id_incidencia}`, fuera de este contrato; la verificación de lo creado es externa. Sin `Location` en v1 (posible MINOR futuro). | Bloque «Consultar lo creado» en la operación; `description` del `201`. |
| 12 | Cualquier estado distinto de `En curso` da `409`. | Se confirma y se listan los estados: solo `En curso` admite incidencias; `Pendiente`, `Completada` y `Cancelada` dan 409 `OPERACION_NO_ACTIVA`. | Tabla de estados en la respuesta `409`; `description` de `id_operacion`. |
| 13 | El `201` no garantiza la notificación a supervisores y el cliente no puede saberlo. | Se confirma por diseño: la notificación es un proceso secundario de mejor esfuerzo y no bloquea el registro principal. La respuesta no informa su resultado. | `description` de la operación y del `201`. |
| 14 | `AAMM` sale de la hora del servidor, la secuencia se reinicia cada mes y no pasa de 9999. | `AAMM` en **UTC**, igual que `fecha_hora`. La secuencia se reinicia cada mes y tiene **al menos** cuatro dígitos (después de `9999` sigue `10000`). | `description` y `pattern` de `Incidencia.codigo` (`^INC-\d{4}-\d{4,}$`). |

## Trazabilidad con la implementación (paso 4)

El endpoint `POST /v1/incidencias` es el adaptador `src/repo/app/backend/src/monitoreo/http/incidencias-v1.controller.ts`, que implementa la interfaz generada desde este contrato (`http/generado/`). Las pruebas están en `http/incidencias-v1.controller.spec.ts`; cada una lleva en el nombre el punto del acta que verifica (`A4: …`, `A5: …`).

Rutas relativas a `src/repo/app/backend/src/monitoreo/`.

| # | Estado | Dónde se cumple | Prueba |
|---|---|---|---|
| 1 | ✅ Implementado | No hay roles: el endpoint usa `JwtAuthGuard`. El `401` responde `{ codigo: NO_AUTENTICADO, mensaje }` (`http/errores-contrato.filter.ts`) | `token_ausente_o_invalido: sin token -> 401` |
| 2 | Documentación | Sin cambio de código: los `GET` de catálogos ya existen | — |
| 3 | ✅ Implementado | `http/incidencias-v1.controller.ts` (`aContrato`) | `A3: id_estado_incidencia es el de «Abierta»` |
| 4 | ✅ Implementado | `dominio/registrar-incidencia.use-case.ts` (descripción y severidad) y `http/incidencias-v1.controller.ts` (`validarForma`, identificadores) | `descripcion_vacia (A4: ausente)`, `severidad_invalida (A4: ausente)`, `campo_ausente` |
| 5 | ✅ Implementado | `http/incidencias-v1.controller.ts` (`validarForma`) y `dominio/registrar-incidencia.use-case.ts` | Pruebas `A5: …` (null, `"4"`, `4.5`, `descripcion` numérica) |
| 6 | ✅ Implementado | Orden `401` → `400` → `422` → `409`. El puerto devuelve el estado de la operación o `null` (`dominio/incidencias.port.ts`, `estadoDeOperacion`); el caso de uso responde `OPERACION_INEXISTENTE` antes de evaluar el estado | `A6: tipo y operación con problemas a la vez`, `A6 operacion_inexistente`, `A6: rechaza operación inexistente` (dominio) |
| 7 | ✅ Implementado | `dominio/errores-incidencia.ts` (`ErrorDeIncidencia` con `codigo` y `campo`) y el adaptador, que lo traduce al cuerpo `{codigo, mensaje, campo}` | Todas las pruebas `400` verifican `campo` |
| 8 | ✅ Implementado | `dominio/registrar-incidencia.use-case.ts` (`LARGO_MAXIMO_DESCRIPCION`): recorta y después mide | `A8: devuelve la descripción sin los espacios`, `A8 descripcion_muy_larga` y 3 pruebas `A8:` de dominio (1000, 1001, 1000 con espacios) |
| 9 | ✅ Implementado | `Content-Type` distinto de JSON y cuerpo vacío: `validarForma`. JSON inválido: `http/errores-contrato.filter.ts`, filtro global registrado en `main.ts` que solo actúa en `/v1/incidencias` | `A9 cuerpo_no_json` (3 pruebas); `las demás rutas conservan el formato de error de Nest` |
| 10 | ✅ Implementado | Sin `Idempotency-Key`: cada llamada crea una incidencia | `A10: repetir la misma petición crea otra incidencia` |
| 11 | Documentación | Sin cambio de código: `GET /monitoreo/incidencias/{id}` ya existe | — |
| 12 | ✅ Implementado | La regla «solo `En curso`» pasó del adaptador TypeORM al dominio (`ESTADO_OPERACION_ADMITE_INCIDENCIAS`) | `A12 operacion_no_activa` (Pendiente, Completada, Cancelada) en el endpoint y en el dominio, con los dos adaptadores |
| 13 | ✅ Implementado | El caso de uso atrapa la falla de `notificarSupervisores`: la incidencia queda guardada y el alta responde `201` | `A13: si falla la notificación, la incidencia crítica igual queda registrada` |
| 14 | ✅ Implementado | `siguienteCodigo()` usa año y mes UTC en los dos adaptadores. Supone que la base guarda `fecha_hora` en UTC (zona por defecto en Supabase y Render) | `A14: el adaptador TypeORM usa año y mes UTC (2612)` (incluye la secuencia `10000`), `A14: el adaptador en memoria también usa UTC` |

El `POST /monitoreo/incidencias` anterior se retiró: el alta de incidencias es solo `POST /v1/incidencias`.

**Límite de las pruebas:** usan el adaptador en memoria, un *stub* de TypeORM y un guard de prueba. No se probó contra la base de datos ni con un JWT real.
