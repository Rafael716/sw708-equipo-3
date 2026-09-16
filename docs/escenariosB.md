# Escenarios de Calidad — Sistema de Operaciones Marítimas y Monitoreo

> **Opción B — Escenarios sobre el sistema tal como existe hoy**
> Estos escenarios reescriben los artefactos, estímulos y respuestas para que reflejen la arquitectura real del repositorio actual. No asumen funcionalidad nueva. Son el punto de partida honesto; desde aquí el equipo puede decidir qué mejorar y medirlo con números reales en la semana 12.

> **Contexto de la Opción A (`escenarios.md`):** los escenarios de la versión A describen funcionalidad que el equipo se compromete a construir o completar durante SW708 (2026-2). Los artefactos mencionados allí (interfaz de integración entre módulos, canal GPS con reconexión automática, umbral formalizado de incidencia crítica, panel de configuración de umbrales) no están implementados en el repositorio actual. La validez de esos escenarios depende de que el equipo los haga demostrables antes de la semana 12. Este archivo documenta la alternativa en caso de que el equipo decida ajustar el alcance.

---

## 1. Compatibilidad — Consistencia de datos entre módulos sobre BD compartida

**Por qué:** los módulos de Operaciones Marítimas y Monitoreo no tienen una interfaz explícita entre ellos — comparten las mismas tablas PostgreSQL. El riesgo real no es una falla de integración, sino una inconsistencia de estado cuando ambos módulos escriben o leen la misma fila de forma concurrente.

| Parte | Descripción |
| --- | --- |
| **Fuente** | Operador del Módulo de Operaciones Marítimas |
| **Estímulo** | Registra un cambio de estado en una operación (INSERT/UPDATE en la tabla compartida) mientras el Módulo de Monitoreo tiene una consulta activa sobre esa misma tabla |
| **Artefacto** | Tablas de operaciones compartidas en la base de datos PostgreSQL |
| **Entorno** | Operación normal con acceso concurrente de ambos módulos a la misma BD |
| **Respuesta** | El Módulo de Monitoreo refleja el nuevo estado en su siguiente consulta, sin mostrar datos del estado anterior ni errores de lectura |
| **Medida** | En 100 ciclos de escritura concurrente simulados, 0 lecturas devuelven un estado desactualizado o inconsistente |

---

## 2. Fiabilidad — Datos GPS desactualizados por ausencia de nuevas filas

**Por qué:** `gps.service.ts` no recibe una transmisión activa — ejecuta un `SELECT ... ORDER BY fecha_hora DESC LIMIT` sobre filas ya insertadas. El riesgo real no es una "interrupción de canal", sino que el sistema deje de recibir nuevas filas y continúe mostrando la última posición como si fuera actual, sin ningún aviso al usuario.

| Parte | Descripción |
| --- | --- |
| **Fuente** | Proceso o script externo que inserta posiciones GPS en la BD |
| **Estímulo** | No se insertan nuevas filas de posición GPS durante un período prolongado (simulando pérdida de señal del dispositivo) |
| **Artefacto** | `gps.service.ts` y la tabla de posiciones GPS en PostgreSQL |
| **Entorno** | Al menos un buque registrado con historial de posiciones previas; sistema en operación normal |
| **Respuesta** | El sistema muestra la última posición registrada acompañada de un indicador visible de "sin actualización reciente" con la hora de la última fila disponible |
| **Medida** | Transcurridos 15 minutos sin nuevas filas, el 100% de las consultas al dashboard muestran el aviso de desactualización junto a la última posición válida |

---

## 3. Seguridad — Trazabilidad de incidencias registradas

**Por qué:** la entidad `Incidencia` existe en el repositorio y guarda `grado_severidad` como entero, pero no hay regla que defina desde qué valor una incidencia es "crítica" ni obligación de que quede vinculada a un usuario y timestamp. El riesgo real es que una incidencia grave quede registrada sin responsable identificable.

| Parte | Descripción |
| --- | --- |
| **Fuente** | Cualquier usuario autenticado del sistema (personal de seguridad u operador) |
| **Estímulo** | Se crea una nueva `Incidencia` con `grado_severidad` ≥ 8 (umbral a definir formalmente por el equipo) |
| **Artefacto** | Entidad `Incidencia` en el Módulo de Operaciones Marítimas |
| **Entorno** | Sistema en operación normal con sesión autenticada activa |
| **Respuesta** | El registro queda almacenado con el identificador del usuario que lo creó, el timestamp de creación y el ID de la operación afectada |
| **Medida** | El 100% de las incidencias con `grado_severidad` ≥ 8 creadas durante la prueba tienen usuario_id y timestamp no nulos y son consultables por ID de operación |

---

## 4. Mantenibilidad — Costo de modificar una regla de negocio en el código

**Por qué:** no existe panel de configuración ni tabla de umbrales en el repositorio (`grep "umbral"` no devuelve resultados). Hoy, cambiar una regla de negocio (ej. el porcentaje de descuento por volumen, el límite de contenedores por buque) implica modificar directamente el código fuente. El escenario mide cuánto cuesta hacer ese cambio de forma segura.

| Parte | Descripción |
| --- | --- |
| **Fuente** | Desarrollador del equipo de TI |
| **Estímulo** | Se requiere modificar una regla de negocio existente (ej. cambiar el umbral de descuento por volumen de 5 contenedores a 8) |
| **Artefacto** | Código fuente del backend NestJS — servicio o módulo donde vive la regla |
| **Entorno** | Entorno de desarrollo local con acceso al repositorio y BD de prueba |
| **Respuesta** | El desarrollador localiza la regla, la modifica, ejecuta las pruebas existentes y verifica que el cambio no afecta otros módulos |
| **Medida** | El cambio se identifica, implementa, prueba y confirma en menos de 4 horas-persona; 0 pruebas existentes fallan como efecto secundario |

---

## 5. Capacidad de interacción — Identificación visual de estado crítico sin capacitación

> Este escenario no cambia entre Opción A y Opción B: describe un comportamiento de interfaz que puede validarse sobre la UI actual.

**Por qué:** hay actores muy distintos operando bajo presión (supervisor de puerto, personal de seguridad, coordinador de flota) que necesitan leer alertas de dos módulos a la vez sin confundirse. El documento mismo pide que el mapa "sea intuitivo y permita navegación sin capacitación previa". Esta categoría del ISO/IEC 25010 es la vieja usabilidad — que se sienta cualitativa es la naturaleza del atributo, no un error de clasificación.

| Parte | Descripción |
| --- | --- |
| **Fuente** | Coordinador de Flota (usuario nuevo, sin capacitación previa en el sistema) |
| **Estímulo** | Necesita identificar rápidamente si una operación marítima activa tiene una alerta de sensor o incidencia asociada en Monitoreo |
| **Artefacto** | Dashboard combinado de Operaciones Marítimas + mapa de Monitoreo |
| **Entorno** | Operación con múltiples buques activos simultáneamente |
| **Respuesta** | El sistema distingue visualmente por color (verde/amarillo/rojo) el estado de cada operación, sin requerir manual ni capacitación |
| **Medida** | Un usuario nuevo identifica correctamente el estado crítico de una operación en menos de 10 segundos, sin ayuda externa |
