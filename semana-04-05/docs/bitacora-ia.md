# Bitácora de uso de IA — Laboratorio, semanas 4 y 5

## 1. Declaración de la semana 5

**No se usó asistente de IA para elaborar el cuadro del costo del cambio ni para escribir el código de la rodaja vertical y su prueba de dominio.** Las mediciones, la implementación y las pruebas fueron responsabilidad del equipo.

## 2. Alternativas aportadas por la IA en los ADR y alternativas descartadas

Se utilizó **Claude** como apoyo para explorar alternativas arquitectónicas y tecnológicas. La evaluación de las opciones y la decisión definitiva fueron responsabilidad del equipo.

### ADR 001 — Estilo arquitectónico: monolito modular

Se consideraron tres alternativas:

* **Monolito modular (elegido):** organiza el sistema en módulos de dominio y esquemas de base de datos separados, manteniendo una única unidad de despliegue.
* **Monolito bola de barro (descartado):** se descartó por la falta de fronteras claras entre responsabilidades, que dificultaría el mantenimiento y aumentaría el riesgo de que los cambios afectaran varias partes del sistema.
* **Microservicios por módulo (descartado):** se descartaron por la complejidad adicional de gestionar múltiples servicios, contratos, despliegues y posibles fallos de comunicación, sin evidencia de que el sistema necesitara ese aislamiento operativo.

La elección del monolito modular se relacionó con el escenario de mantenibilidad y los resultados del costo del cambio de las versiones A y B.

### ADR 002 — Stack de lenguaje: TypeScript con NestJS y Next.js

Se consideraron tres alternativas:

* **TypeScript con NestJS y Next.js (elegida):** permite utilizar TypeScript en backend y frontend, manteniendo tipado y organización modular.
* **Java con Spring Boot y una interfaz separada (descartada):** se descartó porque introducir una nueva plataforma tecnológica aumentaría la curva de aprendizaje y el tiempo necesario para disponer de una interfaz funcional.
* **Python con Django o FastAPI y frontend JavaScript sin TypeScript (descartada):** se descartó porque perdería el tipado compartido entre la API y la interfaz y debilitaría la estructura modular buscada.

La elección final se fundamentó en el stack existente en el proyecto, la coherencia con el monolito modular y la necesidad de facilitar el desarrollo y mantenimiento del sistema.

## 3. Uso de IA en la documentación

Claude también se utilizó para organizar y mejorar la redacción de `docs/bitacora-ia.md`, manteniendo la documentación coherente con las decisiones arquitectónicas registradas en `docs/adr/`.

## 4. Declaración de uso responsable

Claude se utilizó como apoyo para explorar alternativas y organizar la documentación. La selección de las opciones definitivas, la evaluación de las alternativas descartadas y la justificación técnica de las decisiones correspondieron al equipo.

Se mantiene expresamente la declaración de la semana 5: **no se usó asistente para el cuadro del costo del cambio ni para la rodaja vertical**.
