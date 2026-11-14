# Resiliencia: circuit breaker y timeout sobre VictoriaMetrics

## 1. Qué dependencia se protegió y por qué

La única dependencia externa que el backend consume por HTTP es **VictoriaMetrics**, el almacén de series de tiempo que alimenta la demo de temperatura de contenedores y la sincronización de lecturas de sensores.

| Uso | Ruta | Tipo | Qué pasa si VictoriaMetrics no responde |
|---|---|---|---|
| Consulta de temperatura | `GET /monitoreo/vm/temperatura/:contenedorId` | lectura | El panel se queda esperando o falla la gráfica |
| Sincronización de lecturas | `POST /monitoreo/vm/sync-lecturas/sensor/:sensorId` | escritura | El operador cree que exportó lecturas que en realidad no llegaron |

No se escribió un circuit breaker a mano: se usa **opossum** (`opossum@^8.1.4`, ya declarado en `backend/package.json`), una librería mantenida con ventana deslizante de errores, estados cerrado/abierto/media apertura y fallback.

Código:

- `backend/src/shared/resiliencia/circuito-dependencia.ts` — envoltorio delgado sobre opossum y diagnóstico.
- `backend/src/shared/resiliencia/dependencia-no-disponible.error.ts` — error de dependencia caída, sin acoplar el servicio al contrato HTTP de Nest.
- `backend/src/monitoreo/services/victoriametrics.service.ts` — aplicación del patrón a VictoriaMetrics.
- `backend/src/monitoreo/controllers/vm-demo.controller.ts` — traducción a la respuesta HTTP definida.

El **timeout** está en dos capas a propósito:

1. `fetch(..., { signal: AbortSignal.timeout(2000) })` cancela la conexión HTTP y libera el socket.
2. El `timeout` de opossum actúa como respaldo lógico del breaker y contabiliza el fallo en la ventana.

Solo con el timeout de opossum, la promesa se rechaza pero la conexión HTTP puede seguir viva; por eso el `AbortSignal` es parte del cliente y no un adorno.

## 2. Valores elegidos y su motivo

Valores por defecto en `VALORES_RESILIENCIA_VM` (`victoriametrics.service.ts`). Todos se pueden ajustar por entorno sin recompilar.

| Parámetro | Valor | Variable de entorno | Por qué ese valor |
|---|---|---|---|
| Timeout de respuesta | **2000 ms** | `VICTORIA_METRICS_TIMEOUT_MS` | La consulta de la demo pide como máximo 8760 puntos (1 año a paso de 1 h, ~0.3 MB). En la red interna de Docker eso son decenas de ms; 2 s da ~10× de margen para un arranque en frío o un host cargado. El panel muestra un spinner y el usuario reintenta a los pocos segundos: esperar más de 2 s no mejora la decisión, solo alarga la degradación. |
| Porcentaje de errores | **50 %** | `VICTORIA_METRICS_CIRCUIT_ERROR_PERCENTAGE` | Es una dependencia de solo lectura para la demo. Abrir con la mitad de las llamadas fallando exige que el problema persista (no un pico aislado) y evita abrir por un único timeout de arranque. Con el mínimo de 5 llamadas, hacen falta al menos 3 fallos (60 %) para abrir. |
| Mínimo de llamadas en la ventana | **5** | `VICTORIA_METRICS_CIRCUIT_MIN_CALLS` | Evita el clásico "una llamada falló = 100 % de error". Cinco llamadas corresponden a varias pulsaciones del botón "Ver temperatura" y a un sync manual dentro de la ventana: si fallan, no fue casualidad. |
| Ventana de estadísticas | **10 s** | `VICTORIA_METRICS_CIRCUIT_WINDOW_MS` | Los fallos de hace un minuto no describen el estado actual de la dependencia. Con 10 s la decisión usa solo el presente inmediato y encaja con la espera de 15 s: al reabrir, la ventana ya está limpia. Los 10 buckets internos dan granularidad de 1 s. |
| Tiempo abierto antes de probar | **15 s** | `VICTORIA_METRICS_CIRCUIT_RESET_MS` | Un reinicio de VictoriaMetrics en `docker compose` tarda del orden de 5–10 s en volver a aceptar escrituras. 15 s cubre ese reinicio con margen y evita sondas mientras el servicio aún está levantando. Un valor de 5 s reabriría el circuito durante el arranque; 30 s o más dejaría el panel degradado demasiado tiempo por un hipo pasajero. Pasado ese tiempo el circuito pasa a **media apertura** y deja pasar una sola llamada de prueba. |
| Respuesta durante la espera | ver §3 | — | Se definió una respuesta distinta para lectura y escritura, porque no es lo mismo "no hay datos que mostrar" que "no se guardó lo que pediste". |
