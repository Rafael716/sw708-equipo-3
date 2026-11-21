# RN-08 edición acotada de incidencias (sin borrado) — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Alinear el CRUD legado de incidencias con RN-08/E3: edición operativa con JWT, auditoría (`id_usuario`/`fecha_hora`) intacta, y sin `DELETE`.

**Architecture:** Cambios en el controlador/servicio Nest legados (`monitoreo/controllers` + `services`), no en la rodaja hexagonal de alta (`POST /v1/incidencias`). La UI de monitoreo pierde el borrado; RN-08 y E3 se documentan con la regla revisada.

**Tech Stack:** NestJS 11, TypeORM, Jest + Supertest, Next.js (App Router) en el frontend, docs Markdown en `docs/`.

**Spec:** `docs/superpowers/specs/2026-11-21-rn08-incidencias-edicion-design.md`

## Global Constraints

- No introducir `RolesGuard` ni distinguir altas generadas por el sistema.
- No migrar el update al dominio hexagonal.
- No cambiar el contrato OpenAPI de `POST /v1/incidencias`.
- En `update`, si el body trae `id_usuario` o `fecha_hora`, **ignorarlos** (no 400).
- Eliminar por completo `IncidenciasService.remove` y la ruta `DELETE`.
- Campos editables: `id_tipo_incidencia`, `descripcion`, `grado_severidad`, `id_estado_incidencia`.
- Responder en español en mensajes de commit estilo del repo (`fix:` / `docs:`).

---

## File map

| Archivo | Responsabilidad |
|---|---|
| `src/repo/app/backend/src/monitoreo/services/incidencias.service.ts` | `update` whitelist; quitar `remove` e `id_usuario` del DTO |
| `src/repo/app/backend/src/monitoreo/services/incidencias.service.spec.ts` | Pruebas unitarias del update (auditoría intacta) |
| `src/repo/app/backend/src/monitoreo/controllers/incidencias.controller.ts` | Quitar `@Delete`; dejar `@Put` |
| `src/repo/app/backend/src/monitoreo/controllers/incidencias.controller.spec.ts` | DELETE → 404; PUT llama a `update` |
| `src/repo/app/frontend/app/monitoreo/incidencias/page.tsx` | Quitar UI/estado/handlers de eliminar |
| `docs/reglas-de-negocio.md` | RN-08 revisada |
| `docs/arquitectura.md` | E3 alineado (respuesta de auditoría) |
| `src/repo/app/backend/src/monitoreo/README.md` | Dejar de documentar DELETE |
| `src/repo/app/frontend/app/monitoreo/README.md` | Edición sí / eliminación no |

---

### Task 1: Servicio — update whitelist y sin `remove`

**Files:**
- Create: `src/repo/app/backend/src/monitoreo/services/incidencias.service.spec.ts`
- Modify: `src/repo/app/backend/src/monitoreo/services/incidencias.service.ts`
- Test: `src/repo/app/backend/src/monitoreo/services/incidencias.service.spec.ts`

**Interfaces:**
- Consumes: repositorios TypeORM mockeados (`Incidencia`, `TipoIncidencia`, `EstadoIncidencia`)
- Produces: `IncidenciasService.update(id, data)` persiste solo campos operativos; no existe `remove`

- [ ] **Step 1: Write the failing test**

Crear `incidencias.service.spec.ts`:

```typescript
import { IncidenciasService } from './incidencias.service';

describe('IncidenciasService.update (RN-08)', () => {
  const incidenciaExistente = {
    id_incidencia: 'inc-1',
    codigo: 'INC-2611-0001',
    descripcion: 'Original',
    grado_severidad: 2,
    fecha_hora: new Date('2026-01-15T10:00:00.000Z'),
    id_usuario: 'user-alta',
    id_tipo_incidencia: 'tipo-1',
    id_estado_incidencia: 'estado-1',
    id_operacion: 'op-1',
    tipo_incidencia: { id_tipo_incidencia: 'tipo-1', nombre: 'Avería' },
    estado_incidencia: { id_estado_incidencia: 'estado-1', nombre: 'Abierta' },
    operacion: { codigo: 'OP-1' },
  };

  let service: IncidenciasService;
  let incidenciaRepository: {
    findOne: jest.Mock;
    update: jest.Mock;
    remove: jest.Mock;
  };
  let tipoIncidenciaRepository: { findOne: jest.Mock };
  let estadoIncidenciaRepository: { findOne: jest.Mock };

  beforeEach(() => {
    incidenciaRepository = {
      findOne: jest.fn().mockResolvedValue(incidenciaExistente),
      update: jest.fn().mockResolvedValue({ affected: 1 }),
      remove: jest.fn(),
    };
    tipoIncidenciaRepository = {
      findOne: jest.fn().mockResolvedValue({ id_tipo_incidencia: 'tipo-2' }),
    };
    estadoIncidenciaRepository = {
      findOne: jest.fn().mockResolvedValue({ id_estado_incidencia: 'estado-2' }),
    };

    service = new IncidenciasService(
      incidenciaRepository as never,
      tipoIncidenciaRepository as never,
      estadoIncidenciaRepository as never,
    );
  });

  it('no persiste id_usuario ni fecha_hora aunque vengan en el body', async () => {
    await service.update('inc-1', {
      descripcion: 'Actualizada',
      grado_severidad: 4,
      id_tipo_incidencia: 'tipo-2',
      id_estado_incidencia: 'estado-2',
      // @ts-expect-error campos de auditoría no forman parte del DTO público
      id_usuario: 'atacante',
      // @ts-expect-error
      fecha_hora: new Date('2099-01-01T00:00:00.000Z'),
    });

    expect(incidenciaRepository.update).toHaveBeenCalledWith('inc-1', {
      descripcion: 'Actualizada',
      grado_severidad: 4,
      id_tipo_incidencia: 'tipo-2',
      id_estado_incidencia: 'estado-2',
    });
    expect(incidenciaRepository.update.mock.calls[0][1]).not.toHaveProperty(
      'id_usuario',
    );
    expect(incidenciaRepository.update.mock.calls[0][1]).not.toHaveProperty(
      'fecha_hora',
    );
  });

  it('no expone remove (método eliminado)', () => {
    expect(
      (service as unknown as { remove?: unknown }).remove,
    ).toBeUndefined();
  });
});
```

- [ ] **Step 2: Run test to verify it fails**

Run (desde `src/repo/app/backend`):

```bash
pnpm test -- incidencias.service.spec.ts
```

Expected: FAIL — el `update` actual pasa el `data` completo (incluye `id_usuario`) y/o `remove` aún existe.

- [ ] **Step 3: Write minimal implementation**

En `incidencias.service.ts`:

1. Cambiar el DTO:

```typescript
export interface UpdateIncidenciaDto {
  id_tipo_incidencia?: string;
  descripcion?: string;
  grado_severidad?: number;
  id_estado_incidencia?: string;
}
```

2. Reemplazar el cuerpo de `update` para construir un payload whitelist:

```typescript
async update(id: string, data: UpdateIncidenciaDto) {
  try {
    await this.findOne(id);

    if (data.id_tipo_incidencia) {
      const tipoExists = await this.tipoIncidenciaRepository.findOne({
        where: { id_tipo_incidencia: data.id_tipo_incidencia },
      });
      if (!tipoExists) {
        throw new BadRequestException('Tipo de incidencia no válido');
      }
    }

    if (data.id_estado_incidencia) {
      const estadoExists = await this.estadoIncidenciaRepository.findOne({
        where: { id_estado_incidencia: data.id_estado_incidencia },
      });
      if (!estadoExists) {
        throw new BadRequestException('Estado de incidencia no válido');
      }
    }

    const payload: UpdateIncidenciaDto = {};
    if (data.id_tipo_incidencia !== undefined) {
      payload.id_tipo_incidencia = data.id_tipo_incidencia;
    }
    if (data.descripcion !== undefined) {
      payload.descripcion = data.descripcion;
    }
    if (data.grado_severidad !== undefined) {
      payload.grado_severidad = data.grado_severidad;
    }
    if (data.id_estado_incidencia !== undefined) {
      payload.id_estado_incidencia = data.id_estado_incidencia;
    }

    await this.incidenciaRepository.update(id, payload);

    return await this.findOne(id);
  } catch (error) {
    if (
      error instanceof BadRequestException ||
      error instanceof NotFoundException
    ) {
      throw error;
    }
    console.error('Error en update incidencia:', error.message);
    throw new Error('Error al actualizar la incidencia');
  }
}
```

3. **Eliminar** por completo el método `async remove(...) { ... }`.

4. Actualizar el comentario sobre el create legado: que diga que listar y update siguen aquí; delete ya no.

- [ ] **Step 4: Run tests to verify they pass**

```bash
pnpm test -- incidencias.service.spec.ts
```

Expected: PASS (ambos `it`).

- [ ] **Step 5: Commit**

```bash
git add src/repo/app/backend/src/monitoreo/services/incidencias.service.ts \
  src/repo/app/backend/src/monitoreo/services/incidencias.service.spec.ts
git commit -m "$(cat <<'EOF'
fix: RN-08 — update de incidencias sin tocar auditoría ni borrar

Whitelist de campos operativos en el servicio legado y eliminación
del método remove.
EOF
)"
```

---

### Task 2: Controlador — retirar DELETE y cubrir con prueba HTTP

**Files:**
- Create: `src/repo/app/backend/src/monitoreo/controllers/incidencias.controller.spec.ts`
- Modify: `src/repo/app/backend/src/monitoreo/controllers/incidencias.controller.ts`
- Test: `src/repo/app/backend/src/monitoreo/controllers/incidencias.controller.spec.ts`

**Interfaces:**
- Consumes: `IncidenciasService.update` (sin `remove`)
- Produces: `PUT /monitoreo/incidencias/:id` autenticado; sin ruta DELETE

- [ ] **Step 1: Write the failing test**

Crear `incidencias.controller.spec.ts`:

```typescript
import {
  ExecutionContext,
  INestApplication,
  UnauthorizedException,
} from '@nestjs/common';
import { Test } from '@nestjs/testing';
import request from 'supertest';
import type { App } from 'supertest/types';
import { JwtAuthGuard } from '../../auth/guards/jwt-auth.guard';
import { IncidenciasService } from '../services/incidencias.service';
import { IncidenciasController } from './incidencias.controller';

const guardDePrueba = {
  canActivate(ctx: ExecutionContext): boolean {
    const req = ctx
      .switchToHttp()
      .getRequest<{ headers: Record<string, string>; user?: unknown }>();
    if (req.headers.authorization !== 'Bearer token-valido') {
      throw new UnauthorizedException();
    }
    req.user = { id_usuario: 'user-1' };
    return true;
  },
};

describe('IncidenciasController (RN-08)', () => {
  let app: INestApplication<App>;
  const incidenciasService = {
    findAll: jest.fn(),
    getEstadisticas: jest.fn(),
    getTiposIncidencia: jest.fn(),
    getEstadosIncidencia: jest.fn(),
    findOne: jest.fn(),
    update: jest.fn().mockResolvedValue({ id_incidencia: 'inc-1' }),
  };

  beforeEach(async () => {
    jest.clearAllMocks();
    const modulo = await Test.createTestingModule({
      controllers: [IncidenciasController],
      providers: [
        { provide: IncidenciasService, useValue: incidenciasService },
      ],
    })
      .overrideGuard(JwtAuthGuard)
      .useValue(guardDePrueba)
      .compile();

    app = modulo.createNestApplication();
    await app.init();
  });

  afterEach(async () => {
    await app.close();
  });

  it('DELETE /monitoreo/incidencias/:id responde 404 (ruta retirada)', async () => {
    await request(app.getHttpServer())
      .delete('/monitoreo/incidencias/inc-1')
      .set('Authorization', 'Bearer token-valido')
      .expect(404);
  });

  it('PUT /monitoreo/incidencias/:id delega en update con body operativo', async () => {
    const body = {
      descripcion: 'Nueva descripción',
      grado_severidad: 3,
      id_estado_incidencia: 'estado-2',
    };

    await request(app.getHttpServer())
      .put('/monitoreo/incidencias/inc-1')
      .set('Authorization', 'Bearer token-valido')
      .send(body)
      .expect(200);

    expect(incidenciasService.update).toHaveBeenCalledWith('inc-1', body);
  });
});
```

- [ ] **Step 2: Run test to verify it fails**

```bash
pnpm test -- incidencias.controller.spec.ts
```

Expected: FAIL en el caso DELETE (hoy responde 200/201 o llama a `remove`, no 404) y/o el controlador aún importa `Delete`.

- [ ] **Step 3: Write minimal implementation**

En `incidencias.controller.ts`:

1. Quitar `Delete` del import de `@nestjs/common`.
2. Eliminar el método completo:

```typescript
@Delete(':id')
@UseGuards(JwtAuthGuard)
remove(@Param('id') id: string) {
  return this.incidenciasService.remove(id);
}
```

3. Dejar el `@Put(':id')` intacto (sigue usando `UpdateIncidenciaDto` del servicio).

Archivo resultante relevante:

```typescript
@Put(':id')
@UseGuards(JwtAuthGuard)
update(@Param('id') id: string, @Body() data: UpdateIncidenciaDto) {
  return this.incidenciasService.update(id, data);
}
```

- [ ] **Step 4: Run tests to verify they pass**

```bash
pnpm test -- incidencias.controller.spec.ts incidencias.service.spec.ts
```

Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add src/repo/app/backend/src/monitoreo/controllers/incidencias.controller.ts \
  src/repo/app/backend/src/monitoreo/controllers/incidencias.controller.spec.ts
git commit -m "$(cat <<'EOF'
fix: retira DELETE de incidencias en el controlador de monitoreo

La ruta deja de existir (404); PUT autenticado se mantiene para
edición operativa.
EOF
)"
```

---

### Task 3: Frontend — quitar eliminar en la lista de incidencias

**Files:**
- Modify: `src/repo/app/frontend/app/monitoreo/incidencias/page.tsx`
- Modify: `src/repo/app/frontend/app/monitoreo/README.md` (sección 5)
- Test: verificación manual / grep (no hay suite Jest de esta página)

**Interfaces:**
- Consumes: `PUT /monitoreo/incidencias/:id` (sin cambios de contrato)
- Produces: UI sin botón/modal/fetch DELETE

- [ ] **Step 1: Remove delete state and handlers**

En `page.tsx`, eliminar:

- Estado `showDeleteModal` e `incidenciaEliminar`
- Funciones `handleEliminarIncidencia` y `confirmarEliminar`
- El botón con `title="Eliminar"` en la tabla
- El bloque JSX `{/* Modal Eliminar */} ...`

Dejar intactos `handleEditarIncidencia`, el modal de edición y el `PUT`.

- [ ] **Step 2: Verify no DELETE calls remain in incidencias UI**

```bash
rg -n "DELETE|Eliminar|handleEliminar|showDeleteModal" \
  src/repo/app/frontend/app/monitoreo/incidencias/
```

Expected: sin matches de borrado (puede quedar la palabra “editar”).

- [ ] **Step 3: Update frontend monitoreo README**

En `src/repo/app/frontend/app/monitoreo/README.md`, sección 5, después de la viñeta de `page.tsx`, asegurar este matiz (añadir o ajustar una frase):

```markdown
  - Permite **editar** incidencias existentes (contenido operativo).
  - **No** permite eliminar incidencias (RN-08: registro de auditoría sin borrado).
```

Y en la línea de `[id]/page.tsx` sobre “actualizar estado / cerrar”, dejar claro que eso es edición de estado, no borrado.

- [ ] **Step 4: Commit**

```bash
git add src/repo/app/frontend/app/monitoreo/incidencias/page.tsx \
  src/repo/app/frontend/app/monitoreo/README.md
git commit -m "$(cat <<'EOF'
fix: quita borrado de incidencias en la UI de monitoreo

La lista solo permite ver y editar; alineado con RN-08.
EOF
)"
```

---

### Task 4: Documentación RN-08 / E3 / README backend

**Files:**
- Modify: `docs/reglas-de-negocio.md`
- Modify: `docs/arquitectura.md` (Tabla 2.3, fila Respuesta; y fila E3 en tabla de escenarios si aplica)
- Modify: `src/repo/app/backend/src/monitoreo/README.md`

**Interfaces:**
- Consumes: comportamiento de Tasks 1–2
- Produces: docs alineadas al criterio de éxito del spec

- [ ] **Step 1: Update RN-08 in `docs/reglas-de-negocio.md`**

Reemplazar la fila RN-08 por:

```markdown
| RN-08 | El alta fija `idUsuario` y `fechaHora` (auditoría inmutable). Un usuario autenticado puede actualizar contenido operativo (tipo, descripción, severidad, estado) vía `PUT /monitoreo/incidencias/:id`; no existe eliminación de incidencias. | Alta: use case `ejecutar` + `Incidencias.guardar`. Edición: `incidencias.service.ts` · `update` (whitelist). Sin `DELETE` en `incidencias.controller.ts`. | `registrar-incidencia.spec.ts` (alta con `idUsuario`/`fechaHora`); `incidencias.service.spec.ts` (update no persiste auditoría); `incidencias.controller.spec.ts` (DELETE → 404) |
```

- [ ] **Step 2: Align E3 wording in `docs/arquitectura.md`**

En **Tabla 2.3**, fila **Respuesta**, cambiar a:

```markdown
| **Respuesta** | Alta con `usuario_id` y `timestamp` inmutables; edición posterior solo de contenido operativo (sin borrar la incidencia); notificación automática a supervisores si la severidad es crítica. |
```

En la tabla de escenarios de calidad (fila E3 ~línea 173), ajustar la celda de respuesta/alcance a:

```markdown
| E3 Seguridad y auditabilidad | 3 | 2 | Alta | Rodaja de Incidencias: alta con usuario + timestamp inmutables, operación activa, notificación en severidad 5; sin borrado de incidencias (ADR-0003 / RN-08). |
```

- [ ] **Step 3: Update backend monitoreo README**

En `src/repo/app/backend/src/monitoreo/README.md`, bloque de incidencias:

- Quitar las líneas de `DELETE /monitoreo/incidencias/:id`.
- Ajustar `PUT` a: “Actualiza contenido operativo (tipo, descripción, severidad, estado). No modifica `id_usuario` ni `fecha_hora`.”
- Si aún documenta `POST /monitoreo/incidencias` como alta principal, añadir nota de que el alta canónica es `POST /v1/incidencias` (sin reabrir el scope de OpenAPI).

- [ ] **Step 4: Commit**

```bash
git add docs/reglas-de-negocio.md docs/arquitectura.md \
  src/repo/app/backend/src/monitoreo/README.md
git commit -m "$(cat <<'EOF'
docs: alinea RN-08 y E3 con edición acotada sin borrado

Documenta whitelist de update, auditoría inmutable y ausencia de DELETE.
EOF
)"
```

---

### Task 5: Verificación final

**Files:** ninguno nuevo (solo corridas)

- [ ] **Step 1: Run backend unit/controller specs**

Desde `src/repo/app/backend`:

```bash
pnpm test -- incidencias.service.spec.ts incidencias.controller.spec.ts
```

Expected: PASS.

- [ ] **Step 2: Grep safety net**

Desde la raíz del repo:

```bash
rg -n "@Delete|incidenciasService\.remove|method:\s*[\"']DELETE[\"']" \
  src/repo/app/backend/src/monitoreo/controllers/incidencias.controller.ts \
  src/repo/app/backend/src/monitoreo/services/incidencias.service.ts \
  src/repo/app/frontend/app/monitoreo/incidencias/
```

Expected: sin matches.

- [ ] **Step 3: Confirm RN-08 text mentions no DELETE**

```bash
rg -n "RN-08" docs/reglas-de-negocio.md
```

Expected: la fila incluye “no existe eliminación” (o equivalente) y apunta a los tres archivos de prueba.

- [ ] **Step 4: No empty commit** — si todo ya está commiteado en Tasks 1–4, no crear commit vacío. Si quedó algún archivo del plan sin stagear, incluirlo:

```bash
git status
```

---

## Spec coverage (self-review)

| Requisito del spec | Task |
|---|---|
| Retirar DELETE (ruta + método) | 1, 2 |
| Mantener PUT + JWT | 2 |
| Ignorar `id_usuario` / `fecha_hora` en update | 1 |
| Whitelist campos operativos | 1 |
| Quitar UI de eliminar | 3 |
| Actualizar RN-08 | 4 |
| Alinear E3 en arquitectura | 4 |
| README monitoreo backend | 4 |
| Prueba update no toca auditoría | 1 |
| Prueba DELETE → 404 | 2 |
| Fuera de alcance (roles, hexagonal update, OpenAPI alta) | No hay tasks — correcto |

## Placeholder scan

Sin TBD/TODO; pasos con código, comandos y expected output concretos.
