# Diseño: RN-08 — edición acotada de incidencias (sin borrado)

**Fecha:** 2026-11-21  
**Estado:** aprobado en brainstorming  
**Contexto:** observación docente — el registro de incidencias aún se puede editar y borrar vía `PUT`/`DELETE` en `monitoreo/controllers/incidencias.controller.ts`, en tensión con RN-08 / E3.

## Problema

RN-08 y E3 hablan de un alta de auditoría inmutable (`idUsuario` + `fechaHora`), pero el controlador legado de monitoreo expone:

- `PUT /monitoreo/incidencias/:id` — cualquier usuario autenticado puede cambiar campos, incluido potencialmente auditoría.
- `DELETE /monitoreo/incidencias/:id` — permite borrar el registro.

La UI de `app/monitoreo/incidencias/page.tsx` usa ambas operaciones.

Hoy las incidencias solo las crea un usuario autenticado (`POST /v1/incidencias` → `RegistrarIncidenciaUseCase`). No hay altas generadas por el sistema.

## Decisión

**Enfoque mínimo (aprobado):**

1. Retirar por completo el borrado (`DELETE` + UI).
2. Mantener la edición vía `PUT` para usuarios autenticados.
3. Proteger la auditoría: `idUsuario` / `fechaHora` no se modifican en el update.
4. Actualizar RN-08 y el texto de E3 para que digan qué se puede cambiar (contenido operativo) y qué no (auditoría + eliminación).
5. **Fuera de alcance:** `RolesGuard`, altas del sistema, caso de uso hexagonal de actualización.

## Regla de negocio (RN-08 revisada)

| Aspecto | Regla |
|---|---|
| Alta | Siempre guarda `idUsuario` y `fechaHora` (auditoría). |
| Inmutable | Esos dos campos no se actualizan después del alta. |
| Editable | Contenido operativo: tipo, descripción, severidad, estado. |
| Eliminación | No permitida. No existe `DELETE` de incidencias. |
| Quién edita (esta entrega) | Usuario autenticado con JWT (sin guard de roles todavía). |

E3 (seguridad y auditabilidad) queda alineado: registro con usuario + timestamp; edición acotada; sin borrado.

## Backend

**Archivos principales**

- `src/repo/app/backend/src/monitoreo/controllers/incidencias.controller.ts`
- `src/repo/app/backend/src/monitoreo/services/incidencias.service.ts`
- `src/repo/app/backend/src/monitoreo/README.md` (dejar de documentar DELETE)

**Cambios**

1. Eliminar el handler `@Delete(':id')` del controlador.
2. Eliminar `IncidenciasService.remove` (no queda método de borrado en el servicio legado).
3. Conservar `@Put(':id')` con `JwtAuthGuard`.
4. En `update`:
   - Aceptar solo: `id_tipo_incidencia`, `descripcion`, `grado_severidad`, `id_estado_incidencia`.
   - Si el body trae `id_usuario` o `fecha_hora`, **ignorarlos** (no persistir); no hace falta responder 400.
5. Validaciones existentes de tipo/estado se mantienen.

**Rutas resultantes (legado monitoreo)**

| Método | Ruta | Auth | Notas |
|---|---|---|---|
| GET | `/monitoreo/incidencias` | no (como hoy) | listado |
| GET | `/monitoreo/incidencias/:id` | no (como hoy) | detalle |
| PUT | `/monitoreo/incidencias/:id` | JWT | edición operativa |
| DELETE | — | — | **retirada** |

El alta canónica sigue en `POST /v1/incidencias` (contrato OpenAPI / rodaja).

## Frontend

**Archivo:** `src/repo/app/frontend/app/monitoreo/incidencias/page.tsx`

1. Quitar botón de eliminar, modal de confirmación y `fetch` con `DELETE`.
2. Mantener flujo de edición con `PUT`.
3. Ajustar copy/README de monitoreo si menciona borrado de incidencias.

## Documentación de producto

1. `docs/reglas-de-negocio.md` — reescribir RN-08 según la tabla de arriba; apuntar ubicación a controlador/servicio de update + ausencia de DELETE; prueba asociada.
2. `docs/arquitectura.md` — alinear el párrafo de E3 (registro inmutable de auditoría + edición acotada, sin eliminación), sin reabrir el alcance de la rodaja hexagonal.

## Pruebas

Mínimo aceptable:

1. `update` con body que incluye `id_usuario` / `fecha_hora`: esos campos en BD no cambian.
2. `DELETE /monitoreo/incidencias/:id` → 404 (ruta inexistente).

Si no hay suite e2e del controlador legado, añadir spec de controlador/servicio Nest alineado al estilo de `incidencias-v1.controller.spec.ts` o pruebas unitarias del servicio.

## Fuera de alcance

- Guard de roles (`Operario` / `Operador` / Supervisor).
- Distinción “generada por usuario” vs “generada por sistema”.
- Migrar el update al dominio hexagonal (`ActualizarIncidenciaUseCase`).
- Cambiar el contrato OpenAPI de `POST /v1/incidencias` (alta).

## Criterio de éxito frente a la observación

- Ya no se puede borrar una incidencia por API ni UI.
- Se puede editar contenido operativo con JWT.
- RN-08 y E3 documentan qué cambia, qué no, y que no hay eliminación.
- La auditoría del alta (`idUsuario`, `fechaHora`) permanece intacta tras un `PUT`.
