# Bitácora de uso de IA — Semana 12

## Contexto general

La semana 12 consistió en medir el rendimiento del escenario E2 (Fiabilidad GPS), identificar un cuello de botella, aplicar una mejora y documentar el experimento completo. La IA participó en todas las etapas como asistente de escritura y de código. A continuación se registra qué produjo la IA y qué decidió o corrigió el equipo en cada entrega.

---

## 1. `hipotesis.md`

**Lo que escribió la IA:**  
La IA propuso como cuello de botella el pool de conexiones de TypeORM, argumentando que con 50 VUs simultáneos el backend podría saturar su límite de conexiones antes de que PostgreSQL sintiera presión.

**Lo que corrigió el equipo:**  
El equipo redirigió el diagnóstico hacia la consulta SQL en sí: el `ORDER BY fecha_hora DESC` sin índice era la hipótesis más razonable dado que la tabla `posicioncontenedor` crece continuamente con señales GPS. La IA había saltado a una capa de infraestructura (pool) sin haber analizado primero el plan de ejecución de la consulta. El equipo reescribió la hipótesis apuntando a PostgreSQL y al `ORDER BY`, con una estimación de p95 ~450 ms que reflejaba el razonamiento basado en el dominio del sistema.

---

## 2. `carga/escenario.js`

**Lo que escribió la IA:**  
La IA generó un script k6 con una carga fija de 50 VUs × 5 min y un `setup()` que resolvía automáticamente el `id_contenedor` llamando a `/monitoreo/gps/contenedores`. También incluyó el threshold `p(95)<300` y `checks rate>0.99` directamente en el bloque `options`.

**Lo que corrigió el equipo:**  
El equipo validó que el `setup()` era la forma correcta de no hardcodear UUIDs del seed, pero añadió la opción de pasar `CONTENEDOR_ID` como variable de entorno para poder aislar un contenedor específico en pruebas puntuales. La IA había omitido ese caso de uso.

---

## 3. `docs/mediciones/informe.md` — Línea base y análisis del cuello de botella

**Lo que escribió la IA:**  
La IA redactó la estructura del informe (secciones 1, 2 y 3) y la explicación de por qué el índice compuesto `(id_contenedor, fecha_hora)` convierte la consulta en un `Index Scan Backward` de complejidad $O(\log N)$.

**Lo que corrigió el equipo:**  
La IA inicialmente explicó el índice como si fuera un descubrimiento nuevo hecho durante las pruebas. El equipo aclaró que el índice ya existía en el DDL desde semanas anteriores, y que por eso la hipótesis resultó equivocada: el sistema ya estaba optimizado y el cuello de botella hipotético nunca se materializó. Esta distinción es importante porque cambia el veredicto de "encontramos el cuello y lo resolvimos" a "nuestra hipótesis fue incorrecta y el experimento lo demostró", que es el resultado honesto.

---

## 4. Elección de la mejora (Paso 04)

**Lo que propuso la IA:**  
La IA identificó que `getPosicionesContenedores()` usaba `LIMIT 100` fijo sin `OFFSET`, y propuso paginarlo con `LIMIT $1 OFFSET $2`. La justificación fue que aunque el endpoint bajo prueba no cambiaba, la consulta de listado descargaba más datos de los necesarios en el `setup()` y en los paneles del mapa.

**Lo que decidió el equipo:**  
El equipo aceptó la mejora pero fue consciente de que no movería significativamente el p(95) del endpoint medido, ya que ese endpoint (`/contenedores/:id/ultima`) tiene su propia consulta indexada y no depende del listado. La decisión fue aplicarla de todas formas porque es una mejora defensiva válida para cuando el volumen de datos crezca, y porque cumple la regla de "un único cambio". El equipo rechazó la alternativa que la IA también sugirió internamente —agregar caché en Node.js con TTL— por considerarla un cambio de mayor riesgo que mezclaría dos variables en el experimento.

---

## 5. `docs/mediciones/informe.md` — Sección post-mejora y decisión

**Lo que escribió la IA:**  
La IA redactó la tabla comparativa, la nota sobre la variabilidad entre corridas (C2: 36.43 ms vs C3: 15.97 ms) y la sección 4.4 con la decisión de mantener la mejora.

**Lo que corrigió el equipo:**  
La IA en un primer borrador argumentó que el incremento de p(95) de 7 ms a 26 ms "no era significativo". El equipo exigió una explicación más honesta: reconocer que la paginación no redujo la latencia del endpoint medido, y que la diferencia entre corridas refleja variabilidad del entorno local y no el efecto de la mejora. La versión final distingue correctamente entre "la mejora no empeoró nada" y "la mejora resolvió el cuello de botella" — que son dos afirmaciones muy distintas.

---

## Patrón general observado

La IA fue útil para estructurar documentos, generar código TypeScript/SQL correcto y ejecutar las corridas de k6 de forma autónoma. Sus errores recurrentes fueron de tipo interpretativo: tendía a presentar los resultados de forma optimista (atribuir mejoras donde había variabilidad) y a omitir matices del dominio que el equipo conocía de semanas anteriores (como la existencia previa del índice). Las correcciones del equipo fueron siempre de orden lógico o de precisión en el diagnóstico, no de forma.
