# Bitácora de uso de IA — Laboratorio semanas 4 y 5

## Herramienta de IA utilizada

Se utilizó **Claude** como apoyo para comprender las instrucciones del laboratorio, organizar la documentación del uso de IA y generar alternativas que pudieran evaluarse en las decisiones arquitectónicas documentadas mediante ADR (*Architecture Decision Records*).

El uso de IA relacionado con las decisiones arquitectónicas se limitó a la **generación de alternativas**. La evaluación de las opciones, la selección de la decisión final, la refutación de las alternativas descartadas y la redacción de las consecuencias corresponden al equipo.

La IA no se utilizó como sustituto de la experimentación ni de la implementación realizada por el equipo.

## Qué se le pidió a la IA

1. **Comprender las actividades y restricciones del laboratorio.** Se consultó la consigna de las semanas 4 y 5 para distinguir las actividades en las que estaba permitido utilizar IA de aquellas que debían realizarse directamente por el equipo.

2. **Generar alternativas para el ADR de elección del estilo arquitectónico.** Se consideraron posibles formas de organizar las responsabilidades del sistema y dirigir las dependencias entre sus componentes. Entre los enfoques que pueden evaluarse se encuentran una estructura con responsabilidades fuertemente acopladas, una arquitectura por capas y una arquitectura hexagonal o de puertos y adaptadores. Estas opciones deben conservarse en el ADR únicamente si fueron propuestas y evaluadas efectivamente por el equipo.

3. **Generar alternativas para el segundo ADR.** La IA podía sugerir opciones relacionadas con una decisión tecnológica ya existente en el proyecto, por ejemplo, el lenguaje de programación, la base de datos, el mecanismo de autenticación o la estrategia de despliegue. La decisión concreta y las alternativas consideradas deben corresponder al segundo ADR real del equipo.

4. **Organizar la bitácora de uso de IA.** Se utilizó ChatGPT para mejorar la redacción de `docs/bitacora-ia.md`, ordenar la información por secciones y documentar de forma explícita el alcance del apoyo recibido.

## Qué se aceptó

* La organización de la bitácora en secciones que permiten distinguir el propósito de las consultas, las alternativas consideradas, las decisiones tomadas por el equipo y las actividades realizadas sin asistencia de IA.

* El uso de la IA como generadora de opciones para los dos ADR, sin delegarle la decisión arquitectónica definitiva.

* La necesidad de fundamentar el ADR obligatorio con el escenario de calidad definido en la semana 2 y con los resultados de la medición del costo del cambio, en lugar de elegir un estilo únicamente por preferencia personal.

* La separación entre las alternativas sugeridas por la IA y las decisiones efectivamente tomadas por el equipo. Una alternativa sugerida no se considera aceptada hasta que el equipo la evalúa y decide conservarla.

* La documentación explícita de las alternativas descartadas y de las razones para descartarlas. La justificación definitiva debe basarse en el contexto del sistema, los requisitos de calidad y la evidencia disponible.

## Qué se evaluó y corrigió

* **Adecuación de las alternativas arquitectónicas:** las opciones propuestas deben compararse con las necesidades reales del sistema y con el escenario de calidad elegido. No basta con que un estilo sea conocido o habitual; debe responder a las necesidades concretas del proyecto.

* **Coherencia con la evidencia del costo del cambio:** el ADR obligatorio debe considerar los resultados obtenidos al implementar el mismo requisito en las versiones A y B del caso de estudio. La interpretación de los resultados corresponde al equipo y debe coincidir con los valores registrados en `docs/costo-del-cambio.md`.

* **Diferenciación entre sugerencia y decisión:** las propuestas de la IA no constituyen decisiones definitivas. El equipo debe justificar la opción elegida y explicar por qué las alternativas descartadas no responden tan bien al contexto.

* **Consecuencias de la decisión:** la sección de consecuencias de cada ADR debe redactarse por una persona del equipo. Debe contemplar tanto los beneficios como los costos, riesgos o limitaciones de la decisión adoptada.

* **Correspondencia con los ADR versionados:** los nombres de las alternativas aceptadas y descartadas en esta bitácora deben coincidir con las alternativas realmente registradas en los archivos de `docs/adr/`.

## Archivos y actividades relacionados con el uso de IA

### `docs/adr/`

Sección destinada a los dos registros de decisiones arquitectónicas del laboratorio:

* **ADR de elección del estilo arquitectónico:** la IA se utiliza para generar alternativas. El equipo debe relacionar la decisión final con el escenario de calidad de la semana 2 y con la evidencia de `docs/costo-del-cambio.md`.

* **Segundo ADR:** la IA puede proponer alternativas para la decisión tecnológica o arquitectónica que el equipo ya haya identificado en su sistema. El título, las opciones y la decisión final deben corresponder al archivo real.

La IA no sustituye el juicio del equipo ni redacta por cuenta propia las consecuencias definitivas de las decisiones.

### `docs/costo-del-cambio.md`

**No se utilizó IA para realizar las mediciones ni para elaborar los resultados del cuadro.** Los tiempos, archivos modificados, líneas agregadas y eliminadas, pruebas que se rompieron durante el proceso y lugares consultados antes de localizar el cambio deben provenir del trabajo realizado por el equipo.

La tabla y la conclusión deben sustentarse en las mediciones reales de las versiones A y B.

### Código de la rodaja vertical y prueba de dominio

**No se utilizó IA para escribir el código de la rodaja vertical ni su prueba de dominio.** La implementación corresponde al equipo.

La solución debe mantener las dependencias dirigidas hacia el dominio y permitir que la prueba de dominio se ejecute sin necesidad de levantar una base de datos.

## Declaración de uso responsable

La IA se utilizó como apoyo para explorar alternativas arquitectónicas y organizar la documentación, manteniendo la responsabilidad de las decisiones en el equipo.

Se declara expresamente que **no se usó asistente para el cuadro del costo del cambio ni para escribir el código de la rodaja vertical**. Las mediciones, la implementación y las pruebas corresponden al trabajo realizado por el equipo.

La bitácora debe coincidir con el uso real de IA y con el contenido definitivo de los dos ADR versionados en el repositorio.
