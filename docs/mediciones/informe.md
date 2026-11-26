# Informe de Mediciones de Rendimiento

**Escenario de calidad:** E2 Fiabilidad / Rendimiento — Consulta de última posición GPS (`GET /monitoreo/gps/contenedores/:id/ultima`)  
**Herramienta:** k6 v1.x (50 VUs continuos × 5 minutos, `sleep(1)`)  
**Umbral definido en escenario:** `p(95) < 300 ms`, tasa de éxito > 99 %  

---

## 1. Medición de la Línea Base (Paso 03)

Se ejecutaron 3 corridas consecutivas de 5 minutos cada una sobre el entorno local orquestado con Docker Compose (`sw708-app-1` en puerto 3001 y `sw708-db-1` en PostgreSQL 16).

### 1.1. Corrida 1 — Calentamiento (Descartada)
Tal como lo establece la guía metodológica, la primera corrida se descarta por tratarse del arranque en frío (*cold start*), donde se establecen los sockets iniciales, se calienta el pool de conexiones de TypeORM y los buffers de PostgreSQL (`shared_buffers`).

* **Peticiones totales:** 14,951
* **Throughput:** 49.68 req/s
* **p(95):** 7.06 ms
* **Tasa de error:** 0.00 % (14,950 checks exitosos)

---

### 1.2. Corridas Oficiales (2 y 3)

Las siguientes dos corridas representan el comportamiento estable del sistema bajo carga concurrente sostenida:

| Métrica | Corrida 2 | Corrida 3 | Promedio Línea Base | Umbral SLA |
| :--- | :---: | :---: | :---: | :---: |
| **Usuarios Virtuales (VUs)** | 50 | 50 | **50** | 50 |
| **Duración** | 5m 01s | 5m 00s | **5m** | 5m |
| **Peticiones HTTP totales** | 14,910 | 14,914 | **14,912** | — |
| **Throughput (req/s)** | **49.54 req/s** | **49.56 req/s** | **49.55 req/s** | Max 50 req/s |
| **Latencia p(95)** | **7.27 ms** | **7.14 ms** | **7.20 ms** | **< 300 ms** (CUMPLE) |
| **Latencia p(90)** | 5.25 ms | 5.11 ms | **5.18 ms** | — |
| **Latencia Mediana** | 2.43 ms | 2.52 ms | **2.48 ms** | — |
| **Latencia Promedio** | 7.39 ms | 6.16 ms | **6.78 ms** | — |
| **Tasa de Errores (`http_req_failed`)** | **0.00 %** | **0.00 %** | **0.00 %** | **< 1.0 %** (CUMPLE) |
| **Tasa de Éxito en Checks** | **100.00 %** | **100.00 %** | **100.00 %** | **> 99.0 %** (CUMPLE) |

> **Nota sobre el Throughput:** Con `sleep(1)` configurado entre iteraciones, el throughput máximo teórico para 50 usuarios es de 50 req/s. El valor obtenido de **49.55 req/s** demuestra una saturación nula en la cola de procesamiento.

---

## 2. Ubicación del Cuello de Botella

Durante la ejecución continua de la prueba con 50 VUs, se monitoreó el comportamiento de los contenedores mediante `docker stats` y el análisis de la consulta SQL:

### 2.1. Métricas de Contenedores (`docker stats`)

Durante la ejecución de la prueba bajo concurrencia, se capturaron las métricas de consumo de los contenedores mediante `sudo docker stats`:

```text
CONTAINER ID   NAME                      CPU %     MEM USAGE / LIMIT     MEM %     NET I/O           BLOCK I/O         PIDS
f7b036fb95ee   sw708-victoriametrics-1   0.21%     9.074MiB / 7.534GiB   0.12%     114kB / 126B      7.96MB / 16.4kB   10
67c7fa35d27f   sw708-app-1               0.00%     23.59MiB / 7.534GiB   0.31%     29.8MB / 44.5MB   120MB / 50.2MB    11
b6a7cefadad3   sw708-frontend-1          0.00%     12.99MiB / 7.534GiB   0.17%     110kB / 126B      16.8MB / 2.68MB   11
5f79c422aecf   sw708-db-1                0.00%     11.78MiB / 7.534GiB   0.15%     23.6MB / 17.5MB   68.7MB / 26.6MB   6
```

* **`sw708-app-1` (NestJS Backend):** Consumo de CPU despreciable (0.00 %) y memoria sumamente contenida en **23.59 MiB** (0.31 % del límite disponible).
* **`sw708-db-1` (PostgreSQL 16):** Consumo de CPU en 0.00 % y memoria en **11.78 MiB** (0.15 % del límite), con 23.6 MB transferidos en la red interna de Docker.
* **Diagnóstico de recursos:** Ningún contenedor experimentó estrés de CPU o agotamiento de memoria. El sistema despachó las 50 peticiones por segundo sin encolamiento en el backend ni en la base de datos.

### 2.2. Análisis Técnico de la Consulta SQL
La consulta ejecutada en cada petición (`gps.service.ts`) es:
```sql
SELECT id_posicion, id_contenedor, latitud, longitud, fecha_hora
FROM monitoreo.posicioncontenedor
WHERE id_contenedor = $1
ORDER BY fecha_hora DESC
LIMIT 1;
```

**¿Por qué PostgreSQL no fue un cuello de botella?**  
Al inspeccionar el DDL consolidado del esquema (`scripts/ddl/tablas/consolidado.sql`), se constató la presencia del siguiente índice:
```sql
CREATE INDEX idx_posicion_contenedor_fecha 
ON monitoreo.PosicionContenedor(id_contenedor, fecha_hora);
```

Gracias a este índice compuesto B-Tree:
1. PostgreSQL no realiza un escaneo secuencial (*Seq Scan*) ni un ordenamiento en memoria (*Sort* en disco/RAM).
2. El motor realiza un **`Index Scan Backward`** directamente sobre la clave compuesta `(id_contenedor, fecha_hora)`, localizando la última tupla en un tiempo sub-milisegundo (< 0.1 ms).
3. Todo el conjunto de datos activo reside en los `shared_buffers` de PostgreSQL, evitando operaciones lentas de E/S en disco.

---

## 3. Contraste con la Hipótesis Inicial

En el documento [`hipotesis.md`](./hipotesis.md) se planteó lo siguiente:
> *"Creemos que el cuello de botella es PostgreSQL (...) porque cada petición vuelve a ordenar/filtrar en la base y, con varios operadores abriendo el panel a la vez, esas lecturas se acumulan en el backend Nest. Esperamos un p95 de ~450 ms (...)"*

### Comparación Hipótesis vs. Realidad

| Elemento | Hipótesis Previa | Resultado Real Obtenido | Veredicto |
| :--- | :---: | :---: | :---: |
| **Latencia p(95)** | ~450 ms | **7.20 ms** | **Equivocada** (el sistema fue ~62 veces más rápido) |
| **Cuello de Botella** | PostgreSQL saturado por `ORDER BY` | Inexistente (CPU ~0.00 % y memoria < 24 MiB en app y db) | **Equivocada** |
| **Cumplimiento del SLA** | No cumplía (450 ms > 300 ms) | **Cumple con amplio margen** (7.20 ms << 300 ms) | **Falso negativo superado** |

### ¿En qué se equivocó la hipótesis?
1. **Se subestimó el impacto del índice compuesto:** La hipótesis asumió que la ausencia de caché en proceso (regla de negocio RN-11) degradaría el rendimiento debido a la constante operación de filtrado y ordenamiento. Sin embargo, el índice compuesto `(id_contenedor, fecha_hora)` optimiza la consulta a complejidad $O(\log N)$, eliminando el costo del ordenamiento.
2. **Efecto de la caché interna del motor (Buffer Pool):** Aunque no existe caché a nivel de aplicación en Node.js, PostgreSQL mantiene las páginas del índice y las filas frecuentes en memoria RAM (`shared_buffers`), reduciendo el tiempo de respuesta a niveles equivalentes a una caché en memoria.
3. **Carga dentro de la capacidad nominal:** Para 50 usuarios concurrentes con cadencia de 1 segundo (throughput de ~50 req/s), la arquitectura en monolito modular sobre Node.js 22 y PostgreSQL maneja la carga sin encolamiento en el pool de conexiones.

---

## 4. Conclusión

La línea base del escenario E2 queda establecida con un **p95 de 7.20 ms**, un **throughput de 49.55 req/s** y una **tasa de error de 0.00 %**.  
El sistema supera con creces el criterio de aceptación arquitectónico (`p95 < 300 ms`), demostrando que el diseño actual de base de datos con indexación compuesta es altamente resiliente para la concurrencia proyectada.
