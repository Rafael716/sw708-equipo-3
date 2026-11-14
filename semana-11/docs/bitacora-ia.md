# Bitácora de IA — Semana 11 (resiliencia)

Registro de qué salió de la IA y qué decidió el equipo en el laboratorio de circuit breaker y timeout.

## Implementación

| Origen | Qué |
|---|---|
| **IA (borrador)** | Envoltorio `CircuitoDependencia` sobre opossum, cableado en `VictoriaMetricsService`, endpoint de diagnóstico `GET /monitoreo/vm/estado-circuitos` y esqueleto de pruebas. |
| **Equipo** | La dependencia a proteger es VictoriaMetrics, no la base de datos: es la única llamada HTTP externa y su caída no debe tumbar el panel ni fingir una sincronización. |
| **Equipo** | Dos circuitos separados (lectura y escritura) con la misma configuración, porque la respuesta degradada correcta es distinta en cada caso. |
| **Equipo** | `AbortSignal.timeout` en el `fetch` además del timeout de opossum: sin abortar la conexión, el socket queda vivo y el timeout solo tapa el problema. |
| **Equipo** | Los `4xx` de VictoriaMetrics se filtran con `errorFilter`: son un defecto de nuestra petición, no una caída del proveedor. Un PromQL mal armado no debe abrir el circuito. |

## Valores y su motivo (decisión del equipo)

Ningún número se copió de un tutorial. Se fijaron con el tráfico real de la demo, el panel que los consume y el tiempo que tarda VictoriaMetrics en reiniciar dentro de `docker compose`.

| Valor | Decisión | Motivo |
|---|---|---|
| **2000 ms** de timeout | El equipo bajó el valor típico de tutoriales (10 s) | La consulta devuelve como máximo 8760 puntos (~0,3 MB) en red interna; 2 s es ~10× el tiempo esperado y sigue dentro del presupuesto de 3 s del panel. Esperar 10 s no cambia la decisión del usuario: ya reintentó. |
| **50 %** de errores | Se mantuvo el umbral, pero con mínimo de llamadas | Para una dependencia de lectura auxiliar, abrir con 3 de cada 5 fallos exige que el problema persista; un solo timeout de arranque no abre. |
| **5 llamadas** mínimas | El equipo subió el mínimo (opossum trae 0) | Sin mínimo, la primera llamada fallida es 100 % de error y abre el circuito por una casualidad. Cinco llamadas reflejan varias acciones reales del operador en la ventana. |
| **10 s** de ventana | Se redujo el valor típico (60 s) | La ventana debe describir el estado actual. 10 s evita que fallos viejos mantengan el circuito abierto y encaja con la espera de 15 s. |
| **15 s** abierto | Se eligió entre 5 y 30 s | Un reinicio de VictoriaMetrics en compose tarda 5–10 s; 15 s cubre el arranque. 5 s generaría sondas durante el reinicio; 30 s dejaría el panel degradado sin necesidad. |
| **200 con serie vacía** en lectura | El equipo descartó el 503 genérico | Una gráfica sin datos es un estado válido y el panel ya lo maneja. El 503 se reserva para la escritura, donde fingir éxito sí engaña al operador. |
| **503 con `reintentarEnMs`** en escritura | El equipo descartó devolver 200 | La sincronización es un comando: si no llegó a VictoriaMetrics, el cliente debe saberlo y saber cuándo reintentar. |

## Pruebas

| Origen | Qué |
|---|---|
| **IA (borrador)** | Casos de prueba del envoltorio y del servicio con `fetch` simulado. |
| **Equipo** | Casos que importan para la operación: no abrir por debajo del mínimo, no generar tráfico con el circuito abierto, recuperación por media apertura, timeout degradado y `4xx` que no abren el circuito. |

## Criterio del equipo

La IA aceleró el cableado y los borradores de prueba. El equipo decidió **qué** se protege, **qué** responde cada ruta en degradación y **por qué** cada número es el que es. La justificación completa está en [`docs/resiliencia.md`](../../docs/resiliencia.md).
