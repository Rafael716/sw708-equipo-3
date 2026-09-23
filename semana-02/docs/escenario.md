# Escenarios de Calidad — Sistema de Operaciones Marítimas y Monitoreo


## 1. Compatibilidad — Interoperabilidad

**Por qué:** ambos módulos son sistemas separados que deben intercambiar información sobre el estado de las operaciones de manera automática. Esta capacidad de comunicarse e interpretar correctamente los datos entre módulos es fundamental para garantizar que la información mostrada en el Módulo de Monitoreo corresponda con el estado registrado en el Módulo de Operaciones Marítimas.

| Parte | Descripción |
| --- | --- |
| **Fuente** | Módulo de Operaciones Marítimas |
| **Estímulo** | Se actualiza el estado de una operación (buque atracó, contenedor descargado) |
| **Artefacto** | Interfaz de integración entre ambos módulos |
| **Entorno** | Operación activa, horario normal 24/7 |
| **Respuesta** | El Módulo de Monitoreo recibe e interpreta correctamente el cambio de estado y lo refleja en su dashboard sin intervención manual |
| **Medida** | Al menos el 99% de los cambios de estado generados por el Módulo de Operaciones Marítimas son recibidos e interpretados correctamente por el Módulo de Monitoreo, sin intervención manual. |

---

## 2. Fiabilidad

**Por qué:** el sistema depende de la señal GPS/satelital para obtener la posición de los buques en tránsito, por lo que pueden producirse interrupciones de comunicación debido a condiciones climáticas o zonas sin cobertura. La fiabilidad busca garantizar que el sistema mantenga la información disponible y pueda recuperarse correctamente ante estas interrupciones, sin comprometer la trazabilidad histórica.

| Parte | Descripción |
| --- | --- |
| **Fuente** | Dispositivo GPS del buque |
| **Estímulo** | Se interrumpe la transmisión de posición durante la navegación |
| **Artefacto** | Submódulo de posiciones GPS del Módulo de Monitoreo |
| **Entorno** | Buque en tránsito, mar abierto |
| **Respuesta** | El sistema conserva la última posición válida, genera una alerta de pérdida de señal y ejecuta automáticamente el proceso de reconexión, manteniendo los registros históricos almacenados |
| **Medida** | Ante interrupciones de señal de hasta 30 minutos, el 99% de las pruebas debe conservar la última posición válida y mantener íntegros los registros históricos, sin intervención manual. La disponibilidad del submódulo deberá ser ≥99.5% durante el período de operación |

---

## 3. Seguridad

**Por qué:** ambos módulos manejan datos sensibles con implicancia legal — certificaciones aduaneras, incidencias críticas, evidencia digital de entrega.

| Parte | Descripción |
| --- | --- |
| **Fuente** | Personal de Seguridad / Operador de Monitoreo |
| **Estímulo** | Se registra una incidencia crítica en una operación marítima que también impacta el monitoreo de la carga |
| **Artefacto** | Módulo de Operaciones Marítimas (CU12) y Módulo de Monitoreo (CU05), interfaz compartida |
| **Entorno** | Operación en tránsito con incidencia activa |
| **Respuesta** | La incidencia se vincula entre ambos módulos, se notifica a supervisores de ambas áreas y queda en log de auditoría cifrado con usuario y timestamp |
| **Medida** | 100% de incidencias críticas auditables y cifradas; notificación a responsables en <24h |

---

## 4. Mantenibilidad

**Por qué:** este es un sistema que va a crecer (nuevos tipos de sensores, nuevas rutas, nuevas normativas aduaneras). "Cuánto cuesta cambiarlo" es una exigencia real cuando dos módulos distintos comparten reglas de negocio (ej. umbrales de sensores, tipos de incidencia) que cambian con el tiempo.

| Parte | Descripción |
| --- | --- |
| **Fuente** | Administrador del sistema / equipo de TI |
| **Estímulo** | Se necesita agregar un nuevo tipo de sensor IoT (ej. sensor de golpes) o modificar un umbral de alerta existente |
| **Artefacto** | Configuración de umbrales del Módulo de Monitoreo, consumida también por Operaciones Marítimas para incidencias |
| **Entorno** | Sistema en producción, sin detener operaciones activas |
| **Respuesta** | El cambio se aplica desde un panel de configuración sin necesidad de modificar código ni afectar otras operaciones en curso |
| **Medida** | El cambio se implementa y despliega en menos de 1 día-persona, sin downtime del sistema |

---

## 5. Capacidad de interacción

**Por qué:** hay actores muy distintos operando bajo presión (supervisor de puerto, personal de seguridad, coordinador de flota) que necesitan leer alertas de dos módulos a la vez sin confundirse. El documento mismo pide que el mapa "sea intuitivo y permita navegación sin capacitación previa".

| Parte | Descripción |
| --- | --- |
| **Fuente** | Coordinador de Flota (usuario nuevo, sin capacitación previa en el sistema) |
| **Estímulo** | Necesita identificar rápidamente si una operación marítima activa tiene una alerta de sensor o incidencia asociada en Monitoreo |
| **Artefacto** | Dashboard combinado de Operaciones Marítimas + mapa de Monitoreo |
| **Entorno** | Operación con múltiples buques activos simultáneamente |
| **Respuesta** | El sistema distingue visualmente por color (verde/amarillo/rojo) el estado de cada operación, sin requerir manual ni capacitación |
| **Medida** | Un usuario nuevo identifica correctamente el estado crítico de una operación en menos de 10 segundos, sin ayuda externa |

# Obersaciones del Equipo 2

### 1. Compatibilidad — Interoperabilidad

**Problema detectado:** La medida dice “99% de cambios recibidos e interpretados correctamente”, pero no indica **con qué instrumento** se verificará ni quién lo ejecutará.

### 2. Fiabilidad

**Problema detectado:** La medida menciona “pruebas”, pero no especifica qué herramienta concreta se utilizará para medir la disponibilidad ni quién será responsable de ejecutar las pruebas.

### 3. Seguridad

**Problema detectado:** La medida “100% de incidencias auditables y cifradas” indica el resultado esperado, pero no especifica un instrumento concreto para comprobarlo ni quién realizará la medición. Además, la métrica de **“notificación a responsables en <24h”** resulta poco precisa para una incidencia crítica, ya que no define con qué herramienta se medirá el tiempo de notificación.

### 4. Mantenibilidad

**Problema detectado:** La medida “menos de 1 día-persona” no especifica cómo se contabilizará el tiempo empleado ni quién realizará dicha medición. Además, la condición de “sin downtime” requiere un instrumento concreto que permita verificar la disponibilidad durante la aplicación del cambio.
