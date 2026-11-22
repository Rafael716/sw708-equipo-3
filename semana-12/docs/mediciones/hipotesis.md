# Hipótesis de rendimiento

Escenario de la semana 2: E2 Fiabilidad — Pérdida de señal GPS
(Tabla 2.2 en `docs/arquitectura.md`). Artefacto: `GpsService`;
medida del escenario: disponibilidad ≥ 99,5 % y recuperación sin
perder historial. Para la prueba de carga usamos el endpoint de
lectura de la última posición válida, que es el camino caliente
del artefacto bajo concurrencia.

Creemos que el cuello de botella es PostgreSQL (consulta SQL a
`monitoreo.posicioncontenedor` con `ORDER BY fecha_hora DESC`, sin
caché en proceso — RN-11),
porque cada petición vuelve a ordenar/filtrar en la base y, con
varios operadores abriendo el panel a la vez, esas lecturas se
acumulan en el backend Nest (puerto 3001).

Esperamos un p95 de ~450 ms con 50 usuarios virtuales durante 5
minutos sobre `GET /monitoreo/gps/contenedores/:id/ultima`
(umbral de aceptación que usaremos en el script: p95 < 300 ms).
