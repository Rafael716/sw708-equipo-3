# Bitácora IA — Semana 02

**Herramienta utilizada:** Claude (claude.ai)
**Rol asignado a la IA:** atacar cada escenario con la pregunta: *¿con qué instrumento concreto se puede medir esto?*

> Los cinco escenarios fueron redactados primero por el equipo a mano, en el laboratorio. La IA entró después, únicamente para atacar la medida. No participó en la definición de fuente, estímulo, artefacto, entorno ni respuesta.

---

## Escenario 1 — Compatibilidad (interoperabilidad entre módulos)

**Prompt enviado:**
> Actúa como abogada del diablo. Tengo este escenario de calidad y quiero que me preguntes, solo eso, con qué instrumento concreto se puede medir lo que dice la medida. [escenario completo]

**Crítica devuelta:**

| Pregunta de la IA | Instrumento sugerido por la IA |
|---|---|
| ¿Qué herramienta genera los cambios de estado durante la prueba? | Un script o suite de pruebas que llame al endpoint de actualización de estado |
| ¿Qué herramienta cuenta los cambios que llegaron vs. los que no? | Un contador en los logs del Módulo de Monitoreo o una prueba de integración con aserciones |
| ¿Cómo se define "interpretado correctamente" en términos verificables — qué campo o respuesta del sistema lo confirma? | Comparar el estado devuelto por el endpoint de Monitoreo contra el valor escrito por Operaciones Marítimas |

**Veredicto del equipo:**

| | |
|---|---|
| **Aceptado** | Se nombra el instrumento: prueba de integración con Jest + Supertest que genera cambios de estado vía endpoint y verifica que el estado aparezca correctamente en la respuesta del Módulo de Monitoreo. "Interpretado correctamente" se define como que el campo `estado` devuelto por Monitoreo coincide con el valor registrado por Operaciones Marítimas. |
| **Descartado** | La IA sugirió implantar un broker de mensajes (RabbitMQ o Kafka) para que los eventos sean rastreables de forma nativa. Se descarta: rediseñar la arquitectura de comunicación está fuera del alcance del escenario; el equipo trabaja sobre la BD compartida existente. |

---

## Escenario 2 — Fiabilidad (pérdida de señal GPS)

**Prompt enviado:**
> Actúa como abogada del diablo. Tengo este escenario de calidad y quiero que me preguntes, solo eso, con qué instrumento concreto se puede medir lo que dice la medida. [escenario completo]

**Crítica devuelta:**

| Pregunta de la IA | Instrumento sugerido por la IA |
|---|---|
| ¿Cómo se simula la interrupción de 30 minutos — se corta una conexión de red, se detiene un proceso, se deja de insertar filas? | Detener el proceso de inserción de filas GPS en la BD durante el período definido |
| ¿Cuántas pruebas componen el "99%" — qué tamaño de muestra define ese porcentaje? | Definir N ejecuciones del escenario y contar las que conservan la última posición sin error |
| ¿Con qué herramienta se verifica que la disponibilidad del submódulo es ≥99.5% — quién mide el uptime? | Monitor de health check externo con registro de tiempo de respuesta |
| ¿Qué significa "sin intervención manual" en términos verificables — el sistema detecta la pérdida solo y genera la alerta automáticamente, o solo deja de actualizar? | Un test automatizado que verifique que el endpoint de posición devuelve la última fila válida sin requerir acción del operador |

**Veredicto del equipo:**

| | |
|---|---|
| **Aceptado** | La interrupción se simula dejando de insertar filas GPS en la BD durante el período definido. El instrumento de verificación es una prueba automatizada (Jest) que consulta el endpoint de posición tras la pausa y confirma que devuelve la última fila válida sin error y sin intervención del operador. "Sin intervención manual" se define como que ninguna acción humana es necesaria para que el endpoint responda. |
| **Descartado** | La IA sugirió Prometheus + Grafana como sistema de monitoreo de uptime para medir el 99.5%. Se descarta para este ciclo: la disponibilidad se verificará mediante health checks dentro de las pruebas de la semana 12, sin infraestructura de monitoreo dedicada. |

---

## Escenario 3 — Seguridad (trazabilidad de incidencias)

**Prompt enviado:**
> Actúa como abogada del diablo. Tengo este escenario de calidad y quiero que me preguntes, solo eso, con qué instrumento concreto se puede medir lo que dice la medida. [escenario completo]

**Crítica devuelta:**

| Pregunta de la IA | Instrumento sugerido por la IA |
|---|---|
| ¿Qué hace que una incidencia sea "crítica" — hay un umbral, un campo, una clasificación formal en el sistema? | Definir un valor numérico de `grado_severidad` como umbral y documentarlo en el código |
| ¿Con qué instrumento se verifica que los logs están "cifrados" — se consulta la BD directamente y se inspecciona el formato? | Consulta directa a la BD para verificar que los campos de auditoría no están en texto plano |
| ¿Cómo se mide que la notificación llegó en menos de 24 horas — hay un log de envío, un timestamp de recepción? | Tabla de notificaciones con `timestamp_envio` y `timestamp_lectura` consultable |

**Veredicto del equipo:**

| | |
|---|---|
| **Aceptado** | La IA identificó el problema central: el sistema no define formalmente qué es una incidencia "crítica". El equipo fija el umbral en `grado_severidad ≥ 8` (sobre 10). El instrumento es una consulta directa a la BD que verifique que `usuario_id` y `timestamp` no son nulos en todas las incidencias con ese umbral. |
| **Descartado** | La IA sugirió cifrar los registros de auditoría a nivel de columna en PostgreSQL. Se descarta: el escenario apunta a trazabilidad, no a cifrado en reposo. "Cifradas" se reinterpreta como registros no alterables con usuario responsable identificado, sin necesidad de cifrado de columna. |

---

## Escenario 4 — Mantenibilidad (modificación de reglas de negocio)

**Prompt enviado:**
> Actúa como abogada del diablo. Tengo este escenario de calidad y quiero que me preguntes, solo eso, con qué instrumento concreto se puede medir lo que dice la medida. [escenario completo]

**Crítica devuelta:**

| Pregunta de la IA | Instrumento sugerido por la IA |
|---|---|
| ¿Con qué instrumento se mide "1 día-persona" — es una estimación, un registro de horas, un conteo de commits con timestamps? | Registro manual de horas con timestamps en el commit de inicio y el commit de cierre del cambio |
| ¿"Sin downtime" se mide con un health check continuo durante el despliegue, o es una afirmación sin instrumento? | Health endpoint del sistema consultado continuamente durante el despliegue con un script |
| ¿La medida es reproducible — dos desarrolladores distintos harían el mismo cambio en el mismo tiempo? | Documentar los pasos exactos del cambio para que sea replicable como experimento |

**Veredicto del equipo:**

| | |
|---|---|
| **Aceptado** | "Sin downtime" se verifica con una prueba de disponibilidad continua sobre el health endpoint durante el proceso de despliegue. El tiempo se registra manualmente con timestamps en los commits de inicio y cierre como evidencia auditabl. |
| **Descartado** | La IA sugirió reemplazar "1 día-persona" por el tiempo de ejecución del pipeline de CI/CD. Se descarta: el tiempo del pipeline no incluye el tiempo de identificar y modificar el código, que es la parte que el escenario quiere medir. Son métricas distintas. |

---

## Escenario 5 — Capacidad de interacción (identificación visual sin capacitación)

**Prompt enviado:**
> Actúa como abogada del diablo. Tengo este escenario de calidad y quiero que me preguntes, solo eso, con qué instrumento concreto se puede medir lo que dice la medida. [escenario completo]

**Crítica devuelta:**

| Pregunta de la IA | Instrumento sugerido por la IA |
|---|---|
| ¿Con cuántos usuarios se valida — uno no es muestra suficiente para afirmar que el diseño cumple? | Mínimo 3 a 5 usuarios sin exposición previa al sistema |
| ¿Qué acción concreta define "identificar correctamente" — señalar en pantalla, nombrar el estado, hacer clic? | El usuario señala o nombra verbalmente el elemento con alerta activa sin recibir indicaciones |
| ¿Cómo se garantiza que el usuario es efectivamente "nuevo" para el sistema? | Reclutar participantes que no hayan visto el sistema y registrar esa condición antes de la prueba |

**Veredicto del equipo:**

| | |
|---|---|
| **Aceptado** | Se precisa la muestra mínima: al menos 3 usuarios sin exposición previa al sistema. "Identificar correctamente" se define como señalar o nombrar verbalmente el buque con alerta activa (color rojo) sin recibir indicaciones. El tiempo se mide con cronómetro desde que se muestra la pantalla. La condición de "usuario nuevo" se registra antes de la prueba. |
| **Descartado** | La IA sugirió eye-tracking para medir dónde mira el usuario primero. Se descarta: fuera del alcance del laboratorio. La prueba con cronómetro y observador es suficiente para el nivel de evidencia que pide el curso en la semana 12. |
