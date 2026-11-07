# API de Monitoreo — Incidencias

Contrato del endpoint **`POST /monitoreo/incidencias`** del módulo de Monitoreo.

- Contrato OpenAPI 3.1: [`openapi.yaml`](./openapi.yaml). El YAML contiene solo la definición del contrato, sin comentarios ni justificaciones.
- Validación: `validator.swagger.io` respondió `{}` (sin errores).

---

## 1. Modos de falla (antes del camino feliz)

| HTTP | Cuándo ocurre | Cuerpo |
| --- | --- | --- |
| **400** | `descripcion` vacía, `grado_severidad` fuera de 1..5, `id_tipo_incidencia` inexistente, `id_operacion` inexistente o no está en `En curso`, no existe el estado `Abierta`, o un UUID tiene formato inválido. | `{ statusCode: 400, message: "...", error: "Bad Request" }` |
| **401** | Falta `Authorization`, el token no es Bearer, está vencido, la firma es inválida o el usuario del token ya no existe. | `{ statusCode: 401, message: "Unauthorized" }` |
| **500** | Fallo no controlado fuera del `try` del controlador. | `{ statusCode: 500, message: "Internal server error" }` |

**Decisiones explícitas del contrato:**

- **No hay 404.** Si la operación no existe, `operacionEstaActiva()` devuelve `false` y el caso de uso responde `400 La operación no está activa`. No se distingue "no existe" de "existe pero no está activa".
- **No hay 409.** El `codigo` (`INC-YYMM-NNNN`) lo genera el servidor. Una colisión por concurrencia hoy se convierte en 400 por el `catch` del controlador.
- **No hay 403.** El endpoint solo usa `JwtAuthGuard`; no hay validación de rol. Cualquier usuario autenticado puede registrar una incidencia.
- **El controlador convierte en 400 casi cualquier error** del caso de uso o de la recarga de la incidencia (`BadRequestException(error.message)`). Por eso el 500 queda reservado para fallos no capturados por ese `try`.

Ejemplo de un 400 documentado:

```yaml
'400':
  description: Error de validación de negocio.
  content:
    application/json:
      schema:
        $ref: '#/components/schemas/Error'
      examples:
        descripcion_vacia:
          value:
            statusCode: 400
            message: La descripción no puede estar vacía
            error: Bad Request
        operacion_inactiva_o_inexistente:
          value:
            statusCode: 400
            message: La operación no está activa
            error: Bad Request
```

---

## 2. Las cinco preguntas del contrato

| Qué se revisa | Respuesta |
| --- | --- |
| **El recurso** | El recurso es **`Incidencia`**. La ruta `POST /monitoreo/incidencias` usa un sustantivo, no un verbo; la acción "crear" vive en `operationId: crearIncidencia`. |
| **Los errores** | `400`, `401` y `500`, con los cuerpos indicados arriba. No se declaran `404`, `409` ni `403` porque la implementación actual no los produce. |
| **Los datos obligatorios** | En el cuerpo: `id_tipo_incidencia`, `descripcion`, `grado_severidad`, `id_operacion`. `id_usuario` **no** se envía: se obtiene del JWT. |
| **El versionado** | Versión **`1.0.0`** (SemVer). Sube a **`2.0.0`** si se agrega un campo obligatorio, se elimina o renombra un campo del 201, o cambia el status `201`. Sube a **`1.1.0`** si solo se agrega algo opcional/compatible; a **`1.0.1`** si solo se corrigen ejemplos o redacción. |
| **Los ejemplos** | Hay una petición y una respuesta concretas, incluidas en el contrato y en la sección 4 de este README. |

### Si falta un campo obligatorio

| Campo faltante | Respuesta |
| --- | --- |
| `descripcion` | `400 La descripción no puede estar vacía` |
| `grado_severidad` | `400 El grado de severidad debe ser un entero entre 1 y 5` |
| `id_tipo_incidencia` | `400 Tipo de incidencia no válido` |
| `id_operacion` | `400 La operación es obligatoria` |
| `Authorization` | `401 Unauthorized` |

Si faltan varios, se reporta el primero según el orden de validación: `descripcion`, `grado_severidad`, `id_tipo_incidencia`, `id_operacion`.

---

## 3. Versionado

- Versión del contrato: **`1.0.0`** (`info.version`, SemVer). No se toma de `package.json` del backend.
- Sube a **`2.0.0`** ante un cambio incompatible: agregar un campo obligatorio al request, eliminar o renombrar un campo del 201, cambiar el status `201` por otro, o convertir un 400/401 existente en otro código que el cliente deba manejar.
- Sube a **`1.1.0`** ante un cambio compatible: agregar un campo opcional al request, agregar un campo nuevo a la respuesta o agregar un modo de falla que no rompa clientes.
- Sube a **`1.0.1`** si solo se corrigen redacción, ejemplos o descripciones.

---

## 4. Camino feliz

**Petición real:**

```json
{
  "id_tipo_incidencia": "6f1c2b9e-3a4d-4c8e-9f10-2b7d5a6c8e01",
  "descripcion": "Sensor de temperatura del contenedor fuera de rango",
  "grado_severidad": 4,
  "id_operacion": "0b7e4c2a-9d31-4f6a-8c5e-1a2b3c4d5e6f"
}
```

**Respuesta real `201 Created`:**

```json
{
  "id_incidencia": "9f2c7a41-6b3e-4d58-8c1a-7e0f2b9d4a63",
  "codigo": "INC-2611-0001",
  "id_tipo_incidencia": "6f1c2b9e-3a4d-4c8e-9f10-2b7d5a6c8e01",
  "descripcion": "Sensor de temperatura del contenedor fuera de rango",
  "grado_severidad": 4,
  "fecha_hora": "2026-11-07T15:42:10.123Z",
  "id_estado_incidencia": "a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d",
  "id_operacion": "0b7e4c2a-9d31-4f6a-8c5e-1a2b3c4d5e6f",
  "id_usuario": "c4d5e6f7-a8b9-4c0d-9e1f-2a3b4c5d6e7f",
  "tipo_incidencia": {
    "id_tipo_incidencia": "6f1c2b9e-3a4d-4c8e-9f10-2b7d5a6c8e01",
    "nombre": "Temperatura"
  },
  "estado_incidencia": {
    "id_estado_incidencia": "a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d",
    "nombre": "Abierta"
  },
  "operacion": {
    "id_operacion": "0b7e4c2a-9d31-4f6a-8c5e-1a2b3c4d5e6f",
    "codigo": "OP-2026-0042",
    "fecha_inicio": "2026-11-07T08:00:00.000Z",
    "fecha_fin": null,
    "id_estado_operacion": "d4e5f6a7-b8c9-4d0e-9f1a-2b3c4d5e6f70"
  }
}
```

---

## 5. Notas de implementación

- `id_usuario` y `fecha_hora` los fija el servidor; no se aceptan desde el cuerpo.
- El estado inicial de una incidencia creada es `Abierta`.
- Si `grado_severidad` es `5`, el caso de uso intenta notificar a supervisores. El adaptador omite la notificación si faltan catálogos sembrados y eso no cambia la respuesta HTTP.
- **Defecto conocido:** el formato UUID no se valida en el borde. PostgreSQL lanza el error y el controlador lo convierte en 400, por lo que el mensaje puede exponer detalles del motor. El contrato documenta ese caso como `uuid_mal_formado`.
- El cuerpo de error real de NestJS usa `statusCode`, `message` y `error`; no se usa el formato `{ codigo, mensaje }` del ejemplo genérico.
